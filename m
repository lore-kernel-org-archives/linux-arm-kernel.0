From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Mon,  8 Jul 2013 09:18:06 +0100
Subject: [PATCH v1 2/4] ARM: STi: Set correct ARM ERRATAs.
In-Reply-To: <1373271301-11060-1-git-send-email-srinivas.kandagatla@st.com>
References: <1373271301-11060-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <1373271486-11631-1-git-send-email-srinivas.kandagatla@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

Some of the ARM_ERRATA selection is not done in the initial SOC support
patches. This patch selects 2 new ARM_ERRATA's and removes one which was
actually fixed.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
 arch/arm/mach-sti/Kconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-sti/Kconfig b/arch/arm/mach-sti/Kconfig
index d04e3bf..c216094 100644
--- a/arch/arm/mach-sti/Kconfig
+++ b/arch/arm/mach-sti/Kconfig
@@ -11,8 +11,9 @@ menuconfig ARCH_STI
 	select HAVE_SMP
 	select HAVE_ARM_SCU if SMP
 	select ARCH_REQUIRE_GPIOLIB
-	select ARM_ERRATA_720789
 	select ARM_ERRATA_754322
+	select ARM_ERRATA_775420
+	select ARM_ERRATA_764369
 	select PL310_ERRATA_753970 if CACHE_PL310
 	select PL310_ERRATA_769419 if CACHE_PL310
 	help
-- 
1.7.6.5
