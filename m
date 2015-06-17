From: eddie.huang@mediatek.com (Eddie Huang)
Date: Wed, 17 Jun 2015 23:08:01 +0800
Subject: [PATCH v4 0/2] arm64: dts: Mediatek: MT8173 updtes 
Message-ID: <1434553683-11651-1-git-send-email-eddie.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series add MT8173 watchdog and I2C device nodes. Both device nodes 
are based on 4.1-rc1, but I2C need two extra CCF patches from Sascha [1][2].

[1] clk: Add common clock support for Mediatek MT8135 and MT8173
    http://lists.infradead.org/pipermail/linux-arm-kernel/2015-April/338763.html
[2] ARM64: dts: mt8173: Add clock controller device nodes
    http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/344753.html

Change in v4:
Move I2C pin from board dts file back to SoC dtsi file after discussion.
Add I2C default pin, address, size cell number in I2C controller node. 
But not clock-frequency because it is optional. (default value is 1000000)

Change in v3:
Move I2C pin from SoC dtsi to board dts file.

Change in v2:
Modify I2C device node accroding register address order.

Eddie Huang (2):
  arm64: dts: mt8173: Add watchdog device node
  arm64: dts: mt8173: Add I2C device node

 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 150 +++++++++++++++++++++++++++++++
 1 file changed, 150 insertions(+)

-- 
1.8.1.1.dirty
