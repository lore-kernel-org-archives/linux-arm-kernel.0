From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 29 Apr 2016 11:18:43 +1000
Subject: linux-next: manual merge of the pm tree with the arm-soc tree
Message-ID: <20160429111843.456c713f@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

Today's linux-next merge of the pm tree got a conflict in:

  MAINTAINERS

between commit:

  e269777f72b3 ("MAINTAINERS: attach arch/arm/configs/mvebu_*_defconfig to relevant maintainers")

from the arm-soc tree and commit:

  9f123def55d3 ("cpufreq: mvebu: Move cpufreq code into drivers/cpufreq/")

from the pm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc MAINTAINERS
index e7ad57a3c1f5,0bb566e7df9b..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -1328,8 -1322,9 +1328,9 @@@ F:	drivers/rtc/rtc-armada38x.
  F:	arch/arm/boot/dts/armada*
  F:	arch/arm/boot/dts/kirkwood*
  F:	arch/arm64/boot/dts/marvell/armada*
 +F:	arch/arm/configs/mvebu_*_defconfig
+ F:	drivers/cpufreq/mvebu-cpufreq.c
  
 -
  ARM/Marvell Berlin SoC support
  M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
  L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
