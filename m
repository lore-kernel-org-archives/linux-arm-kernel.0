From: david.wu@rock-chips.com (David Wu)
Date: Thu, 10 Aug 2017 21:59:18 +0800
Subject: [PATCH v5 05/11] Documentation: net: phy: Add phy-is-integrated
 binding
In-Reply-To: <1502373410-2423-1-git-send-email-david.wu@rock-chips.com>
References: <1502373410-2423-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <1502373558-2558-1-git-send-email-david.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the documentation for integrated PHY. A boolean property indicates
the PHY is integrated into the same physical package as the Ethernet
MAC. If needed, muxers should be configured to ensure the integrated
PHY is used. The absence of this property indicates the muxers should
be configured so that the external PHY is used.

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
change in v5:
 - Use phy-is-integrated boolean property.

 Documentation/devicetree/bindings/net/phy.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/phy.txt b/Documentation/devicetree/bindings/net/phy.txt
index b558576..d3c24d5 100644
--- a/Documentation/devicetree/bindings/net/phy.txt
+++ b/Documentation/devicetree/bindings/net/phy.txt
@@ -52,6 +52,11 @@ Optional Properties:
   Mark the corresponding energy efficient ethernet mode as broken and
   request the ethernet to stop advertising it.
 
+- phy-is-integrated: If set, indicates that the PHY is integrated into the same
+  physical package as the Ethernet MAC. If needed, muxers should be configured
+  to ensure the integrated PHY is used. The absence of this property indicates
+  the muxers should be configured so that the external PHY is used.
+
 Example:
 
 ethernet-phy at 0 {
-- 
1.9.1
