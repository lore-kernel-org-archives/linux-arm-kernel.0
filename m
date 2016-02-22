From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 22 Feb 2016 11:23:52 +0000
Subject: [PATCH 2/3] nvmem: imx-ocotp: Fix return value of imx_ocotp_read
In-Reply-To: <1456140161-6851-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1456140161-6851-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1456140232-6938-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Axel Lin <axel.lin@ingics.com>

imx_ocotp_read() should return 0 on success.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/imx-ocotp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index b7971d4..d7796eb 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -51,7 +51,7 @@ static int imx_ocotp_read(void *context, const void *reg, size_t reg_size,
 		val += 4;
 	}
 
-	return (i - index) * 4;
+	return 0;
 }
 
 static int imx_ocotp_write(void *context, const void *data, size_t count)
-- 
1.9.1
