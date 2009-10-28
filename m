From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 28 Oct 2009 12:15:45 +0000
Subject: [PATCH 04/12] ARM: S3C: Fix adc function exports
In-Reply-To: <1256732153-22027-1-git-send-email-ben-linux@fluff.org>
References: <1256732153-22027-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1256732153-22027-4-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ryan Mallon <ryan@bluewatersys.com>

Fix the export of s3c_adc_read.

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
[ben-linux at fluff.org: remove unexport of s3c_adc_start, needed for ts]
Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-s3c24xx/adc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-s3c24xx/adc.c b/arch/arm/plat-s3c24xx/adc.c
index 11117a7..b18eead 100644
--- a/arch/arm/plat-s3c24xx/adc.c
+++ b/arch/arm/plat-s3c24xx/adc.c
@@ -188,7 +188,7 @@ int s3c_adc_read(struct s3c_adc_client *client, unsigned int ch)
 err:
 	return ret;
 }
-EXPORT_SYMBOL_GPL(s3c_adc_convert);
+EXPORT_SYMBOL_GPL(s3c_adc_read);
 
 static void s3c_adc_default_select(struct s3c_adc_client *client,
 				   unsigned select)
-- 
1.6.3.3
