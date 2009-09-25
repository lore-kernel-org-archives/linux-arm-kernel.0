From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 25 Sep 2009 15:43:13 -0400
Subject: [PATCH] pxa: support pxa3xx onenand in saar and ttc dkb
Message-ID: <mailman.33.1253880186.2253.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marvell PXA3xx bad block management is supported in pxa3xx onenand
device driver. Enable it in saar and ttc dkb platform.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-mmp/ttc_dkb.c |    2 +-
 arch/arm/mach-pxa/saar.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
index 57d0535..dbd8cfd 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -100,7 +100,7 @@ static struct resource ttc_dkb_resource_onenand[] = {
 };

 static struct platform_device ttc_dkb_device_onenand = {
-    .name        = "onenand",
+    .name        = "pxa3xx-onenand",
     .id        = -1,
     .dev        = {
         .platform_data    = &ttc_dkb_onenand_info,
diff --git a/arch/arm/mach-pxa/saar.c b/arch/arm/mach-pxa/saar.c
index 8b7ea09..6892867 100644
--- a/arch/arm/mach-pxa/saar.c
+++ b/arch/arm/mach-pxa/saar.c
@@ -556,7 +556,7 @@ static struct resource saar_resource_onenand[] = {
 };

 static struct platform_device saar_device_onenand = {
-    .name        = "onenand",
+    .name        = "pxa3xx-onenand",
     .id        = -1,
     .dev        = {
         .platform_data    = &saar_onenand_info,
-- 
1.5.6.5

--001517741a14b62254047465bad3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
