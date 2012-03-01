From: alan@signal11.us (Alan Ott)
Date: Thu,  1 Mar 2012 14:26:49 -0500
Subject: [PATCH 7/8] ARM: tegra: export usb phy symbols
In-Reply-To: <1330630010-11241-1-git-send-email-alan@signal11.us>
References: <1330630010-11241-1-git-send-email-alan@signal11.us>
Message-ID: <1330630010-11241-8-git-send-email-alan@signal11.us>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

The ehci driver can be a module, so the functions provided
by the tegra platform code used by ehci-tegra need to
be exported.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-tegra/usb_phy.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/usb_phy.c b/arch/arm/mach-tegra/usb_phy.c
index 37576a7..3c45264 100644
--- a/arch/arm/mach-tegra/usb_phy.c
+++ b/arch/arm/mach-tegra/usb_phy.c
@@ -730,6 +730,7 @@ err0:
 	kfree(phy);
 	return ERR_PTR(err);
 }
+EXPORT_SYMBOL_GPL(tegra_usb_phy_open);
 
 int tegra_usb_phy_power_on(struct tegra_usb_phy *phy)
 {
@@ -738,6 +739,7 @@ int tegra_usb_phy_power_on(struct tegra_usb_phy *phy)
 	else
 		return utmi_phy_power_on(phy);
 }
+EXPORT_SYMBOL_GPL(tegra_usb_phy_power_on);
 
 void tegra_usb_phy_power_off(struct tegra_usb_phy *phy)
 {
@@ -746,18 +748,21 @@ void tegra_usb_phy_power_off(struct tegra_usb_phy *phy)
 	else
 		utmi_phy_power_off(phy);
 }
+EXPORT_SYMBOL_GPL(tegra_usb_phy_power_off);
 
 void tegra_usb_phy_preresume(struct tegra_usb_phy *phy)
 {
 	if (!phy_is_ulpi(phy))
 		utmi_phy_preresume(phy);
 }
+EXPORT_SYMBOL_GPL(tegra_usb_phy_preresume);
 
 void tegra_usb_phy_postresume(struct tegra_usb_phy *phy)
 {
 	if (!phy_is_ulpi(phy))
 		utmi_phy_postresume(phy);
 }
+EXPORT_SYMBOL_GPL(tegra_usb_phy_postresume);
 
 void tegra_ehci_phy_restore_start(struct tegra_usb_phy *phy,
 				 enum tegra_usb_phy_port_speed port_speed)
@@ -765,24 +770,28 @@ void tegra_ehci_phy_restore_start(struct tegra_usb_phy *phy,
 	if (!phy_is_ulpi(phy))
 		utmi_phy_restore_start(phy, port_speed);
 }
+EXPORT_SYMBOL_GPL(tegra_ehci_phy_restore_start);
 
 void tegra_ehci_phy_restore_end(struct tegra_usb_phy *phy)
 {
 	if (!phy_is_ulpi(phy))
 		utmi_phy_restore_end(phy);
 }
+EXPORT_SYMBOL_GPL(tegra_ehci_phy_restore_end);
 
 void tegra_usb_phy_clk_disable(struct tegra_usb_phy *phy)
 {
 	if (!phy_is_ulpi(phy))
 		utmi_phy_clk_disable(phy);
 }
+EXPORT_SYMBOL_GPL(tegra_usb_phy_clk_disable);
 
 void tegra_usb_phy_clk_enable(struct tegra_usb_phy *phy)
 {
 	if (!phy_is_ulpi(phy))
 		utmi_phy_clk_enable(phy);
 }
+EXPORT_SYMBOL_GPL(tegra_usb_phy_clk_enable);
 
 void tegra_usb_phy_close(struct tegra_usb_phy *phy)
 {
@@ -794,3 +803,4 @@ void tegra_usb_phy_close(struct tegra_usb_phy *phy)
 	clk_put(phy->pll_u);
 	kfree(phy);
 }
+EXPORT_SYMBOL_GPL(tegra_usb_phy_close);
-- 
1.7.0.4
