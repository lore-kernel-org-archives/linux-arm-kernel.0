From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sat, 13 May 2017 16:33:19 +0200
Subject: [PATCH v2 00/18] ARM64: meson: DT cleanups
Message-ID: <20170513143337.14278-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Kevin,

This series fixes several cosmetic issues, on top of your for-next branch.

Patches 3-6 rename a node, the rest should all be non-functional changes.

PLEASE STOP merging random new nodes at the bottom of DT files!
Just like it's a convention to sort new nodes by unit address, it has been
a convention to sort by-label nodes by their label. As discussed here and
elsewhere, this helps avoid merge conflicts and makes nodes easy to find.
I don't care whether we order A0 before A or after, but adding new HDMI
or CVBS nodes at the very bottom is totally out of alphabetical order.
Since my v1 you really should've known that...

Similarly, Khadas Vim shouldn't have been merged with the "bcrmf" typo.

Which proves my point that we need to fix these issues now so that they
don't keep spreading (Broken Window Theory). New boards have not been
checked for sort order, only boards already touched in v1.

Board and Makefile order affect my pending R-Box Pro patches.
Node order affects Martin's pending Bluetooth patches among others.

Patches 7-9 (had and) have no dependency, please start applying.

Thanks,
Andreas

v1 -> v2:
* Rebased (new nodes/properties added)
* Chose a different name for the misnamed Wifi nodes (Rob)
* Added patch to fix another new misnamed Wifi node
* Dropped patch fixing a trailing white line error (resolved)
* Tweaked subjects

Cc: Kevin Hilman <khilman@baylibre.com>
Cc: devicetree at vger.kernel.org
Cc: Rob Herring <robh@kernel.org>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Andreas F?rber (18):
  dt-bindings: arm: amlogic: Reorder boards
  arm64: dts: amlogic: Sort Makefile
  arm64: dts: meson-gxbb-vega-s95: Fix Wifi node name
  arm64: dts: meson-gxbb-p20x: Fix Wifi node name
  arm64: dts: meson-gx-p23x-q20x: Fix Wifi node name
  arm64: dts: meson-gxl-s905x-khadas-vim: Fix Wifi node name
  arm64: dts: meson-gxm-nexbox-a1: Drop UART comment
  arm64: dts: meson-gxl-s905x: Comment typo fix
  arm64: dts: meson-gxbb-wetek-hub: Reference CVBS node by label
  arm64: dts: meson-gxbb: Fix node order
  arm64: dts: meson-gxbb-odroidc2: Fix node order
  arm64: dts: meson-gxbb-vega-s95: Fix node order
  arm64: dts: meson-gxbb-nexbox-a95x: Fix node order
  arm64: dts: meson-gxbb-p20x: Fix node order
  arm64: dts: meson-gxl: Fix node order
  arm64: dts: meson-gxl-s905x-nexbox-a95x: Fix node order
  arm64: dts: meson-gxm-nexbox-a1: Fix node order
  arm64: dts: meson-gx-p23x-q20x: Fix node order

 Documentation/devicetree/bindings/arm/amlogic.txt  |  20 ++-
 arch/arm64/boot/dts/amlogic/Makefile               |   6 +-
 .../arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi |  60 ++++----
 .../boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts    |  52 +++----
 .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 108 ++++++-------
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi   |  66 ++++----
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi      |  56 +++----
 .../boot/dts/amlogic/meson-gxbb-wetek-hub.dts      |   6 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        | 171 +++++++++++----------
 .../dts/amlogic/meson-gxl-s905x-khadas-vim.dts     |   2 +-
 .../dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts    |  52 +++----
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi   |   2 +-
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         |  72 ++++-----
 .../arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts |  87 ++++++-----
 14 files changed, 388 insertions(+), 372 deletions(-)

-- 
2.12.0
