From: hzhuang1@marvell.com (Haojian Zhuang)
Date: Thu, 4 Nov 2010 08:05:59 -0700
Subject: [PATCH 2/2] ARM: pxa/saar: fix the building failure caused by typo
In-Reply-To: <1288704649-3026-1-git-send-email-eric.y.miao@gmail.com>
References: <1288704649-3026-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <25B60CDC2F704E4E9D88FFD52780CB4C05986427B7@SC-VEXCH1.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>-----Original Message-----
From: eric.y.miao@gmail.com [mailto:eric.y.miao at gmail.com]
>Sent: 2010?11?2? 9:31 PM
>To: linux-arm-kernel at lists.infradead.org
>Cc: Eric Miao; Haojian Zhuang
>Subject: [PATCH 2/2] ARM: pxa/saar: fix the building failure caused by typo
>
>From: Eric Miao <eric.y.miao@gmail.com>
>
>Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
>Cc: Haojian Zhuang <haojian.zhuang@marvell.com>
>---
> arch/arm/mach-pxa/saar.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>
>diff --git a/arch/arm/mach-pxa/saar.c b/arch/arm/mach-pxa/saar.c
>index 2e2f5a3..c1ca8cb 100644
>--- a/arch/arm/mach-pxa/saar.c
>+++ b/arch/arm/mach-pxa/saar.c
>@@ -116,7 +116,7 @@ static struct platform_device smc91x_device = {
> 	},
> };
>
>-#if defined(CONFIG_FB_PXA) || (CONFIG_FB_PXA_MODULE)
>+#if defined(CONFIG_FB_PXA) || defined(CONFIG_FB_PXA_MODULE)
> static uint16_t lcd_power_on[] = {
> 	/* single frame */
> 	SMART_CMD_NOOP,
>--
>1.7.1

If FB_PXA is compiled as module, another build failure occurs. My patch is in another thread.

Thanks
Haojian
