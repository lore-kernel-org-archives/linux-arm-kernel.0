From: a.hajda@samsung.com (Andrzej Hajda)
Date: Wed, 08 Mar 2017 10:01:41 +0100
Subject: linux-4.11-rc1/drivers/gpu/drm/exynos/exynos5433_drm_decon.c:681:
 suspicious mask ?
In-Reply-To: <DB5PR08MB0967CD7B84545DE129126A619C2C0@DB5PR08MB0967.eurprd08.prod.outlook.com>
References: <CGME20170307005334epcas4p22a43a5c4e8348ec53d8b0fbc58cde358@epcas4p2.samsung.com>
 <DB5PR08MB0967CD7B84545DE129126A619C2C0@DB5PR08MB0967.eurprd08.prod.outlook.com>
Message-ID: <c489ede9-aca6-bee9-4d82-b35cf720dcbd@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David, Inki,

Thanks for reporting.

On 06.03.2017 11:05, David Binderman wrote:
> Hello there,
>
> linux-4.11-rc1/drivers/gpu/drm/exynos/exynos5433_drm_decon.c:681]: (warning) Result of operator '|' is always true if one operand is non-zero. Did you intend to use '&'?
>
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

This typo was already reported by:
- Ilia Mirkin, I have uploaded 2nd fixed version of the patch,
apparently the 1st version has been merged [1],
- Dan Carpenter, he posted also the fix[2],
- and now David.

I guess at the moment the best solution is to get Dan's patch.

[1]: https://patchwork.kernel.org/patch/9493177/
[2]: https://patchwork.kernel.org/patch/9571375/

Regards
Andrzej

>
> Regards
>
> David Binderman
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
