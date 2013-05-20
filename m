From: gang.chen@asianux.com (Chen Gang)
Date: Mon, 20 May 2013 13:42:46 +0800
Subject: [PATCH] arm64: kernel: need extern variable 'screen_info' for related
 driver using.
Message-ID: <5199B7D6.40907@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Add the extern variable 'screen_info' according to arm32 has done.

The related error:
  drivers/video/console/vgacon.c:1305: undefined reference to `screen_info'


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm64/kernel/setup.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index add6ea6..1055992 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -374,3 +374,14 @@ const struct seq_operations cpuinfo_op = {
 	.stop	= c_stop,
 	.show	= c_show
 };
+
+#if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_DUMMY_CONSOLE)
+struct screen_info screen_info = {
+	.orig_video_lines	= 30,
+	.orig_video_cols	= 80,
+	.orig_video_mode	= 0,
+	.orig_video_ega_bx	= 0,
+	.orig_video_isVGA	= 1,
+	.orig_video_points	= 8
+};
+#endif
-- 
1.7.7.6
