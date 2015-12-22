From: tony@atomide.com (Tony Lindgren)
Date: Tue, 22 Dec 2015 08:10:42 -0800
Subject: [PATCH 0/3] Add GPMC and NAND support for dm814x-evm and
 dra62x-j5eco-evm
Message-ID: <1450800645-10766-1-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here's support for GPMC and NAND on j5-eco evm and dm814x-evm.
Probably too late for v4.5 merge window , but seems to work here if
somebody wants to play with GPMC.

To test, please use Linux next-20151222 or later and the following
patches:

[PATCH v4] clk: ti: Add support for dm814x ADPLL
[PATCH v2] ARM: dts: Add clocks for dm814x ADPLL

Check that you have CONFIG_COMMON_CLK_TI_ADPLL=y. And then you
probably want to apply this for an unrelated DSS build breakage:

[PATCH] OMAPDSS: fix omapfb build error due missing feat functions declaration

Regards,

Tony


Tony Lindgren (3):
  ARM: dts: Add support for GPMC for dm814x and dra62x
  ARM: dts: Add NAND support for j5-eco evm
  ARM: dts: Add NAND support for dm8148-evm

 arch/arm/boot/dts/dm8148-evm.dts       | 56 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/dm814x.dtsi          | 12 ++++++++
 arch/arm/boot/dts/dra62x-j5eco-evm.dts | 56 ++++++++++++++++++++++++++++++++++
 3 files changed, 124 insertions(+)

-- 
2.6.2
