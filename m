From: anilkumar@ti.com (AnilKumar Ch)
Date: Tue, 28 Aug 2012 13:40:51 +0530
Subject: [PATCH v4 0/3] Add device tree data for AM33XX devices
Message-ID: <1346141454-18786-1-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinctrl and d_can device tree data to AM33XX family of devices.
First two patches add support for pinctrl DT data and third one
adds dcan DT data.

Reason behind combining these patches is to apply cleanly on
linux-omap tree, because these are sequential patches.

These patches were tested on AM335x-Bone and AM335x-EVM apply
on linux-omap:master

d_can:
  Changes from v3:
	- Removed d_can1 node from am335x-evm.dts file. Instance
	  one of CAN (d_can1) is available on AM335x-EVM only under
	  a specific CPLD mode selection. am335x-evm.dts does not
          support this mode so remove the d_can1 node.
	- Dropped d_can pinmux settings patch, above comment
	  applies here as well.

  Changes from v2:
	- Incorporated Vaibhav H's comments on v2
	  * Added dcan0 instances to am33xx.dtsi file

  Changes from v1:
	- These two patches separated from c_can DT support
	  patch series.

pinctrl:
  Changes from v3:
	- Updated the reg length based on latest AM335x TRM.

  Changes from v2:
	- user led pinmux comments updated according to Tony's
	  comment.

  Changes from v1:
	- Rebased the patches based on latest pinctrl-single driver

AnilKumar Ch (3):
  arm/dts: AM33XX: Add basic pinctrl device tree data
  arm/dts: AM33XX: Configure pinmuxs for user leds control on Bone
  arm/dts: AM33XX: Add D_CAN device tree data

 arch/arm/boot/dts/am335x-bone.dts |   14 ++++++++++++++
 arch/arm/boot/dts/am33xx.dtsi     |   27 +++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

-- 
1.7.9.5
