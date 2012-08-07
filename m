From: tony@atomide.com (Tony Lindgren)
Date: Tue, 7 Aug 2012 03:40:23 -0700
Subject: [PATCH 1/2] ARM: OMAP: clean up some smatch warnings, fix some
 printk(KERN_ERR ...
In-Reply-To: <20120807103439.8053.65054.stgit@dusk.lan>
References: <20120807103009.8053.69389.stgit@dusk.lan>
 <20120807103439.8053.65054.stgit@dusk.lan>
Message-ID: <20120807104023.GV11011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [120807 03:35]:
> --- a/arch/arm/mach-omap1/lcd_dma.c
> +++ b/arch/arm/mach-omap1/lcd_dma.c
> @@ -94,7 +94,6 @@ void omap_set_lcd_dma_b1_rotation(int rotate)
>  	if (cpu_is_omap15xx()) {
>  		printk(KERN_ERR "DMA rotation is not supported in 1510 mode\n");
>  		BUG();
> -		return;
>  	}
>  	lcd_dma.rotate = rotate;
>  }
> @@ -154,7 +153,6 @@ static void set_b1_regs(void)
>  		break;
>  	default:
>  		BUG();
> -		return;
>  	}
>  
>  	vxres = lcd_dma.vxres ? lcd_dma.vxres : lcd_dma.xres;
> @@ -234,7 +232,6 @@ static void set_b1_regs(void)
>  		break;
>  	default:
>  		BUG();
> -		return;	/* Suppress warning about uninitialized vars */
>  	}
>  
>  	if (cpu_is_omap15xx()) {

I think these will cause new randconfig warnings without CONFIG_BUG set.

Tony
