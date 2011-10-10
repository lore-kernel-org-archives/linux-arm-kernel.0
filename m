From: olof@lixom.net (Olof Johansson)
Date: Sun,  9 Oct 2011 22:27:57 -0700
Subject: [PATCH v2 07/14] ARM: tegra: pcie: 0 -> NULL changes
In-Reply-To: <1318224484-2090-1-git-send-email-olof@lixom.net>
References: <1317956064-17650-1-git-send-email-olof@lixom.net>
	<1318224484-2090-1-git-send-email-olof@lixom.net>
Message-ID: <1318224484-2090-8-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes:

arch/arm/mach-tegra/pcie.c:465:10: warning: Using plain integer as NULL pointer

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-tegra/pcie.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/pcie.c b/arch/arm/mach-tegra/pcie.c
index f7c89ee..f5aa173 100644
--- a/arch/arm/mach-tegra/pcie.c
+++ b/arch/arm/mach-tegra/pcie.c
@@ -462,7 +462,7 @@ static struct pci_bus __init *tegra_pcie_scan_bus(int nr,
 	struct tegra_pcie_port *pp;
 
 	if (nr >= tegra_pcie.num_ports)
-		return 0;
+		return NULL;
 
 	pp = tegra_pcie.port + nr;
 	pp->root_bus_nr = sys->busnr;
-- 
1.7.4.1
