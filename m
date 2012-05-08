From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 8 May 2012 17:21:53 +1000
Subject: linux-next: manual merge of the arm-soc tree with the crypto tree
Message-ID: <20120508172153.b05c9d198b1b81c652a2bde6@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/char/hw_random/Kconfig between commit 028fdd87b79a ("hwrng:
Kconfig - modify default state for atmel-rng driver") from the crypto
tree and commit 1234f4bada54 ("hwrng: Kconfig: remove dependency for
atmel-rng driver") from the arm-soc tree.

Juts context changes.  I fixed it up (see below) and can carry the fix as
necessary.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/char/hw_random/Kconfig
index 8cd64f1,b2402eb..0000000
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@@ -62,8 -62,8 +62,8 @@@ config HW_RANDOM_AM
  
  config HW_RANDOM_ATMEL
  	tristate "Atmel Random Number Generator support"
- 	depends on HW_RANDOM && ARCH_AT91SAM9G45
+ 	depends on HW_RANDOM && HAVE_CLK
 -	default HW_RANDOM
 +	default (HW_RANDOM && ARCH_AT91)
  	---help---
  	  This driver provides kernel-side support for the Random Number
  	  Generator hardware found on Atmel AT91 devices.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120508/8d07940d/attachment-0001.sig>
