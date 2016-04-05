From: s-anna@ti.com (Suman Anna)
Date: Tue, 5 Apr 2016 16:44:08 -0500
Subject: [PATCH 0/4] DRA7 Timer extended support
Message-ID: <1459892652-47845-1-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

Following series includes couple of patches to add the missing
Timer12 and enable Timers 13 through 16 by default, and a timer
errata fix on DRA7 platforms.  The Timer errata is documented in
the public AM572x Silicon Errata document [1].

Patches 2 and 3 were reposted versions of the two patches left
out from the DRA7 Timer12 Support series [1] from last year.
Only difference is in Patch 2 where the node is not marked
as disabled anymore compared to the previous version [3]

Patches baselined on 4.6-rc2.

regards
Suman

[1] http://www.ti.com/lit/er/sprz429h/sprz429h.pdf
[2] http://marc.info/?l=linux-omap&m=144408774017569&w=2
[3] https://patchwork.kernel.org/patch/7332221/

Keerthy (1):
  ARM: DRA7: clockdomain: Implement timer workaround for errata i874

Suman Anna (3):
  ARM: dts: DRA7: Enable Timers 13 through 16
  ARM: dts: DRA7: Add timer12 node
  ARM: DRA7: hwmod: Add data for GPTimer 12

 arch/arm/boot/dts/dra7.dtsi                | 13 +++++++----
 arch/arm/mach-omap2/clockdomains7xx_data.c |  2 +-
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c  | 36 ++++++++++++++++++++++++++++--
 3 files changed, 44 insertions(+), 7 deletions(-)

-- 
2.7.4
