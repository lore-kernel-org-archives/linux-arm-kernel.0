From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Wed, 19 Dec 2012 10:10:24 +0100 (CET)
Subject: [PATCH 1/2] ARM: r8a7740: Add interim sh-eth device name to
 clocks list
In-Reply-To: <1355851359-8871-2-git-send-email-hechtb+renesas@gmail.com>
References: <1355851359-8871-1-git-send-email-hechtb+renesas@gmail.com>
 <1355851359-8871-2-git-send-email-hechtb+renesas@gmail.com>
Message-ID: <Pine.LNX.4.64.1212191005280.12389@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bastian

Thanks for the patch.

On Tue, 18 Dec 2012, Bastian Hecht wrote:

> When we use the ethernet device via DT setup, we need to add it
> to a lookup list until this is properly handled later in a DT-only
> fashion.
> 
> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
> ---
>  arch/arm/mach-shmobile/clock-r8a7740.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
> index 19ce885..8765a76 100644
> --- a/arch/arm/mach-shmobile/clock-r8a7740.c
> +++ b/arch/arm/mach-shmobile/clock-r8a7740.c
> @@ -614,6 +614,7 @@ static struct clk_lookup lookups[] = {
>  	CLKDEV_DEV_ID("sh_mobile_sdhi.1",	&mstp_clks[MSTP313]),
>  	CLKDEV_DEV_ID("sh_mmcif",		&mstp_clks[MSTP312]),
>  	CLKDEV_DEV_ID("sh-eth",			&mstp_clks[MSTP309]),
> +	CLKDEV_DEV_ID("e9a00000.sh-eth",	&mstp_clks[MSTP309]),

In a recent thread

http://thread.gmane.org/gmane.linux.ports.sh.devel/18062/focus=18057

I've been suggested to use OF_DEV_AUXDATA(), isn't this also a case for 
it?

Thanks
Guennadi

>  
>  	CLKDEV_DEV_ID("sh_mobile_sdhi.2",	&mstp_clks[MSTP415]),
>  
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
