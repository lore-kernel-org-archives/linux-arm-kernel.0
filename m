From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 4 Apr 2016 18:16:05 +0300
Subject: [PATCH 0/8] ARM: dts: fixes for DT warnings on OMAP2+ platforms
Message-ID: <1459782973-21201-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This set fixes the clock node related warnings for OMAP2+ platforms
that are going to be introduced with the new version of DTC that
does stricter checks on DT structure. Basically, the address component
is currently missing on the node names that have a reg properly, which
is illegal.

Set applied on top of 4.6-rc2. Pushed branch here also:

tree: https://github.com/t-kristo/linux-pm.git
branch: 4.6-rc2-clk-dt-warn-fixes

Boot tested on following boards:

  : Board           : Boot WRN version                 
 1: am335x-evm      : PASS   0 4.6.0-rc2-00008-gadb720d
 2: am335x-evmsk    : PASS   0 4.6.0-rc2-00008-gadb720d
 3: am3517-evm      : PASS   1 4.6.0-rc2-00008-gadb720d
 4: am37x-evm       : PASS   0 4.6.0-rc2-00008-gadb720d
 5: am437x-sk       : PASS   0 4.6.0-rc2-00008-gadb720d
 6: am43x-epos-evm  : FAIL   0 4.6.0-rc2-00008-gadb720d
 7: am437x-gp-evm   : PASS   0 4.6.0-rc2-00008-gadb720d
 8: am57xx-evm      : PASS   0 4.6.0-rc2-00008-gadb720d
 9: omap3-beagle-xm : PASS   0 4.6.0-rc2-00008-gadb720d
10: omap3-beagle    : PASS   0 4.6.0-rc2-00008-gadb720d
11: am335x-boneblack: PASS   0 4.6.0-rc2-00008-gadb720d
12: am335x-bone     : PASS   0 4.6.0-rc2-00008-gadb720d
13: craneboard      : PASS   1 4.6.0-rc2-00008-gadb720d
14: dra72x-evm      : PASS   0 4.6.0-rc2-00008-gadb720d
15: dra7xx-evm      : PASS   0 4.6.0-rc2-00008-gadb720d
16: ldp3430         : PASS   0 4.6.0-rc2-00008-gadb720d
17: omap3-n900      : FAIL   0                         
18: omap5-uevm      : FAIL   0                         
19: omap4-panda-es  : PASS   0 4.6.0-rc2-00008-gadb720d
20: omap4-panda     : PASS   0 4.6.0-rc2-00008-gadb720d
21: omap2430-sdp    : PASS   0 4.6.0-rc2-00008-gadb720d
22: omap3430-sdp    : PASS   0 4.6.0-rc2-00008-gadb720d
23: omap4-sdp-es23plus: PASS   0 4.6.0-rc2-00008-gadb720d
TOTAL = 23 boards, Booted Boards = 20, No Boot boards = 3

The boot failures detected are caused by board defects on the test
farm I am using, except for the am43xx-epos, which is a known issue
(syntimer fix still missing from -rc2.)

Also ran a quick suspend/resume test on omap3/omap4 and that seems
to be working fine also.

-Tero
