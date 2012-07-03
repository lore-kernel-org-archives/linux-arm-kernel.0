From: b32955@freescale.com (Huang Shijie)
Date: Tue, 3 Jul 2012 16:24:33 +0800
Subject: [PATCH 2/2] mtd: gpmi: update the bitflip_threshold
In-Reply-To: <1341303873-23040-1-git-send-email-b32955@freescale.com>
References: <1341303873-23040-1-git-send-email-b32955@freescale.com>
Message-ID: <1341303873-23040-2-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The origin code misses to update the bitflip_threshold when
we have already get the right ecc_strength.

The patch fixes it.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index a1bf31f..ed9571b 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -1501,6 +1501,7 @@ static int gpmi_pre_bbt_scan(struct gpmi_nand_data  *this)
 	/* Adjust the ECC strength according to the chip. */
 	this->nand.ecc.strength = this->bch_geometry.ecc_strength;
 	this->mtd.ecc_strength = this->bch_geometry.ecc_strength;
+	this->mtd.bitflip_threshold = this->bch_geometry.ecc_strength;
 
 	/* NAND boot init, depends on the gpmi_set_geometry(). */
 	return nand_boot_init(this);
-- 
1.7.0.4
