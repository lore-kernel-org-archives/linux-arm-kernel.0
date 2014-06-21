From: dwalter@google.com (Daniel Walter)
Date: Sat, 21 Jun 2014 13:04:41 +0100
Subject: [PATCH 2/9] [arch/arm/mach-pxa] replace strict_strto call with kstrto
Message-ID: <20140621120441.GA5712@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Replace obsolete call to strict_strto with kstrto

Signed-off-by: Daniel Walter <dwalter@google.com>
---
 arch/arm/mach-pxa/balloon3.c | 2 +-
 arch/arm/mach-pxa/viper.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index 43596e0..d897292 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -90,7 +90,7 @@ int __init parse_balloon3_features(char *arg)
 	if (!arg)
 		return 0;
 
-	return strict_strtoul(arg, 0, &balloon3_features_present);
+	return kstrtoul(arg, 0, &balloon3_features_present);
 }
 early_param("balloon3_features", parse_balloon3_features);
 
diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
index 41f27f6..de3b080 100644
--- a/arch/arm/mach-pxa/viper.c
+++ b/arch/arm/mach-pxa/viper.c
@@ -769,7 +769,7 @@ static unsigned long viper_tpm;
 
 static int __init viper_tpm_setup(char *str)
 {
-	return strict_strtoul(str, 10, &viper_tpm) >= 0;
+	return kstrtoul(str, 10, &viper_tpm) >= 0;
 }
 
 __setup("tpm=", viper_tpm_setup);
-- 
2.0.0.526.g5318336
