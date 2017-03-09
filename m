From: inki.dae@samsung.com (Inki Dae)
Date: Thu, 09 Mar 2017 16:34:09 +0900
Subject: linux-4.11-rc1/drivers/gpu/drm/exynos/exynos5433_drm_decon.c:681:
 suspicious mask ?
In-Reply-To: <DB5PR08MB0967CD7B84545DE129126A619C2C0@DB5PR08MB0967.eurprd08.prod.outlook.com>
References: <CGME20170306100527epcas1p349cea73e30f7720a65d312808c4b2cc3@epcas1p3.samsung.com>
 <DB5PR08MB0967CD7B84545DE129126A619C2C0@DB5PR08MB0967.eurprd08.prod.outlook.com>
Message-ID: <58C10571.9050107@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello David,

Thanks for report.

2017? 03? 06? 19:05? David Binderman ?(?) ? ?:
> Hello there,
> 
> linux-4.11-rc1/drivers/gpu/drm/exynos/exynos5433_drm_decon.c:681]: (warning) Result of operator '|' is always true if one operand is non-zero. Did you intend to use '&'?
> 

Right. this is known issue and below patch fixes this,
http://www.spinics.net/lists/dri-devel/msg132589.html

This patch will go to -fixes.

> Source code is
> 
>     if (ctx->out_type | I80_HW_TRG) {
> 
> Also in the same file:
> 
> [drivers/gpu/drm/exynos/exynos5433_drm_decon.c:131]: (style) Same expression on both sides of '|'.
> 
> Source code is
> 
>        writel(TRIGCON_TE_AUTO_MASK | TRIGCON_SWTRIGEN
>                | TRIGCON_TE_AUTO_MASK | TRIGCON_SWTRIGEN,

In this case, only problem is two flags are set in duplicate. This should be cleaned up. Thanks. :)

> 
> Regards
> 
> David Binderman
> 
> 
