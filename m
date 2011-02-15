From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue, 15 Feb 2011 15:51:19 +0200
Subject: [PATCH] ARM: PXA: Make PXA27x/PXA3xx overlay actually work
In-Reply-To: <AANLkTinu2LT4t=f=Y0ZBmT6=nsoiQ9HVVTYmzgLMpDXR@mail.gmail.com>
References: <1296679619-32666-1-git-send-email-anarsoul@gmail.com>
	<201102151358.47203.anarsoul@gmail.com>
	<AANLkTinu2LT4t=f=Y0ZBmT6=nsoiQ9HVVTYmzgLMpDXR@mail.gmail.com>
Message-ID: <201102151551.20080.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 February 2011 15:36:07 you wrote:

> Then maybe in this way? (I'd rather keep this bit in overlay specific
> code, and make it valid not only to pxa27x)
> 
> @@ -925,6 +925,8 @@ static int __devinit pxafb_overlay_init(struct
> pxafb_info *fbi)
> 
>         /* place overlay(s) on top of base */
>         fbi->lccr0 |= LCCR0_OUC;
> +       lcd_writel(fbi, LCCR0, fbi->lccr0 & ~LCCR0_ENB);
> +
>         pr_info("PXA Overlay driver loaded successfully!\n");
>         return 0;

I tried it, it doesn't work that way (I got garbage on screen). Maybe it's not 
right time to modify LCCR0 reg?
