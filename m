From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Thu, 19 Jul 2018 10:08:37 +0200
Subject: [PATCH RESEND v2 1/2] drm/sun4i: sun4i: Register quirks with the
 backend structure
Message-ID: <20180719080838.31598-1-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In prevision for introducing a new quirk that will be used at atomic
plane check time, register the quirks structure with the backend
structure. This way, it can easily be grabbed where needed.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---

Version 2 of this series was resent to include this patch, that was
missing from the original v2 submission but is still very much needed.

 drivers/gpu/drm/sun4i/sun4i_backend.c | 2 ++
 drivers/gpu/drm/sun4i/sun4i_backend.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index de0a76dfa1a2..075cb0ff56ca 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -882,6 +882,8 @@ static int sun4i_backend_bind(struct device *dev, struct device *master,
 				    : SUN4I_BACKEND_MODCTL_OUT_LCD0));
 	}
 
+	backend->quirks = quirks;
+
 	return 0;
 
 err_disable_ram_clk:
diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.h b/drivers/gpu/drm/sun4i/sun4i_backend.h
index 4caee0392fa4..ad6609323f0e 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.h
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.h
@@ -187,6 +187,8 @@ struct sun4i_backend {
 	/* Protects against races in the frontend teardown */
 	spinlock_t		frontend_lock;
 	bool			frontend_teardown;
+
+	const struct sun4i_backend_quirks	*quirks;
 };
 
 static inline struct sun4i_backend *
-- 
2.18.0
