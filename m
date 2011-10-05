From: dave.martin@linaro.org (Dave Martin)
Date: Wed,  5 Oct 2011 17:04:54 +0100
Subject: [PATCH 03/16] hwrng: nomadik: Enable module alias autogeneration for
	AMBA drivers
In-Reply-To: <1317830707-17517-1-git-send-email-dave.martin@linaro.org>
References: <1317830707-17517-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1317830707-17517-4-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 drivers/char/hw_random/nomadik-rng.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/char/hw_random/nomadik-rng.c b/drivers/char/hw_random/nomadik-rng.c
index 52e08ca..3d3c1e6 100644
--- a/drivers/char/hw_random/nomadik-rng.c
+++ b/drivers/char/hw_random/nomadik-rng.c
@@ -95,6 +95,8 @@ static struct amba_id nmk_rng_ids[] = {
 	{0, 0},
 };
 
+MODULE_DEVICE_TABLE(amba, nmk_rng_ids);
+
 static struct amba_driver nmk_rng_driver = {
 	.drv = {
 		.owner = THIS_MODULE,
-- 
1.7.4.1
