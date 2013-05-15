From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 15 May 2013 15:25:19 +0200
Subject: [PATCHv9 5/9] clk: mvebu: create parent-child relation for PCIe
 clocks on Armada 370
In-Reply-To: <1368624323-24311-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1368624323-24311-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1368624323-24311-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 370 has two gatable clocks for each PCIe interface, and we
want both of them to be enabled. We therefore make one of the two
clocks a child of the other, as we did for the sataX and sataXlnk
clocks on Armada XP.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Mike Turquette <mturquette@linaro.org>
---
 drivers/clk/mvebu/clk-gating-ctrl.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mvebu/clk-gating-ctrl.c b/drivers/clk/mvebu/clk-gating-ctrl.c
index ebf141d..b35785a 100644
--- a/drivers/clk/mvebu/clk-gating-ctrl.c
+++ b/drivers/clk/mvebu/clk-gating-ctrl.c
@@ -119,8 +119,8 @@ static const struct mvebu_soc_descr __initconst armada_370_gating_descr[] = {
 	{ "pex1_en", NULL,  2 },
 	{ "ge1", NULL, 3 },
 	{ "ge0", NULL, 4 },
-	{ "pex0", NULL, 5 },
-	{ "pex1", NULL, 9 },
+	{ "pex0", "pex0_en", 5 },
+	{ "pex1", "pex1_en", 9 },
 	{ "sata0", NULL, 15 },
 	{ "sdio", NULL, 17 },
 	{ "tdm", NULL, 25 },
-- 
1.7.9.5
