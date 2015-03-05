From: d-gerlach@ti.com (Dave Gerlach)
Date: Wed, 4 Mar 2015 22:12:20 -0600
Subject: [PATCH v2 0/2] ARM: OMAP2+: wkup_m3_rproc support patches
Message-ID: <1425528742-3087-1-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
This series adds the mach-omap2 code for the wkup_m3_rproc driver
submitted here [1]. pdata-quirks patch requires the pdata added with
patch 3 of the aforementioned series. The dt patch was previously
included as part of the rproc series here [2]. Changes are:

v1->v2: 
-Because the firmware loading has changed, the wkup_m3 node
 has moved into the soc node and ranges have been added so the
 device address to virtual address translation can work.
-Removed the ti,no-reset-on-init flag as asserting the hard-reset
 line on init is what the wkup_m3 has by default already.

Regards,
Dave

[1] https://www.mail-archive.com/linux-omap at vger.kernel.org/msg114621.html
[2] http://www.spinics.net/lists/arm-kernel/msg387984.html

Dave Gerlach (2):
  ARM: OMAP2+: Use pdata-quirks for wkup_m3 deassert_hardreset
  ARM: dts: am33xx: Move wkup_m3 node to soc node and add ranges

 arch/arm/boot/dts/am33xx.dtsi      | 21 +++++++++++++--------
 arch/arm/mach-omap2/pdata-quirks.c | 13 +++++++++++++
 2 files changed, 26 insertions(+), 8 deletions(-)

-- 
2.3.0
