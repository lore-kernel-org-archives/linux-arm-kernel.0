From: jwboyer@fedoraproject.org (Josh Boyer)
Date: Fri, 6 Sep 2013 22:44:33 -0400
Subject: crypto/xor.ko fails to build with CONFIG_KERNEL_MODE_NEON=y
Message-ID: <CA+5PVA6iUcY+DCh51R_uwxZ1BOGrS-8-OfaFTF6Bwz9JFDVcUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

We enabled CONFIG_KERNEL_MODE_NEON on the armv7hl builds we're doing.
It builds for a while, but eventually fails when running modpost on
the xor.ko module:

ERROR: "xor_block_neon_inner" [crypto/xor.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

I tried adding an EXPORT_SYMBOL_GPL(xor_block_neon_inner); after the
structure definition in arch/arm/lib/xor-neon.c but that doesn't seem
to have done anything.

Before I go chasing this further, I'm curious if anyone else has run into this.

josh
