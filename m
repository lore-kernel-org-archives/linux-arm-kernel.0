From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 15 Feb 2014 11:20:17 +0100
Subject: [PATCH v2 19/23] ARM: MVEBU: Enable mvebu-soc-id on Kirkwood
In-Reply-To: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
References: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
Message-ID: <1392459621-24003-20-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the Kirkwood PCIe compatibility string to mvebu-soc-id, so that it
can get the SoC ID and revision from the PCIe endpoints.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/mach-mvebu/mvebu-soc-id.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mvebu/mvebu-soc-id.c b/arch/arm/mach-mvebu/mvebu-soc-id.c
index f3b325f6cbd4..f3d4cf53f746 100644
--- a/arch/arm/mach-mvebu/mvebu-soc-id.c
+++ b/arch/arm/mach-mvebu/mvebu-soc-id.c
@@ -38,6 +38,7 @@ static bool is_id_valid;
 static const struct of_device_id mvebu_pcie_of_match_table[] = {
 	{ .compatible = "marvell,armada-xp-pcie", },
 	{ .compatible = "marvell,armada-370-pcie", },
+	{ .compatible = "marvell,kirkwood-pcie" },
 	{},
 };
 
-- 
1.8.5.3
