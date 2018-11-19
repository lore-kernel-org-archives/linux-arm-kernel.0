From: stefan@agner.ch (Stefan Agner)
Date: Mon, 19 Nov 2018 11:00:22 +0100
Subject: [PATCH] PCI: dwc: layerscape: constify driver data
Message-ID: <20181119100022.27501-1-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Constify driver data since they don't get changed at runtime.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/pci/controller/dwc/pci-layerscape.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index 3724d3ef7008..905a0ab0e6fa 100644
--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -222,12 +222,12 @@ static const struct dw_pcie_ops dw_ls_pcie_ops = {
 	.link_up = ls_pcie_link_up,
 };
 
-static struct ls_pcie_drvdata ls1021_drvdata = {
+static const struct ls_pcie_drvdata ls1021_drvdata = {
 	.ops = &ls1021_pcie_host_ops,
 	.dw_pcie_ops = &dw_ls1021_pcie_ops,
 };
 
-static struct ls_pcie_drvdata ls1043_drvdata = {
+static const struct ls_pcie_drvdata ls1043_drvdata = {
 	.lut_offset = 0x10000,
 	.ltssm_shift = 24,
 	.lut_dbg = 0x7fc,
@@ -235,7 +235,7 @@ static struct ls_pcie_drvdata ls1043_drvdata = {
 	.dw_pcie_ops = &dw_ls_pcie_ops,
 };
 
-static struct ls_pcie_drvdata ls1046_drvdata = {
+static const struct ls_pcie_drvdata ls1046_drvdata = {
 	.lut_offset = 0x80000,
 	.ltssm_shift = 24,
 	.lut_dbg = 0x407fc,
@@ -243,7 +243,7 @@ static struct ls_pcie_drvdata ls1046_drvdata = {
 	.dw_pcie_ops = &dw_ls_pcie_ops,
 };
 
-static struct ls_pcie_drvdata ls2080_drvdata = {
+static const struct ls_pcie_drvdata ls2080_drvdata = {
 	.lut_offset = 0x80000,
 	.ltssm_shift = 0,
 	.lut_dbg = 0x7fc,
@@ -251,7 +251,7 @@ static struct ls_pcie_drvdata ls2080_drvdata = {
 	.dw_pcie_ops = &dw_ls_pcie_ops,
 };
 
-static struct ls_pcie_drvdata ls2088_drvdata = {
+static const struct ls_pcie_drvdata ls2088_drvdata = {
 	.lut_offset = 0x80000,
 	.ltssm_shift = 0,
 	.lut_dbg = 0x407fc,
-- 
2.19.1
