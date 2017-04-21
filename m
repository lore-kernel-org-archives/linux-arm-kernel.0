From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 21 Apr 2017 16:38:51 +0800
Subject: [PATCH v2 3/9] drm/sun4i: backend: Drop trailing 0 from backend in
 error message
In-Reply-To: <20170421083857.29636-1-wens@csie.org>
References: <20170421083857.29636-1-wens@csie.org>
Message-ID: <20170421083857.29636-4-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we support multiple instances of backends, the trailing 0
implying only one backend no longer makes sense.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index 95a77c6a9161..e17e20036aa3 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -320,7 +320,7 @@ static int sun4i_backend_bind(struct device *dev, struct device *master,
 	backend->regs = devm_regmap_init_mmio(dev, regs,
 					      &sun4i_backend_regmap_config);
 	if (IS_ERR(backend->regs)) {
-		dev_err(dev, "Couldn't create the backend0 regmap\n");
+		dev_err(dev, "Couldn't create the backend regmap\n");
 		return PTR_ERR(backend->regs);
 	}
 
-- 
2.11.0
