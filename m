From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 17 Aug 2016 13:31:49 +0200
Subject: [PATCH/RTF 0/7] Add SDHI to r8a7796/salvator-x
Message-ID: <1471433516-4478-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this patch set updates drivers, documentation and DT to
enable SDHI0 & 3 on the r8a7796/salvator-x. This includes
defining nodes for all available SDHI and GPIO devices.

I have boot-tested this which seems successful.
However, I do not have physical access to an r8a7796/salvator-x board
and the one that I have remote access to does not appear to have
any SD cards present. I would be grateful of any testing anyone
can provide.

Based on renesas-drivers-2016-08-09-v4.8-rc1

Provided for testing as the topic/r8a7796-sdhi branch in
my renesas tree on kernel.org.

Ai Kyuse (2):
  clk: renesas: r8a7796: Add SDIF clocks
  mmc: sh_mobile_sdhi: Add r8a7796 support

Simon Horman (2):
  arm64: dts: r8a7796: add SDHI nodes
  arm64: dts: r8a7796: salvator-x: enable SDHI0 & 3

Takeshi Kihara (3):
  clk: renesas: r8a7796: Add GPIO clocks
  pinctrl: sh-pfc: r8a7796: Add SDHI pins, groups and functions
  arm64: dts: r8a7796: Add GPIO device nodes

 Documentation/devicetree/bindings/mmc/tmio_mmc.txt |   1 +
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts |  84 +++++++
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           | 154 ++++++++++++
 drivers/clk/renesas/r8a7796-cpg-mssr.c             |  17 ++
 drivers/mmc/host/sh_mobile_sdhi.c                  |   1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c               | 275 +++++++++++++++++++++
 6 files changed, 532 insertions(+)

-- 
2.7.0.rc3.207.g0ac5344
