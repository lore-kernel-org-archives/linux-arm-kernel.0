From: m-karicheri2@ti.com (Murali Karicheri)
Date: Fri, 11 May 2018 15:29:08 -0400
Subject: [linux-next PATCH 0/4] Enable network driver on K2G ICE and GP EVMs
Message-ID: <1526066952-5230-1-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that NetCP driver patches for K2G SoC is merged to linux-next master
this series add patches to enable network driver on K2G ICE and GP EVMs.

Thanks

Applied the patches on top of latest linux-next master, built kernel and
booted up on both EVMs. The logs are below

K2G GP EVM: https://pastebin.ubuntu.com/p/ycZDnZXYPx/
K2G ICE EVM: https://pastebin.ubuntu.com/p/bdCpzgdrXr/

Murali Karicheri (4):
  ARM: dts: k2g: add dt bindings to support network driver
  ARM: dts: keystone-k2g-evm: Enable netcp network driver
  ARM: dts: keystone-k2g-ice: Enable netcp network driver
  ARM: keystone: k2g: enable micrel and dp83867 phys

 arch/arm/boot/dts/keystone-k2g-evm.dts    |  53 +++++++++++
 arch/arm/boot/dts/keystone-k2g-ice.dts    |  59 ++++++++++++
 arch/arm/boot/dts/keystone-k2g-netcp.dtsi | 147 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/keystone-k2g.dtsi       |  13 +++
 arch/arm/configs/keystone_defconfig       |   2 +
 5 files changed, 274 insertions(+)
 create mode 100644 arch/arm/boot/dts/keystone-k2g-netcp.dtsi

-- 
1.9.1
