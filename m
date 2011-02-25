From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Fri, 25 Feb 2011 13:48:15 +0100
Subject: [PATCH] eukrea-tlv320: add MBIMXSD51 support
Message-ID: <1298638095-4084-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 sound/soc/imx/Kconfig         |    3 ++-
 sound/soc/imx/eukrea-tlv320.c |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/imx/Kconfig b/sound/soc/imx/Kconfig
index 642270a..9eeb8f0 100644
--- a/sound/soc/imx/Kconfig
+++ b/sound/soc/imx/Kconfig
@@ -44,7 +44,8 @@ config SND_SOC_EUKREA_TLV320
 	tristate "Eukrea TLV320"
 	depends on MACH_EUKREA_MBIMX27_BASEBOARD \
 		|| MACH_EUKREA_MBIMXSD25_BASEBOARD \
-		|| MACH_EUKREA_MBIMXSD35_BASEBOARD
+		|| MACH_EUKREA_MBIMXSD35_BASEBOARD \
+		|| MACH_EUKREA_MBIMXSD51_BASEBOARD
 	select SND_SOC_TLV320AIC23
 	select SND_MXC_SOC_SSI
 	select SND_MXC_SOC_FIQ
diff --git a/sound/soc/imx/eukrea-tlv320.c b/sound/soc/imx/eukrea-tlv320.c
index 1e9bcca..75fb4b8 100644
--- a/sound/soc/imx/eukrea-tlv320.c
+++ b/sound/soc/imx/eukrea-tlv320.c
@@ -98,7 +98,8 @@ static int __init eukrea_tlv320_init(void)
 	int ret;
 
 	if (!machine_is_eukrea_cpuimx27() && !machine_is_eukrea_cpuimx25sd()
-		&& !machine_is_eukrea_cpuimx35sd())
+		&& !machine_is_eukrea_cpuimx35sd()
+		&& !machine_is_eukrea_cpuimx51sd())
 		/* return happy. We might run on a totally different machine */
 		return 0;
 
-- 
1.7.4
