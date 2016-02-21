From: codekipper@gmail.com (codekipper at gmail.com)
Date: Sun, 21 Feb 2016 12:13:36 +0100
Subject: [PATCH v7 0/2] ASoC: Add SPDIF support for Allwinner SoCs
Message-ID: <1456053218-16325-1-git-send-email-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

For now just the SPDIF transmitter has been tested on a Mele A2000(A10)
and a Itead Ibox(A20).

In order for this patch set to be functional we require an audio clock patch
which will be delivered separately. For those that are interested I've pushed
the patches here with all the required changes to get SPDIF audio out of the
device.

https://github.com/codekipper/linux-sunxi/commits/spdif_delivery

Thanks in advance,
CK

---
Changes since v6:
- removed legacy dapm components that are no longer needed.
- changed dt-bindings patch subject styling to match that of the sound subsystem

Changes since v5:
- fixed warning that had sneaked in.

Changes since v4:
- corrected indentation issues
- removed old macros
- removed unnecessary enabling of apb clock

Changes since v3:
- removed code required for spdif capture
- added disable/enable of apb clk to suspend/resume.
- removed unnecessary dt checks in probe
- fixed error conditions in probe/resume
- modified pm_runtime functionality and confirmed that driver worked when PM was disabled.
- removed .owner from platform driver
- renamed bindings file

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
  ASoC: sunxi :add sun4i SPDIF dt bindings
  ASoC: sunxi: Add support for the SPDIF block

 .../bindings/sound/sunxi,sun4i-spdif.txt           |  39 ++
 sound/soc/sunxi/Kconfig                            |   8 +
 sound/soc/sunxi/Makefile                           |   1 +
 sound/soc/sunxi/sun4i-spdif.c                      | 542 +++++++++++++++++++++
 4 files changed, 590 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/sunxi,sun4i-spdif.txt
 create mode 100644 sound/soc/sunxi/sun4i-spdif.c

-- 
2.7.1
