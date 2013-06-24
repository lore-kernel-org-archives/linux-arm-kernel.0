From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 24 Jun 2013 17:04:20 +0200
Subject: [PATCH] ASoC: Tegra and i.MX are mutually exclusive
Message-ID: <5967649.DUvDfofhX4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both Tegra and i.MX provide ac97 operations, which can only
exist once in the kernel. They can both be built as loadable
modules (only one of them needs to be loaded anyway), but we
have to disallow enabling them both as built-in.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 3843a18..5958948 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -99,6 +99,7 @@ endif # SND_POWERPC_SOC
 menuconfig SND_IMX_SOC
 	tristate "SoC Audio for Freescale i.MX CPUs"
 	depends on ARCH_MXC
+	depends on SND_SOC_TEGRA=n || (SND_SOC_TEGRA=m && m)
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  the i.MX CPUs.
