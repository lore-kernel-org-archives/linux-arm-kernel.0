From: d-gerlach@ti.com (Dave Gerlach)
Date: Sun, 18 Feb 2018 21:34:56 -0600
Subject: [PATCH 0/9] ARM: dts: am33xx/am4372: Add suspend-resume support
Message-ID: <1519011305-17822-1-git-send-email-d-gerlach@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
This series is the last needed to enable suspend/resume on am335x/am437x
along with [1]. It adds required dt nodes for the emif and core PM code
to find the needed sram nodes and marks key devices with ti,no-idle so
that the kernel does not idle them. With this suspend to mem can be achieved
by following the steps described in [1].

Branch containing all patches needed for suspend/resume is here [2].

Regards,
Dave

[1] https://www.spinics.net/lists/linux-omap/msg141652.html
[2] https://github.com/dgerlach/linux-pm/tree/upstream/v4.16/amx3-suspend-v4

Dave Gerlach (9):
  ARM: dts: am33xx: Reserve pm code and data regions in ocmcram sram
    node
  ARM: dts: am4372: Reserve pm code and data regions in ocmcram sram
    node
  ARM: dts: am33xx: Update emif node
  ARM: dts: am4372: Update emif node
  ARM: dts: am33xx: Add pm-sram phandle to soc node
  ARM: dts: am4372: Add soc node
  ARM: dts: am33xx: Mark emif with ti,no-idle
  ARM: dts: am4372: Mark emif with ti,no-idle
  ARM: dts: am4372: Mark omap_l3_noc with ti,no-idle

 arch/arm/boot/dts/am33xx.dtsi | 20 ++++++++++++++++++++
 arch/arm/boot/dts/am4372.dtsi | 29 +++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

-- 
2.16.1
