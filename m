From: richard.zhao@linaro.org (Richard Zhao)
Date: Thu, 2 Feb 2012 10:12:05 +0800
Subject: [PATCH v2 6/9] ARM: mx31ads: add audmux device
In-Reply-To: <1328148728-32258-1-git-send-email-richard.zhao@linaro.org>
References: <1328148728-32258-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1328148728-32258-7-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/mach-imx/mach-mx31ads.c      |   10 ++++++++++
 arch/arm/plat-mxc/include/mach/mx31.h |    1 +
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx31ads.c b/arch/arm/mach-imx/mach-mx31ads.c
index 4917aab..bb69e71 100644
--- a/arch/arm/mach-imx/mach-mx31ads.c
+++ b/arch/arm/mach-imx/mach-mx31ads.c
@@ -486,10 +486,20 @@ static unsigned int ssi_pins[] = {
 	MX31_PIN_STXD5__STXD5,
 };
 
+static const struct resource audmux_res[] __initconst = {
+	{
+		.start = MX31_AUDMUX_BASE_ADDR,
+		.end = MX31_AUDMUX_SIZE,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
 static void __init mxc_init_audio(void)
 {
 	imx31_add_imx_ssi(0, NULL);
 	mxc_iomux_setup_multiple_pins(ssi_pins, ARRAY_SIZE(ssi_pins), "ssi");
+	imx_add_platform_device("audmux-v2", 0,
+				audmux_res, ARRAY_SIZE(audmux_res), NULL, 0);
 }
 
 /* static mappings */
diff --git a/arch/arm/plat-mxc/include/mach/mx31.h b/arch/arm/plat-mxc/include/mach/mx31.h
index e27619e..8a3d5ef 100644
--- a/arch/arm/plat-mxc/include/mach/mx31.h
+++ b/arch/arm/plat-mxc/include/mach/mx31.h
@@ -66,6 +66,7 @@
 #define MX31_RNGA_BASE_ADDR			(MX31_AIPS2_BASE_ADDR + 0xb0000)
 #define MX31_IPU_CTRL_BASE_ADDR			(MX31_AIPS2_BASE_ADDR + 0xc0000)
 #define MX31_AUDMUX_BASE_ADDR			(MX31_AIPS2_BASE_ADDR + 0xc4000)
+#define MX31_AUDMUX_SIZE			(SZ_16K)
 #define MX31_MPEG4_ENC_BASE_ADDR		(MX31_AIPS2_BASE_ADDR + 0xc8000)
 #define MX31_GPIO1_BASE_ADDR			(MX31_AIPS2_BASE_ADDR + 0xcc000)
 #define MX31_GPIO2_BASE_ADDR			(MX31_AIPS2_BASE_ADDR + 0xd0000)
-- 
1.7.5.4
