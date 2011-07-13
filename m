From: jic23@cam.ac.uk (Jonathan Cameron)
Date: Wed, 13 Jul 2011 15:54:57 +0100
Subject: [PATCH 2/3] pcmcia: pxa2xx: remove empty socket_init / socket_resume
	functions.
In-Reply-To: <1310568898-9201-1-git-send-email-jic23@cam.ac.uk>
References: <1310568898-9201-1-git-send-email-jic23@cam.ac.uk>
Message-ID: <1310568898-9201-3-git-send-email-jic23@cam.ac.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now the are optional, let us get rid of the ones that don't have
any content.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/pcmcia/pxa2xx_balloon3.c  |   10 ----------
 drivers/pcmcia/pxa2xx_cm_x255.c   |   11 -----------
 drivers/pcmcia/pxa2xx_cm_x270.c   |   11 -----------
 drivers/pcmcia/pxa2xx_colibri.c   |   11 -----------
 drivers/pcmcia/pxa2xx_mainstone.c |   10 ----------
 drivers/pcmcia/pxa2xx_palmld.c    |   11 -----------
 drivers/pcmcia/pxa2xx_palmtc.c    |   11 -----------
 drivers/pcmcia/pxa2xx_palmtx.c    |   11 -----------
 drivers/pcmcia/pxa2xx_viper.c     |   10 ----------
 9 files changed, 0 insertions(+), 96 deletions(-)

diff --git a/drivers/pcmcia/pxa2xx_balloon3.c b/drivers/pcmcia/pxa2xx_balloon3.c
index 4c3e94c..f56d7de 100644
--- a/drivers/pcmcia/pxa2xx_balloon3.c
+++ b/drivers/pcmcia/pxa2xx_balloon3.c
@@ -103,22 +103,12 @@ static int balloon3_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
 	return 0;
 }
 
-static void balloon3_pcmcia_socket_init(struct soc_pcmcia_socket *skt)
-{
-}
-
-static void balloon3_pcmcia_socket_suspend(struct soc_pcmcia_socket *skt)
-{
-}
-
 static struct pcmcia_low_level balloon3_pcmcia_ops = {
 	.owner			= THIS_MODULE,
 	.hw_init		= balloon3_pcmcia_hw_init,
 	.hw_shutdown		= balloon3_pcmcia_hw_shutdown,
 	.socket_state		= balloon3_pcmcia_socket_state,
 	.configure_socket	= balloon3_pcmcia_configure_socket,
-	.socket_init		= balloon3_pcmcia_socket_init,
-	.socket_suspend		= balloon3_pcmcia_socket_suspend,
 	.first			= 0,
 	.nr			= 1,
 };
diff --git a/drivers/pcmcia/pxa2xx_cm_x255.c b/drivers/pcmcia/pxa2xx_cm_x255.c
index 05913d0..63f4d52 100644
--- a/drivers/pcmcia/pxa2xx_cm_x255.c
+++ b/drivers/pcmcia/pxa2xx_cm_x255.c
@@ -102,23 +102,12 @@ static int cmx255_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
 	return 0;
 }
 
-static void cmx255_pcmcia_socket_init(struct soc_pcmcia_socket *skt)
-{
-}
-
-static void cmx255_pcmcia_socket_suspend(struct soc_pcmcia_socket *skt)
-{
-}
-
-
 static struct pcmcia_low_level cmx255_pcmcia_ops __initdata = {
 	.owner			= THIS_MODULE,
 	.hw_init		= cmx255_pcmcia_hw_init,
 	.hw_shutdown		= cmx255_pcmcia_shutdown,
 	.socket_state		= cmx255_pcmcia_socket_state,
 	.configure_socket	= cmx255_pcmcia_configure_socket,
-	.socket_init		= cmx255_pcmcia_socket_init,
-	.socket_suspend		= cmx255_pcmcia_socket_suspend,
 	.nr			= 1,
 };
 
diff --git a/drivers/pcmcia/pxa2xx_cm_x270.c b/drivers/pcmcia/pxa2xx_cm_x270.c
index 5662646..6ee42b4 100644
--- a/drivers/pcmcia/pxa2xx_cm_x270.c
+++ b/drivers/pcmcia/pxa2xx_cm_x270.c
@@ -82,23 +82,12 @@ static int cmx270_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
 	return 0;
 }
 
