From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 29 Feb 2012 16:16:27 +1100
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
Message-ID: <20120229161627.b8dd92287d066cd7c0a0284e@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
arch/arm/Kconfig between commit 6905a65879b5 ("ARM: Make the sched_clock
framework mandatory") from the arm tree and commit 4a8f83409da6 ("ARM:
sa1100: clean up clock support") from the arm-soc tree.

Just context changes.  I fixed it up (see below) and can carry the fix as
necessary.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/Kconfig
index 5130989,9f134c4..0000000
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@@ -753,7 -760,8 +753,7 @@@ config ARCH_SA110
  	select ARCH_HAS_CPUFREQ
  	select CPU_FREQ
  	select GENERIC_CLOCKEVENTS
- 	select HAVE_CLK
+ 	select CLKDEV_LOOKUP
 -	select HAVE_SCHED_CLOCK
  	select TICK_ONESHOT
  	select ARCH_REQUIRE_GPIOLIB
  	select HAVE_IDE
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120229/14bcdab1/attachment.sig>
