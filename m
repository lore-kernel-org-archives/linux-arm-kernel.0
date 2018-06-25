From: aford173@gmail.com (Adam Ford)
Date: Sun, 24 Jun 2018 19:12:28 -0500
Subject: [RFC 0/5] Migrate AM35xx MUSB glue to device tree and enable MUSB
Message-ID: <20180625001233.9785-1-aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the AM3517.dtsi uses the omap2430 glue to connect
the MUSB controller when it should use the AM35x glue.  This
series attempts to convert the AM35x glue to device tree,
fix the clock references to the AM35X can enable/disable
them correctly, and then use pdata-quirks.c to enable the
register that isn't yet available using device tree to enable
MSUB, then finally modifies the AM3517 and AM3517-EVM to use
the updated AM35x glue to support MUSB.

It currently doesnt' work, but I am looking for ideas on
what I may have missed or done incorrectly.  

Adam Ford (5):
  usb: musb: am35x: Add device tree support
  usb: musb: am35x: Match clock assignements to hwmods
  ARM: OMAP2+: Add AM3517 MUSB setup to pdata quirks.
  ARM: dts: AM35x: Change MUSB from omap2430 to am35xx
  ARM: dts: am3517-evm: Enable MUSB on AM3517-evm

 arch/arm/boot/dts/am3517-evm.dts   | 12 ++++++++++++
 arch/arm/boot/dts/am3517.dtsi      |  2 +-
 arch/arm/mach-omap2/pdata-quirks.c | 19 +++++++++++++++++++
 drivers/usb/musb/am35x.c           | 15 +++++++++++++--
 4 files changed, 45 insertions(+), 3 deletions(-)

-- 
2.17.1
