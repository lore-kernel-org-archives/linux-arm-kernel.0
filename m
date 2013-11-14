From: olof@lixom.net (Olof Johansson)
Date: Wed, 13 Nov 2013 16:46:13 -0800
Subject: [PATCH 1/2] ARM: sti: only select errata 764369 if SMP
Message-ID: <1384389974-6229-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

764369 depends on SMP, so don't select it on !SMP configs.

Signed-off-by: Olof Johansson <olof@lixom.net>
Cc: Srinivas Kandagatla <srinivas.kandagatla@st.com>
Cc: Stuart Menefy <stuart.menefy@st.com>
---
 arch/arm/mach-sti/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-sti/Kconfig b/arch/arm/mach-sti/Kconfig
index 835833e3c4f8..939ddb8f482b 100644
--- a/arch/arm/mach-sti/Kconfig
+++ b/arch/arm/mach-sti/Kconfig
@@ -12,7 +12,7 @@ menuconfig ARCH_STI
 	select HAVE_ARM_SCU if SMP
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_ERRATA_754322
-	select ARM_ERRATA_764369
+	select ARM_ERRATA_764369 if SMP
 	select ARM_ERRATA_775420
 	select PL310_ERRATA_753970 if CACHE_PL310
 	select PL310_ERRATA_769419 if CACHE_PL310
-- 
1.8.4.1.601.g02b3b1d
