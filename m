From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 02 Jul 2014 11:07:12 +0200
Subject: [PATCH/RFC 4/6] ARM: shmobile: r8a7778: add TMU clock support for
 DT
In-Reply-To: <1404275322-26514-5-git-send-email-horms+renesas@verge.net.au>
References: <1404275322-26514-1-git-send-email-horms+renesas@verge.net.au>
 <1404275322-26514-5-git-send-email-horms+renesas@verge.net.au>
Message-ID: <10404353.kCosisU6aq@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

Thank you for the patch.

On Wednesday 02 July 2014 06:28:40 Simon Horman wrote:
> This will be used when initialising TMU devices using DT
> until common clock framework support is added.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  arch/arm/mach-shmobile/clock-r8a7778.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-shmobile/clock-r8a7778.c
> b/arch/arm/mach-shmobile/clock-r8a7778.c index 9557907..67980a0 100644
> --- a/arch/arm/mach-shmobile/clock-r8a7778.c
> +++ b/arch/arm/mach-shmobile/clock-r8a7778.c
> @@ -244,7 +244,9 @@ static struct clk_lookup lookups[] = {
>  	CLKDEV_ICK_ID("src.7", "rcar_sound", &mstp_clks[MSTP524]),
>  	CLKDEV_ICK_ID("src.8", "rcar_sound", &mstp_clks[MSTP523]),
>  	CLKDEV_ICK_ID("fck", "sh-tmu.0", &mstp_clks[MSTP016]),
> +	CLKDEV_ICK_ID("fck", "ffd80000.timer", &mstp_clks[MSTP016]),
>  	CLKDEV_ICK_ID("fck", "sh-tmu.1", &mstp_clks[MSTP015]),
> +	CLKDEV_ICK_ID("fck", "ffd81000.timer", &mstp_clks[MSTP015]),
>  };
> 
>  void __init r8a7778_clock_init(void)

-- 
Regards,

Laurent Pinchart
