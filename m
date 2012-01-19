From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Jan 2012 15:35:48 +0000
Subject: [PATCH 10/11] ARM: 7279/1: standardize /proc/iomem "Kernel code" name
In-Reply-To: <20120119153149.GB1068@n2100.arm.linux.org.uk>
References: <20120119153149.GB1068@n2100.arm.linux.org.uk>
Message-ID: <E1Rnu1k-0002pv-Ga@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All other ports use "Kernel code" to identify the Kernel text segment
in /proc/iomem. Change the ARM resources to do the same.

Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 129fbd5..95653d0 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -160,7 +160,7 @@ static struct resource mem_res[] = {
 		.flags = IORESOURCE_MEM
 	},
 	{
-		.name = "Kernel text",
+		.name = "Kernel code",
 		.start = 0,
 		.end = 0,
 		.flags = IORESOURCE_MEM
-- 
1.7.4.4
