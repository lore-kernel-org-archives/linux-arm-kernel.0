From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sun, 15 Nov 2015 21:08:23 +0100
Subject: [PATCH] drivers/media/platform/s5p-tv: constify mxr_layer_ops
 structures
Message-ID: <1447618103-20329-1-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mxr_layer_ops structures are never modified, so declare them as const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/media/platform/s5p-tv/mixer.h           |    2 +-
 drivers/media/platform/s5p-tv/mixer_grp_layer.c |    2 +-
 drivers/media/platform/s5p-tv/mixer_video.c     |    2 +-
 drivers/media/platform/s5p-tv/mixer_vp_layer.c  |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/s5p-tv/mixer.h b/drivers/media/platform/s5p-tv/mixer.h
index 42cd270..4dd62a9 100644
--- a/drivers/media/platform/s5p-tv/mixer.h
+++ b/drivers/media/platform/s5p-tv/mixer.h
@@ -300,7 +300,7 @@ void mxr_release_video(struct mxr_device *mdev);
 struct mxr_layer *mxr_graph_layer_create(struct mxr_device *mdev, int idx);
 struct mxr_layer *mxr_vp_layer_create(struct mxr_device *mdev, int idx);
 struct mxr_layer *mxr_base_layer_create(struct mxr_device *mdev,
-	int idx, char *name, struct mxr_layer_ops *ops);
+	int idx, char *name, const struct mxr_layer_ops *ops);
 
 void mxr_base_layer_release(struct mxr_layer *layer);
 void mxr_layer_release(struct mxr_layer *layer);
diff --git a/drivers/media/platform/s5p-tv/mixer_grp_layer.c b/drivers/media/platform/s5p-tv/mixer_grp_layer.c
index db3163b..d4d2564 100644
--- a/drivers/media/platform/s5p-tv/mixer_grp_layer.c
+++ b/drivers/media/platform/s5p-tv/mixer_grp_layer.c
@@ -235,7 +235,7 @@ struct mxr_layer *mxr_graph_layer_create(struct mxr_device *mdev, int idx)
 {
 	struct mxr_layer *layer;
 	int ret;
-	struct mxr_layer_ops ops = {
+	const struct mxr_layer_ops ops = {
 		.release = mxr_graph_layer_release,
 		.buffer_set = mxr_graph_buffer_set,
 		.stream_set = mxr_graph_stream_set,
diff --git a/drivers/media/platform/s5p-tv/mixer_video.c b/drivers/media/platform/s5p-tv/mixer_video.c
index dc1c679..abcc36a 100644
--- a/drivers/media/platform/s5p-tv/mixer_video.c
+++ b/drivers/media/platform/s5p-tv/mixer_video.c
@@ -1070,7 +1070,7 @@ static void mxr_vfd_release(struct video_device *vdev)
 }
 
 struct mxr_layer *mxr_base_layer_create(struct mxr_device *mdev,
-	int idx, char *name, struct mxr_layer_ops *ops)
+	int idx, char *name, const struct mxr_layer_ops *ops)
 {
 	struct mxr_layer *layer;
 
diff --git a/drivers/media/platform/s5p-tv/mixer_vp_layer.c b/drivers/media/platform/s5p-tv/mixer_vp_layer.c
index dd002a4..6fa6f67 100644
--- a/drivers/media/platform/s5p-tv/mixer_vp_layer.c
+++ b/drivers/media/platform/s5p-tv/mixer_vp_layer.c
@@ -207,7 +207,7 @@ struct mxr_layer *mxr_vp_layer_create(struct mxr_device *mdev, int idx)
 {
 	struct mxr_layer *layer;
 	int ret;
-	struct mxr_layer_ops ops = {
+	const struct mxr_layer_ops ops = {
 		.release = mxr_vp_layer_release,
 		.buffer_set = mxr_vp_buffer_set,
 		.stream_set = mxr_vp_stream_set,
