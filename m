From: codekipper@gmail.com (codekipper at gmail.com)
Date: Tue,  2 Feb 2016 15:49:52 +0100
Subject: [PATCH v3 0/2] Add SPDIF support for Allwinner SoCs 
Message-ID: <1454424594-25208-1-git-send-email-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

This patch set adds support for the Allwinner SPDIF transceiver.

For now just the SPDIF transmitter has been tested on a Mele A2000(A10)
and a Itead Ibox(A20).

In order for this patch set to be functional we require an audio clock patch
which will be delivered separately. For those that are interested I've pushed
the patches here with all the required changes to get SPDIF audio out of the
device.

https://github.com/codekipper/linux-sunxi/commits/spdif_delivery

This is version 3 of the patch series. It's been quite a while since v2 and I'm
hoping now that all the previous comments have been acted on.

Thanks in advance,
CK

---
Changes since v2:
- removed sunxi-machine-spdif and replaced with simple audio card
- removed untested compatibilities from device tree documentation
- added pm_runtime and remove shutdown
- removed pll2 as it's the parent of the spdif clock
- rename clk to spdif_clk
- removed enabling of mclk output
- removed interrupts status being cleared as it's not being used
- use default fifo settings for now
- fixed alignments for wrapped lines

Changes since v1:
- Moved sunxi-machine-spdif.c to separate patch
- replaced sunxi in naming scheme with sun4i in the sun4i-spdif driver.
- split tx controller into separate enable/disable functions
- moved setclk and setfmt functionality into hw params
- added support for mono signals.
- cleaned up probe clock set up.
- removed all writes to transmit status registers.
- removed of_id
- removed power management code.
- Added support for more rates.

Marcus Cooper (2):
  dt-bindings: add sun4i SPDIF transceiver bindings
  ASOC: sunxi: Add support for the SPDIF block

 .../devicetree/bindings/sound/sun4i,spdif.txt      |  46 ++
 sound/soc/sunxi/Kconfig                            |   8 +
 sound/soc/sunxi/Makefile                           |   1 +
 sound/soc/sunxi/sun4i-spdif.c                      | 586 +++++++++++++++++++++
 4 files changed, 641 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/sun4i,spdif.txt
 create mode 100644 sound/soc/sunxi/sun4i-spdif.c

-- 
2.7.0
