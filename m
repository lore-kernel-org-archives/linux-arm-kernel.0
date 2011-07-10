From: grant.likely@secretlab.ca (Grant Likely)
Date: Sun, 10 Jul 2011 13:02:18 +0900
Subject: [PATCH] ARM: mmp: remove builtin gpio driver support
In-Reply-To: <1310120428-22700-2-git-send-email-haojian.zhuang@marvell.com>
References: <1310120428-22700-1-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-2-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <20110710040218.GA10912@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2011 at 06:20:18PM +0800, Haojian Zhuang wrote:
> Remove builtin gpio driver support form mmp.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>

Hi Haojian.

I'm not clear what this patch is intending to do.  I understand that
it removes the mmp-specific gpio support, but I looks like don't see the code
that replaces it, which would mean that applying this patch breaks
gpio on mmp platforms.

Am I missing something?

> diff --git a/arch/arm/plat-pxa/Makefile b/arch/arm/plat-pxa/Makefile
> index 3aca5ba..8e432b1 100644
> --- a/arch/arm/plat-pxa/Makefile
> +++ b/arch/arm/plat-pxa/Makefile
> @@ -4,7 +4,9 @@
>  
>  obj-y	:= dma.o
>  
> +ifeq ($(CONFIG_OF),)
>  obj-$(CONFIG_GENERIC_GPIO)	+= gpio.o
> +endif

Be careful about this.  Turning on device tree support must not
disable booting on non-DT machines.

g.
