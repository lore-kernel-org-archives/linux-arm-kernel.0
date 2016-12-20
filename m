From: andrew@aj.id.au (Andrew Jeffery)
Date: Tue, 20 Dec 2016 17:45:30 +1030
Subject: [PATCH v4 0/5] mfd: dt: Add bindings for the Aspeed MFDs
Message-ID: <20161220071535.27542-1-andrew@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

Here's v4 of the Aspeed LPC MFD devicetree bindings series. v3 can be found at:

  https://lkml.org/lkml/2016/12/5/835

Changes since v3:

* Based on Arnd's argument[1], drop the addition of the mfd/syscon bindings
  directory as well as the the last patch in v3, which moved a number of
  existing bindings. Eventually the Aspeed display controller will have a
  device-specific driver so it doesn't belong there either.

* Add a compatible string for the AST2400 in the LPC Host Controller bindings
  as requested by Joel and slightly tweak the reg description for Rob.

[1] https://lkml.org/lkml/2016/12/13/202

Andrew Jeffery (5):
  mfd: dt: Fix "indicates" typo in mfd bindings document
  mfd: dt: ranges, #address-cells and #size-cells as optional properties
  mfd: dt: Add Aspeed Low Pin Count Controller bindings
  mfd: dt: Add bindings for the Aspeed LPC Host Controller (LHC)
  mfd: dt: Add bindings for the Aspeed SoC Display Controller (GFX)

 .../devicetree/bindings/mfd/aspeed-gfx.txt         |  17 +++
 .../devicetree/bindings/mfd/aspeed-lpc.txt         | 137 +++++++++++++++++++++
 Documentation/devicetree/bindings/mfd/mfd.txt      |  12 +-
 3 files changed, 165 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/aspeed-gfx.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/aspeed-lpc.txt

-- 
2.9.3
