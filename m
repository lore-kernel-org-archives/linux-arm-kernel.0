From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri,  2 Dec 2016 14:57:13 +0100
Subject: [RFC PATCH 2/5] regulator: Document the
 regulator-allow-changes-at-runtime DT property
In-Reply-To: <1480687036-5037-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1480687036-5037-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1480687036-5037-3-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

regulator-allow-changes-at-runtime is an extra property that can be
set in a regulator suspend state to tell whether the suspend state can
be entered at runtime or not.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 Documentation/devicetree/bindings/regulator/regulator.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/regulator.txt b/Documentation/devicetree/bindings/regulator/regulator.txt
index 6ab5aef619d9..7b724650500a 100644
--- a/Documentation/devicetree/bindings/regulator/regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/regulator.txt
@@ -37,6 +37,11 @@ Optional properties:
 	  The set of possible operating modes depends on the capabilities of
 	  every hardware so the valid modes are documented on each regulator
 	  device tree binding document.
+	- regulator-allow-changes-at-runtime: runtime changes are allowed when
+	  the regulator does not support programming a suspend state that will
+	  be applied later on when the system is suspended.
+	  Applying changes at runtime can be dangerous, and you should only
+	  add this property if you know what you're doing.
 - regulator-initial-mode: initial operating mode. The set of possible operating
   modes depends on the capabilities of every hardware so each device binding
   documentation explains which values the regulator supports.
-- 
2.7.4
