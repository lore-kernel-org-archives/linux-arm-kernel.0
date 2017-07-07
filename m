From: dinguyen@kernel.org (Dinh Nguyen)
Date: Fri,  7 Jul 2017 14:03:17 -0500
Subject: [PATCHv1 2/4] ARM: dts: socfpga: add a bypass-reg binding for
 Stratix10
In-Reply-To: <1499454199-31901-1-git-send-email-dinguyen@kernel.org>
References: <1499454199-31901-1-git-send-email-dinguyen@kernel.org>
Message-ID: <1499454199-31901-2-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a 'bypass-reg' binding property for the Stratix10 clock. There are quite a
few clocks on the Stratix10 platform that have a separate bypass setting from
the clock's original parent.

The 'bypass-reg' binding contains the bypass register offset from the clock
manager's base address and a bit index.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 Documentation/devicetree/bindings/clock/altr_socfpga.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/altr_socfpga.txt b/Documentation/devicetree/bindings/clock/altr_socfpga.txt
index 1c32658..9e2754a 100644
--- a/Documentation/devicetree/bindings/clock/altr_socfpga.txt
+++ b/Documentation/devicetree/bindings/clock/altr_socfpga.txt
@@ -42,3 +42,6 @@ Optional properties:
 	value is the cclk_in_drv(drvsel). The clk-phase is used to enable the correct
 	hold/delay times that is needed for the SD/MMC CIU clock. The values of both
 	can be 0-315 degrees, in 45 degree increments.
+- bypass-reg : There are a few clocks on the Stratix10 platform that can be
+	bypassed from their original parents to a separate clock. This binding
+	property contains the bypass register and the bit index.
-- 
2.7.4
