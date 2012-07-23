From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 23 Jul 2012 11:13:21 +0200
Subject: [PATCH 16/25] powerpc/celleb_pci: add a const qualifier
In-Reply-To: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1343034810-3386-17-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This prepares *of_device_id.data becoming const. Without this change
the following warning would occur:

	arch/powerpc/platforms/cell/celleb_pci.c: In function 'celleb_setup_phb':
	arch/powerpc/platforms/cell/celleb_pci.c:485:11: warning: assignment discards 'const' qualifier from pointer target type [enabled by default]

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/powerpc/platforms/cell/celleb_pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/celleb_pci.c b/arch/powerpc/platforms/cell/celleb_pci.c
index 5822141..abc8af4 100644
--- a/arch/powerpc/platforms/cell/celleb_pci.c
+++ b/arch/powerpc/platforms/cell/celleb_pci.c
@@ -472,7 +472,7 @@ int __init celleb_setup_phb(struct pci_controller *phb)
 {
 	struct device_node *dev = phb->dn;
 	const struct of_device_id *match;
-	struct celleb_phb_spec *phb_spec;
+	const struct celleb_phb_spec *phb_spec;
 	int rc;
 
 	match = of_match_node(celleb_phb_match, dev);
-- 
1.7.10.4
