From: Bhaskar.Upadhaya@nxp.com (Bhaskar Upadhaya)
Date: Thu, 30 Nov 2017 10:00:35 +0530
Subject: [PATCH 1/1] phy: Add 2.5G SGMII interface mode
Message-ID: <1512016235-15909-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add 2.5G SGMII interface mode(PHY_INTERFACE_MODE_2500SGMII)
in existing phy_interface list.As auto-negotiation is not
supported for 2.5G SGMII, we need to add a new type
PHY_INTERFACE_MODE_2500SGMII to differentiate
SGMII-1G and SGMII-2.5G with different setting for
auto-negotiation.

Signed-off-by: Bhaskar Upadhaya <Bhaskar.Upadhaya@nxp.com>
---
 include/linux/phy.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index dc82a07..158a5a5 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -87,6 +87,7 @@
 	PHY_INTERFACE_MODE_XAUI,
 	/* 10GBASE-KR, XFI, SFI - single lane 10G Serdes */
 	PHY_INTERFACE_MODE_10GKR,
+	PHY_INTERFACE_MODE_2500SGMII,
 	PHY_INTERFACE_MODE_MAX,
 } phy_interface_t;
 
@@ -159,6 +160,8 @@ static inline const char *phy_modes(phy_interface_t interface)
 		return "xaui";
 	case PHY_INTERFACE_MODE_10GKR:
 		return "10gbase-kr";
+	case PHY_INTERFACE_MODE_2500SGMII:
+		return "sgmii-2500";
 	default:
 		return "unknown";
 	}
-- 
1.9.1
