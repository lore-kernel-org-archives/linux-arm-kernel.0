From: dcb314@hotmail.com (David Binderman)
Date: Mon, 6 Mar 2017 10:05:19 +0000
Subject: linux-4.11-rc1/drivers/gpu/drm/exynos/exynos5433_drm_decon.c:681:
 suspicious mask ?
Message-ID: <DB5PR08MB0967CD7B84545DE129126A619C2C0@DB5PR08MB0967.eurprd08.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello there,

linux-4.11-rc1/drivers/gpu/drm/exynos/exynos5433_drm_decon.c:681]: (warning) Result of operator '|' is always true if one operand is non-zero. Did you intend to use '&'?

Source code is

    if (ctx->out_type | I80_HW_TRG) {

Also in the same file:

[drivers/gpu/drm/exynos/exynos5433_drm_decon.c:131]: (style) Same expression on both sides of '|'.

Source code is

       writel(TRIGCON_TE_AUTO_MASK | TRIGCON_SWTRIGEN
               | TRIGCON_TE_AUTO_MASK | TRIGCON_SWTRIGEN,

Regards

David Binderman
