From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Fri, 27 Oct 2017 11:48:43 +0200
Subject: [PATCH v6 1/6] ARM: imx6q: provide documentation for new fsl,
 pmic-stby-poweroff property
In-Reply-To: <20171027094848.28365-1-o.rempel@pengutronix.de>
References: <20171027094848.28365-1-o.rempel@pengutronix.de>
Message-ID: <20171027094848.28365-2-o.rempel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/clock/imx6q-clock.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.txt b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
index aa0a4d423ef5..9fed9dfe4a23 100644
--- a/Documentation/devicetree/bindings/clock/imx6q-clock.txt
+++ b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
@@ -6,6 +6,14 @@ Required properties:
 - interrupts: Should contain CCM interrupt
 - #clock-cells: Should be <1>
 
+Optional properties:
+- fsl,pmic-stby-poweroff: Configure CCM to assert PMIC_STBY_REQ signal
+  on power off.
+  Use this property if the SoC should be powered off by external power
+  management IC (PMIC) triggered via PMIC_STBY_REQ signal.
+  Boards that are designed to initiate poweroff on PMIC_ON_REQ signal should
+  be using "syscon-poweroff" driver instead.
+
 The clock consumer should specify the desired clock by having the clock
 ID in its "clocks" phandle cell.  See include/dt-bindings/clock/imx6qdl-clock.h
 for the full list of i.MX6 Quad and DualLite clock IDs.
-- 
2.11.0
