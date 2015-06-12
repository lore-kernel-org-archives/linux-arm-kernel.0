From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 12 Jun 2015 09:16:02 +0200
Subject: [RESEND PATCH v4 10/14] crypto: marvell/CESA: add support for all
 armada SoCs
In-Reply-To: <1434093366-14681-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1434093366-14681-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1434093366-14681-11-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add CESA IP description for all the missing armada SoCs (XP, 375 and 38x).

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/crypto/marvell/cesa.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/crypto/marvell/cesa.c b/drivers/crypto/marvell/cesa.c
index e4dfee0..087370e 100644
--- a/drivers/crypto/marvell/cesa.c
+++ b/drivers/crypto/marvell/cesa.c
@@ -191,8 +191,20 @@ static const struct mv_cesa_caps armada_370_caps = {
 	.has_tdma = true,
 };
 
+static const struct mv_cesa_caps armada_xp_caps = {
+	.nengines = 2,
+	.cipher_algs = armada_370_cipher_algs,
+	.ncipher_algs = ARRAY_SIZE(armada_370_cipher_algs),
+	.ahash_algs = armada_370_ahash_algs,
+	.nahash_algs = ARRAY_SIZE(armada_370_ahash_algs),
+	.has_tdma = true,
+};
+
 static const struct of_device_id mv_cesa_of_match_table[] = {
 	{ .compatible = "marvell,armada-370-crypto", .data = &armada_370_caps },
+	{ .compatible = "marvell,armada-xp-crypto", .data = &armada_xp_caps },
+	{ .compatible = "marvell,armada-375-crypto", .data = &armada_xp_caps },
+	{ .compatible = "marvell,armada-38x-crypto", .data = &armada_xp_caps },
 	{}
 };
 MODULE_DEVICE_TABLE(of, mv_cesa_of_match_table);
-- 
1.9.1
