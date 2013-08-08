From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Thu,  8 Aug 2013 15:30:26 +0200
Subject: [PATCH 0/3] ARM: dts: mxs: dcp cleanup patches
Message-ID: <1375968629-10091-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series does the following:

- let the driver be "disabled" by default in imx28.dtsi
- coding style cleanups in drivers/crypto/dcp.c
- use the "official" 'fsl,' prefix in the 'compatible' property

The last patch adds a new entry to the of_match_table of the driver,
so that current DT blobs will still work. When out of tree users
(mentioned in the commit log of 519d8b1a "Added support for
Freescale's DCP co-processor") have updated their DTBs the old entry
'fsl-dsp' can be removed from the driver.

This patch series requires at least
"[PATCH 2/8] ARM: dts: mxs: add labels to most nodes for easier reference"
from the patch series:
<1375966287-6784-1-git-send-email-LW@KARO-electronics.de> to be
applied.

 arch/arm/boot/dts/imx28.dtsi      |    2 +-
 b/arch/arm/boot/dts/imx28-evk.dts |    4 ++++
 b/arch/arm/boot/dts/imx28.dtsi    |    3 ++-
 b/drivers/crypto/dcp.c            |   11 +++++------
 drivers/crypto/dcp.c              |    2 ++
 5 files changed, 14 insertions(+), 8 deletions(-)
