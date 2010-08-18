From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Wed, 18 Aug 2010 16:40:56 -0700
Subject: [PATCH 3/6] ARM: LPC32xx: Fix gpiolib bit mask macro
In-Reply-To: <1282174859-8780-1-git-send-email-wellsk40@gmail.com>
References: <1282174859-8780-1-git-send-email-wellsk40@gmail.com>
Message-ID: <1282174859-8780-4-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

The GPIO bank 3 input mask macro was missing a critical mask that
would cause it to return invalid pin states

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 arch/arm/mach-lpc32xx/gpiolib.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/gpiolib.c b/arch/arm/mach-lpc32xx/gpiolib.c
index 69061ea..16577c5 100644
--- a/arch/arm/mach-lpc32xx/gpiolib.c
+++ b/arch/arm/mach-lpc32xx/gpiolib.c
@@ -59,7 +59,8 @@
 #define GPO3_PIN_TO_BIT(x)			(1 << (x))
 #define GPIO012_PIN_IN_SEL(x, y)		(((x) >> (y)) & 1)
 #define GPIO3_PIN_IN_SHIFT(x)			((x) == 5 ? 24 : 10 + (x))
-#define GPIO3_PIN_IN_SEL(x, y)			((x) >> GPIO3_PIN_IN_SHIFT(y))
+#define GPIO3_PIN_IN_SEL(x, y)			(((x) >> \
+						GPIO3_PIN_IN_SHIFT(y)) & 1)
 #define GPIO3_PIN5_IN_SEL(x)			(((x) >> 24) & 1)
 #define GPI3_PIN_IN_SEL(x, y)			(((x) >> (y)) & 1)
 
-- 
1.7.1.1
