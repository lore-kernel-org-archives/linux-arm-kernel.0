From: s-anna@ti.com (Suman Anna)
Date: Mon, 17 Jul 2017 22:28:40 -0500
Subject: [PATCH 0/4] Add various TI-SCI DT nodes on 66AK2G SoCs
Message-ID: <20170718032844.29490-1-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

The following patch series adds various TI-SCI related DTS nodes that
probe the corresponding TI-SCI genpd, clock and reset drivers for the
66AK2G platforms.

This is the second of two series, and these nodes along with the defconfig
patches finally allows adding other peripherals to the 66AK2G platforms.
All the new peripherals should/will be added without using the device id
macros [1]. Patches are baselined on 4.13-rc1 and are intended for the 4.14
merge window.

I have boot-tested both the series individually and combined on all
the Keystone2 platforms. K2G platforms are boot-tested using ramdisk,
the MMC boot and NFS boot can be enabled once the corresponding DTS nodes
are added. The addition of the PMMC node also enables the system reboot.

regards
Suman

[1] https://patchwork.kernel.org/patch/9741279/

Andrew F. Davis (1):
  ARM: dts: keystone-k2g: Add TI SCI reset-controller node

Dave Gerlach (1):
  ARM: dts: keystone-k2g: Add ti-sci power domain node

Nishanth Menon (1):
  ARM: dts: keystone-k2g: Add PMMC node to support TI-SCI protocol

Tero Kristo (1):
  ARM: dts: keystone-k2g: Add ti-sci clock provider node

 arch/arm/boot/dts/keystone-k2g.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

-- 
2.13.1
