From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Sun,  8 Jul 2018 22:56:53 +0800
Subject: [PATCH V4 1/5] dt-bindings: mailbox: allow mbox-cells to be equal to 0
In-Reply-To: <1531061817-1980-1-git-send-email-aisheng.dong@nxp.com>
References: <1531061817-1980-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1531061817-1980-2-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mailbox devices may have only one channel which means the mbox-cells
at least 1 does not make sense for this type devices. Let's remove
that limitation to allow the mbox-cells to be equal to 0.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: devicetree at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
ChangeLog:
 * New patch introduced in v3 series
 * Actually there're already users in kernel with mbox-cells set to 0.
   See:
   arch/arm/boot/dts/bcm283x.dtsi:145: #mbox-cells = <0>;
---
 Documentation/devicetree/bindings/mailbox/mailbox.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/mailbox.txt b/Documentation/devicetree/bindings/mailbox/mailbox.txt
index af8ecee..c2fcd05 100644
--- a/Documentation/devicetree/bindings/mailbox/mailbox.txt
+++ b/Documentation/devicetree/bindings/mailbox/mailbox.txt
@@ -6,8 +6,7 @@ assign appropriate mailbox channel to client drivers.
 * Mailbox Controller
 
 Required property:
-- #mbox-cells: Must be at least 1. Number of cells in a mailbox
-		specifier.
+- #mbox-cells: Number of cells in a mailbox specifier.
 
 Example:
 	mailbox: mailbox {
-- 
2.7.4
