From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 28 Jan 2016 18:02:26 +0100
Subject: [PATCH 0/3] UEFI stub pre-boot compat checks
Message-ID: <1454000549-9189-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As discussed earlier today [1], and last year [2], it makes sense for the
UEFI stub to perform some basic checks on the hardware for missing features
that would prevent the kernel from booting to a state where it can even
complain about this.

So implements this for ARM, to check on LPAE builds whether the CPU supports
it (patch #1), and for arm64, to check whether the build time granule is
implemented by the CPU (patch #2). Patch #3 wires it up into the shared init
code.

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/472880
[2] http://thread.gmane.org/gmane.linux.ports.arm.kernel/447370

Ard Biesheuvel (3):
  ARM: efistub: check for LPAE support before booting a LPAE kernel
  arm64: efistub: check for h/w support before booting a >4 KB granule
    kernel
  ARM/arm64: efistub: perform hardware compatibility check

 drivers/firmware/efi/libstub/arm-stub.c   |  4 ++++
 drivers/firmware/efi/libstub/arm32-stub.c | 17 +++++++++++++++++
 drivers/firmware/efi/libstub/arm64-stub.c | 20 ++++++++++++++++++++
 drivers/firmware/efi/libstub/efistub.h    |  2 ++
 4 files changed, 43 insertions(+)

-- 
2.5.0
