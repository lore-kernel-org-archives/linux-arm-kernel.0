From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Thu, 26 Jul 2018 08:53:26 +0200
Subject: [PATCH v7 1/6] dt-bindings: mailbox: allow mbox-cells to be equal to 0
In-Reply-To: <20180726065331.6186-1-o.rempel@pengutronix.de>
References: <20180726065331.6186-1-o.rempel@pengutronix.de>
Message-ID: <20180726065331.6186-2-o.rempel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <aisheng.dong@nxp.com>

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
 Documentation/devicetree/bindings/mailbox/mailbox.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/mailbox.txt b/Documentation/devicetree/bindings/mailbox/mailbox.txt
index af8ecee2ac68..c2fcd054141a 100644
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
2.18.0
