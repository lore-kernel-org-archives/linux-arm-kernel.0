From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 23 Jan 2016 23:07:44 +0100
Subject: [PATCH] ARM: pxa: let PXA27x select PINCTRL
In-Reply-To: <1453577004-15295-1-git-send-email-yamada.masahiro@socionext.com>
 (Masahiro Yamada's message of "Sun, 24 Jan 2016 04:23:24 +0900")
References: <1453577004-15295-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <87k2n0ar0v.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Masahiro Yamada <yamada.masahiro@socionext.com> writes:

> To use the newly added PXA27x pinctrl driver, this commit is needed
> as well as commit 4b15ec9d42b2 ("pinctrl: activate pxa architecture").
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
No, that's a bit to narrow selecting pinctrl for only pxa27x architecture.

I have this patch in my local tree for 2 monthes (see [1]). This is the patch
I'd rather have. I had not posted it as I didn't think the pinctrl work was over
yet. I know at least that pxa3xx is ready (as pinctrl-single should be used),
and I had not the time to create the map for pxa25x.

Cheers.

--
Robert

---8<---
>From 8e0da8ff579bd38a7923f15a905133814153ebdb Mon Sep 17 00:00:00 2001
From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Sun, 1 Nov 2015 20:07:31 +0100
Subject: [PATCH] ARM: pxa: use pinctrl

Select pinctrl for all PXA architectures.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 34e1569a11ee..e876e86f5b0a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -618,6 +618,7 @@ config ARCH_PXA
 	select HAVE_IDE
 	select IRQ_DOMAIN
 	select MULTI_IRQ_HANDLER
+	select PINCTRL
 	select PLAT_PXA
 	select SPARSE_IRQ
 	help
-- 
2.1.4
