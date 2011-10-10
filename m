From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Oct 2011 03:35:27 +0200
Subject: [PATCH 1/9] ARM: vic: Don't write to the read-only register
	VIC_IRQ_STATUS
In-Reply-To: <1318178172-7965-2-git-send-email-zoss@devai.org>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
	<1318178172-7965-2-git-send-email-zoss@devai.org>
Message-ID: <CAKnu2Mpnp9hNhdzFURQGvTbeoVpyKfWY2YU3MDs2yEPgC-YYAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/10/9 Zoltan Devai <zoss@devai.org>:

> This is unneeded and causes an abort on the SPMP8000 platform.
>
> Signed-off-by: Zoltan Devai <zoss@devai.org>
> ---
> ?arch/arm/common/vic.c | ? ?1 -
> ?1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
> index b22b83d..651c77d 100644
> --- a/arch/arm/common/vic.c
> +++ b/arch/arm/common/vic.c
> @@ -274,7 +274,6 @@ static void __init vic_disable(void __iomem *base)
> ? ? ? ?writel(0, base + VIC_INT_SELECT);
> ? ? ? ?writel(0, base + VIC_INT_ENABLE);
> ? ? ? ?writel(~0, base + VIC_INT_ENABLE_CLEAR);
> - ? ? ? writel(0, base + VIC_IRQ_STATUS);
> ? ? ? ?writel(0, base + VIC_ITCR);
> ? ? ? ?writel(~0, base + VIC_INT_SOFT_CLEAR);
> ?}

Indeed.

This patch stands on its own, please put it into Russell's patch
tracker at http://www.arm.linux.org.uk/developer/patches/

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
