From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 10 Nov 2014 19:47:00 +0100
Subject: [PATCH v2 0/2] preserve FDT blob and present as /sys/firmware/fdt
Message-ID: <1415645222-14909-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Meh, I am not necessarily a lot happier with this version, now split into a
generic and a arch specific part, but it addresses Grant's concerns with
respect to modification, without resorting to checksums.

Checksums only solve half of the problem, because /not/ presenting the
blob at all if the checksum is incorrect is not really an option imo.

Ard Biesheuvel (2):
  of/fdt: export fdt blob as /sys/firmware/fdt
  arm64: fdt: call preserve_fdt() before unflattening it

 arch/arm64/kernel/head.S  |  3 +++
 arch/arm64/kernel/setup.c |  1 +
 drivers/of/fdt.c          | 34 ++++++++++++++++++++++++++++++++++
 include/linux/of_fdt.h    |  2 ++
 4 files changed, 40 insertions(+)

-- 
1.8.3.2
