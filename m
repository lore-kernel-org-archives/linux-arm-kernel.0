From: rickard_strandqvist@spectrumdigital.se (Rickard Strandqvist)
Date: Sun,  7 Dec 2014 02:16:44 +0100
Subject: [PATCH] arch: arm: mach-msm: vreg.c:  Remove unused function
Message-ID: <1417915004-8574-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the function vreg_put() that is not used anywhere.

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 arch/arm/mach-msm/include/mach/vreg.h |    1 -
 arch/arm/mach-msm/vreg.c              |    4 ----
 2 files changed, 5 deletions(-)

diff --git a/arch/arm/mach-msm/include/mach/vreg.h b/arch/arm/mach-msm/include/mach/vreg.h
index 6626e78..28351ff 100644
--- a/arch/arm/mach-msm/include/mach/vreg.h
+++ b/arch/arm/mach-msm/include/mach/vreg.h
@@ -20,7 +20,6 @@
 struct vreg;
 
 struct vreg *vreg_get(struct device *dev, const char *id);
-void vreg_put(struct vreg *vreg);
 
 int vreg_enable(struct vreg *vreg);
 int vreg_disable(struct vreg *vreg);
diff --git a/arch/arm/mach-msm/vreg.c b/arch/arm/mach-msm/vreg.c
index bd66ed0..0bf891d 100644
--- a/arch/arm/mach-msm/vreg.c
+++ b/arch/arm/mach-msm/vreg.c
@@ -96,10 +96,6 @@ struct vreg *vreg_get(struct device *dev, const char *id)
 	return ERR_PTR(-ENOENT);
 }
 
-void vreg_put(struct vreg *vreg)
-{
-}
-
 int vreg_enable(struct vreg *vreg)
 {
 	unsigned id = vreg->id;
-- 
1.7.10.4