-static void cmx270_pcmcia_socket_init(struct soc_pcmcia_socket *skt)
-{
-}
-
-static void cmx270_pcmcia_socket_suspend(struct soc_pcmcia_socket *skt)
-{
-}
-
-
 static struct pcmcia_low_level cmx270_pcmcia_ops __initdata = {
 	.owner			= THIS_MODULE,
 	.hw_init		= cmx270_pcmcia_hw_init,
 	.hw_shutdown		= cmx270_pcmcia_shutdown,
 	.socket_state		= cmx270_pcmcia_socket_state,
 	.configure_socket	= cmx270_pcmcia_configure_socket,
-	.socket_init		= cmx270_pcmcia_socket_init,
-	.socket_suspend		= cmx270_pcmcia_socket_suspend,
 	.nr			= 1,
 };
 
diff --git a/drivers/pcmcia/pxa2xx_colibri.c b/drivers/pcmcia/pxa2xx_colibri.c
index 443cb7f..c6dec57 100644
--- a/drivers/pcmcia/pxa2xx_colibri.c
+++ b/drivers/pcmcia/pxa2xx_colibri.c
@@ -116,14 +116,6 @@ colibri_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
 	return 0;
 }
 
-static void colibri_pcmcia_socket_init(struct soc_pcmcia_socket *skt)
-{
-}
-
-static void colibri_pcmcia_socket_suspend(struct soc_pcmcia_socket *skt)
-{
-}
-
 static struct pcmcia_low_level colibri_pcmcia_ops = {
 	.owner			= THIS_MODULE,
 
@@ -135,9 +127,6 @@ static struct pcmcia_low_level colibri_pcmcia_ops = {
 
 	.socket_state		= colibri_pcmcia_socket_state,
 	.configure_socket	= colibri_pcmcia_configure_socket,
-
-	.socket_init		= colibri_pcmcia_socket_init,
-	.socket_suspend		= colibri_pcmcia_socket_suspend,
 };
 
 static struct platform_device *colibri_pcmcia_device;
diff --git a/drivers/pcmcia/pxa2xx_mainstone.c b/drivers/pcmcia/pxa2xx_mainstone.c
index 92016fe..aded706c 100644
--- a/drivers/pcmcia/pxa2xx_mainstone.c
+++ b/drivers/pcmcia/pxa2xx_mainstone.c
@@ -128,22 +128,12 @@ static int mst_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
 	return ret;
 }
 
-static void mst_pcmcia_socket_init(struct soc_pcmcia_socket *skt)
-{
-}
-
-static void mst_pcmcia_socket_suspend(struct soc_pcmcia_socket *skt)
-{
-}
-
 static struct pcmcia_low_level mst_pcmcia_ops __initdata = {
 	.owner			= THIS_MODULE,
 	.hw_init		= mst_pcmcia_hw_init,
 	.hw_shutdown		= mst_pcmcia_hw_shutdown,
 	.socket_state		= mst_pcmcia_socket_state,
 	.configure_socket	= mst_pcmcia_configure_socket,
-	.socket_init		= mst_pcmcia_socket_init,
-	.socket_suspend		= mst_pcmcia_socket_suspend,
 	.nr			= 2,
 };
 
diff --git a/drivers/pcmcia/pxa2xx_palmld.c b/drivers/pcmcia/pxa2xx_palmld.c
index 69f7367..d589ad1 100644
--- a/drivers/pcmcia/pxa2xx_palmld.c
+++ b/drivers/pcmcia/pxa2xx_palmld.c
@@ -65,14 +65,6 @@ static int palmld_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
 	return 0;
 }
 
