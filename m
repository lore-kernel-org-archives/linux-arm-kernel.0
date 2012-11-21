From: olof@lixom.net (Olof Johansson)
Date: Tue, 20 Nov 2012 22:37:11 -0800
Subject: [PATCH v3 14/18] ARM: clps711x: Moving backlight controls of
 framebuffer driver to the board
In-Reply-To: <1353160644-22446-15-git-send-email-shc_work@mail.ru>
References: <1353160644-22446-1-git-send-email-shc_work@mail.ru>
 <1353160644-22446-15-git-send-email-shc_work@mail.ru>
Message-ID: <20121121063711.GB7615@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Nov 17, 2012 at 05:57:20PM +0400, Alexander Shiyan wrote:

> @@ -162,25 +158,12 @@ clps7111fb_set_par(struct fb_info *info)
>  
>  static int clps7111fb_blank(int blank, struct fb_info *info)
>  {
> -    	if (blank) {
> -		if (machine_is_edb7211()) {
> -			/* Turn off the LCD backlight. */
> -			clps_writeb(clps_readb(PDDR) & ~EDB_PD3_LCDBL, PDDR);
> -
> -			/* Disable LCD controller. */
> -			clps_writel(clps_readl(SYSCON1) & ~SYSCON1_LCDEN, 
> -					SYSCON1);
> -		}
> -	} else {
> -		if (machine_is_edb7211()) {
> -			/* Enable LCD controller. */
> -			clps_writel(clps_readl(SYSCON1) | SYSCON1_LCDEN,
> -					SYSCON1);
> -
> -			/* Turn on the LCD backlight. */
> -			clps_writeb(clps_readb(PDDR) | EDB_PD3_LCDBL, PDDR);
> -		}
> -	}
> +	/* Enable/Disable LCD controller. */
> +    	if (blank)
> +		clps_writel(clps_readl(SYSCON1) & ~SYSCON1_LCDEN, SYSCON1);

I fixed up spaces-before-tabs on the line above when I applied the patch.


-Olof
