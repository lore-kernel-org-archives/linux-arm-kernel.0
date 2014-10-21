From: kaixu.xia@linaro.org (Xia Kaixu)
Date: Tue, 21 Oct 2014 22:11:33 +0800
Subject: [PATCH 3/4] ARM: restrict CPU_BIG_ENDIAN configuration option
In-Reply-To: <1413900694-29571-1-git-send-email-kaixu.xia@linaro.org>
References: <1413900694-29571-1-git-send-email-kaixu.xia@linaro.org>
Message-ID: <1413900694-29571-4-git-send-email-kaixu.xia@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some platforms don't work when CPU_BIG_ENDIAN is enabled.
So It can get a dependency on !ARCH_MULTIPLATFORM_STRICT.

Signed-off-by: Xia Kaixu <kaixu.xia@linaro.org>
---
 arch/arm/mm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index ae69809..d510448 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -698,6 +698,7 @@ config SWP_EMULATE
 config CPU_BIG_ENDIAN
 	bool "Build big-endian kernel"
 	depends on ARCH_SUPPORTS_BIG_ENDIAN
+	depends on !ARCH_MULTIPLATFORM_STRICT
 	help
 	  Say Y if you plan on running a kernel in big-endian mode.
 	  Note that your board must be properly built and your board
-- 
2.1.1
