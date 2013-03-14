From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 14 Mar 2013 13:08:55 +0100
Subject: [PATCH] i.MX: Add GPT devicetree nodes
Message-ID: <1363262942-26702-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPT is the general purpose timer found on i.MX SoCs. The bindings
are used on i.MX25 and i.MX6 already. The remaining i.MX SoCs still
use a platform based timer. This is a first step to change this: We
add the devicetree nodes for the other DT enabled SoCs (i.MX27, i.MX31,
i.MX51 and i.MX53).

This series also adds the missing binding documentation for the GPT.

The series is based on Shawns imx/dt branch.

The last patch adds the clocks to the i.MX27 GPT. This is not applicable
right now since it depends on the patch changing i.MX27 to devicetree
based clock lookups.

Sascga

----------------------------------------------------------------
Sascha Hauer (7):
      ARM: i.MX: Add GPT devicetree Documentation
      ARM: i.MX27: Add GPT devicetree nodes
      ARM: i.MX31: Add GPT devicetree node
      ARM: i.MX51: Add GPT devicetree node
      ARM: i.MX53: Add GPT devicetree node
      ARM: i.MX6: Add clocks to GPT devicetree node
      ARM: i.MX27: Add clocks to GPT devicetree nodes

 .../devicetree/bindings/timer/fsl,imxgpt.txt       | 18 ++++++++
 arch/arm/boot/dts/imx27.dtsip                      | 49 +++++++++++++++++++++-
 arch/arm/boot/dts/imx31.dtsip                      | 16 +++++++
 arch/arm/boot/dts/imx51.dtsip                      |  8 ++++
 arch/arm/boot/dts/imx53.dtsip                      |  8 ++++
 arch/arm/boot/dts/imx6qdl.dtsip                    |  2 +
 6 files changed, 100 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
