From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu, 15 May 2014 11:08:55 +0100
Subject: [PATCH] ARM: QCOM: Enable ARM_AMBA option for Qcom SOCS.
Message-ID: <1400148535-30772-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As some of the IPs on Qualcomm SOCs are based on ARM PrimeCell IPs.
For example SDCC controller is PrimeCell MCI pl180. Adding this option will
give flexibility to reuse the existing drivers as it is without major
modifications.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/mach-qcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-qcom/Kconfig b/arch/arm/mach-qcom/Kconfig
index a028be2..5bac591 100644
--- a/arch/arm/mach-qcom/Kconfig
+++ b/arch/arm/mach-qcom/Kconfig
@@ -2,6 +2,7 @@ config ARCH_QCOM
 	bool "Qualcomm Support" if ARCH_MULTI_V7
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_GIC
+	select ARM_AMBA
 	select CLKSRC_OF
 	select GENERIC_CLOCKEVENTS
 	select HAVE_SMP
-- 
1.9.1
