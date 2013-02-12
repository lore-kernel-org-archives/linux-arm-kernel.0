From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 12 Feb 2013 12:18:22 -0300
Subject: [PATCH v2 5/8] ARM: omap2: gpmc-onenand: Print something useful on CS
 request failure
In-Reply-To: <1360682305-20935-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1360682305-20935-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1360682305-20935-6-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If CS request fails the current error message is rather unhelpful.
Fix it by printing the failing chip select and the error code.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/mach-omap2/gpmc-onenand.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-onenand.c b/arch/arm/mach-omap2/gpmc-onenand.c
index fadd8743..0ee5317 100644
--- a/arch/arm/mach-omap2/gpmc-onenand.c
+++ b/arch/arm/mach-omap2/gpmc-onenand.c
@@ -379,7 +379,8 @@ void gpmc_onenand_init(struct omap_onenand_platform_data *_onenand_data)
 	err = gpmc_cs_request(gpmc_onenand_data->cs, ONENAND_IO_SIZE,
 				(unsigned long *)&gpmc_onenand_resource.start);
 	if (err < 0) {
-		pr_err("%s: Cannot request GPMC CS\n", __func__);
+		pr_err("%s: Cannot request GPMC CS %d, error %d\n",
+		       __func__, gpmc_onenand_data->cs, err);
 		return;
 	}
 
-- 
1.7.8.6
