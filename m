From: kees@outflux.net (Kees Cook)
Date: Fri, 9 Dec 2011 13:11:57 -0800
Subject: [PATCH] arm: standardize /proc/iomem "Kernel code" name
Message-ID: <20111209211157.GA2146@outflux.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All other ports use "Kernel code" to identify the Kernel text segment
in /proc/iomem. Change the ARM resources to do the same.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/kernel/setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 3448a3f..a34dbf6 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -158,7 +158,7 @@ static struct resource mem_res[] = {
 		.flags = IORESOURCE_MEM
 	},
 	{
-		.name = "Kernel text",
+		.name = "Kernel code",
 		.start = 0,
 		.end = 0,
 		.flags = IORESOURCE_MEM
-- 
1.7.5.4


-- 
Kees Cook                                            @outflux.net
