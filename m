From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 5 Dec 2013 17:00:08 +0100
Subject: [PATCH] ARM: at91: remove redundant dependency
In-Reply-To: <1384932191-8967-1-git-send-email-michael.opdenacker@free-electrons.com>
References: <1384932191-8967-1-git-send-email-michael.opdenacker@free-electrons.com>
Message-ID: <1386259208-2239-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yanis Moreno <yanis.moreno63@gmail.com>

This removes the "depends on SOC_SAM_V7" statement
in a Kconfig section that's under an "if SOC_SAM_V7"
condition (same parameter).

Signed-off-by: Yanis Moreno <yanis.moreno63@gmail.com>
Reviewed-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
Hi Olof,

This is an additional patch for cleanup. I didn't include it in my previous
"cleanup" branch as I had wanted to keep it focused on the move to CCF.

As you said that you are okay with applying patches and that I have only one
related to "cleanup" for the moment, I send it to you.

Thanks, bye,
  Nicolas Ferre

 arch/arm/mach-at91/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index b4f7d6ffa30b..aac7814db4f9 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -82,7 +82,6 @@ comment "Atmel AT91 Processor"
 if SOC_SAM_V7
 config SOC_SAMA5D3
 	bool "SAMA5D3 family"
-	depends on SOC_SAM_V7
 	select SOC_SAMA5
 	select HAVE_FB_ATMEL
 	select HAVE_AT91_DBGU1
-- 
1.8.2.2
