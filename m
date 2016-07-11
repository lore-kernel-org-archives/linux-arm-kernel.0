From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 11 Jul 2016 21:00:44 +0200
Subject: [PATCH v2 0/2] efi/arm*: wire up ESRT table
Message-ID: <1468263646-28184-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This v2 is a followup to the series I sent out on Feb 15. These now
apply onto Matt's memmap refactoring work which is intended for inclusion
in v4.9, and the diffstat below reveals that enabling ESRT is now absolutely
trivial. The only things needed are replacing ioremap() with memremap(),
and adding the missing efi_esrt_init() invocation.

I dropped the Tested-by tags, simply because the underlying code is completely
different now. I kept Peter's ack on #1, though.

Ard Biesheuvel (2):
  efi: esrt: use memremap not ioremap to access ESRT table in memory
  efi/arm*: esrt: add missing call to efi_esrt_init()

 drivers/firmware/efi/arm-init.c | 1 +
 drivers/firmware/efi/esrt.c     | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
1.9.1
