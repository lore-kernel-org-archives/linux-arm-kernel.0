From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Fri, 13 Jun 2014 09:20:02 +0200
Subject: [PATCH] i2c: sun6-p2wi: fix call to snprintf
In-Reply-To: <CAGXu5jLi5NXNsbUAn=XndDb2JSTxiVhMWbiMxtDsUOqZZhxf2A@mail.gmail.com>
References: <CAGXu5jLi5NXNsbUAn=XndDb2JSTxiVhMWbiMxtDsUOqZZhxf2A@mail.gmail.com>
Message-ID: <1402644002-2591-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes possible issue in case pdev name contains formatting characters.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
Reported-by: Kees Cook <keescook@google.com>
---
 drivers/i2c/busses/i2c-sun6i-p2wi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-sun6i-p2wi.c b/drivers/i2c/busses/i2c-sun6i-p2wi.c
index 5d2d678..63d1b2d 100644
--- a/drivers/i2c/busses/i2c-sun6i-p2wi.c
+++ b/drivers/i2c/busses/i2c-sun6i-p2wi.c
@@ -237,7 +237,8 @@ static int p2wi_probe(struct platform_device *pdev)
 	if (IS_ERR(p2wi->regs))
 		return PTR_ERR(p2wi->regs);
 
-	snprintf(p2wi->adapter.name, sizeof(p2wi->adapter.name), pdev->name);
+	snprintf(p2wi->adapter.name, sizeof(p2wi->adapter.name), "%s",
+		 pdev->name);
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(dev, "failed to retrieve irq: %d\n", irq);
-- 
1.8.3.2