-static void palmld_pcmcia_socket_init(struct soc_pcmcia_socket *skt)
-{
-}
-
-static void palmld_pcmcia_socket_suspend(struct soc_pcmcia_socket *skt)
-{
-}
-
 static struct pcmcia_low_level palmld_pcmcia_ops = {
 	.owner			= THIS_MODULE,
 
@@ -84,9 +76,6 @@ static struct pcmcia_low_level palmld_pcmcia_ops = {
 
 	.socket_state		= palmld_pcmcia_socket_state,
 	.configure_socket	= palmld_pcmcia_configure_socket,
-
-	.socket_init		= palmld_pcmcia_socket_init,
-	.socket_suspend		= palmld_pcmcia_socket_suspend,
 };
 
 static struct platform_device *palmld_pcmcia_device;
diff --git a/drivers/pcmcia/pxa2xx_palmtc.c b/drivers/pcmcia/pxa2xx_palmtc.c
index d0ad6a7..9c6a04b 100644
--- a/drivers/pcmcia/pxa2xx_palmtc.c
+++ b/drivers/pcmcia/pxa2xx_palmtc.c
@@ -117,14 +117,6 @@ static int palmtc_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
 	return ret;
 }
 
-static void palmtc_pcmcia_socket_init(struct soc_pcmcia_socket *skt)
-{
-}
-
-static void palmtc_pcmcia_socket_suspend(struct soc_pcmcia_socket *skt)
-{
-}
-
 static struct pcmcia_low_level palmtc_pcmcia_ops = {
 	.owner			= THIS_MODULE,
 
@@ -136,9 +128,6 @@ static struct pcmcia_low_level palmtc_pcmcia_ops = {
 
 	.socket_state		= palmtc_pcmcia_socket_state,
 	.configure_socket	= palmtc_pcmcia_configure_socket,
-
-	.socket_init		= palmtc_pcmcia_socket_init,
-	.socket_suspend		= palmtc_pcmcia_socket_suspend,
 };
 
 static struct platform_device *palmtc_pcmcia_device;
diff --git a/drivers/pcmcia/pxa2xx_palmtx.c b/drivers/pcmcia/pxa2xx_palmtx.c
index 1a25804..80645a6 100644
--- a/drivers/pcmcia/pxa2xx_palmtx.c
+++ b/drivers/pcmcia/pxa2xx_palmtx.c
@@ -67,14 +67,6 @@ palmtx_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
 	return 0;
 }
 
-static void palmtx_pcmcia_socket_init(struct soc_pcmcia_socket *skt)
-{
-}
-
-static void palmtx_pcmcia_socket_suspend(struct soc_pcmcia_socket *skt)
-{
-}
-
 static struct pcmcia_low_level palmtx_pcmcia_ops = {
 	.owner			= THIS_MODULE,
 
@@ -86,9 +78,6 @@ static struct pcmcia_low_level palmtx_pcmcia_ops = {
 
 	.socket_state		= palmtx_pcmcia_socket_state,
 	.configure_socket	= palmtx_pcmcia_configure_socket,
-
-	.socket_init		= palmtx_pcmcia_socket_init,
-	.socket_suspend		= palmtx_pcmcia_socket_suspend,
 };
 
 static struct platform_device *palmtx_pcmcia_device;
diff --git a/drivers/pcmcia/pxa2xx_viper.c b/drivers/pcmcia/pxa2xx_viper.c
index a51f207..1064b1c 100644
--- a/drivers/pcmcia/pxa2xx_viper.c
+++ b/drivers/pcmcia/pxa2xx_viper.c
@@ -136,22 +136,12 @@ static int viper_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
 	return 0;
 }
 
-static void viper_pcmcia_socket_init(struct soc_pcmcia_socket *skt)
-{
-}
-
-static void viper_pcmcia_socket_suspend(struct soc_pcmcia_socket *skt)
-{
-}
-
 static struct pcmcia_low_level viper_pcmcia_ops = {
 	.owner          	= THIS_MODULE,
 	.hw_init        	= viper_pcmcia_hw_init,
 	.hw_shutdown		= viper_pcmcia_hw_shutdown,
 	.socket_state		= viper_pcmcia_socket_state,
 	.configure_socket	= viper_pcmcia_configure_socket,
-	.socket_init		= viper_pcmcia_socket_init,
-	.socket_suspend		= viper_pcmcia_socket_suspend,
 	.nr         		= 1,
 };
 
-- 
1.7.3.4
