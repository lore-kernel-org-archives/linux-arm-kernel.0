From: jacopo+renesas@jmondi.org (Jacopo Mondi)
Date: Mon, 21 May 2018 16:45:39 +0200
Subject: [PATCH v4 0/3] arm64: dts: Draak: Enable video inputs and VIN4
Message-ID: <1526913942-15426-1-git-send-email-jacopo+renesas@jmondi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
  this series enables HDMI, CVBS and VIN4 for R8A77995 Draak board.

Compared to v3, the analog video decoder ADV7180 is now described in bindings
with the compatible string "adi,adv7180cp" and its port nodes definition
has been res-structured according to the chip bindings as reported by
Laurent on v3.

Bindings have been copi^W^Winspired from Gen2 Gose board, the only Gen2 board
using the "adv7180cp" compatible string.

Example of how to switch to HDMI input is still available here:
git://jmondi.org/linux d3/media-master/salvator-x-dts_csi2/d3-hdmi

And the series still depends on
[PATCH v3 0/9] rcar-vin: Add support for parallel input on Gen3

Thanks
   j

Jacopo Mondi (3):
  dt-bindings: media: rcar-vin: Add R8A77995 support
  arm64: dts: renesas: draak: Describe CVBS input
  arm64: dts: renesas: draak: Describe HDMI input

v3 -> v4:
- Use 'adi,adv7180cp' in [3/3] as detailed in the commit message
- Add Laurent's R-b tag to [2/3]

v2 -> v3:
- Add comment to CVBS and HDMI inputs
- Add missing Signed-off-by to [2/3]
- Add Niklas' tag

 .../devicetree/bindings/media/rcar_vin.txt         |   1 +
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts     | 117 +++++++++++++++++++++
 2 files changed, 118 insertions(+)

--
2.7.4
