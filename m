From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 07 Jun 2013 15:30:04 +0400
Subject: [PATCH 07/27] ARM: shmobile: r8a7740: Add interim sh-eth device
 name to clocks list
In-Reply-To: <1370591517-20239-8-git-send-email-horms+renesas@verge.net.au>
References: <1370591517-20239-1-git-send-email-horms+renesas@verge.net.au>
 <1370591517-20239-8-git-send-email-horms+renesas@verge.net.au>
Message-ID: <51B1C43C.9010805@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 07-06-2013 11:51, Simon Horman wrote:

> From: Bastian Hecht <hechtb@gmail.com>

> When we use the ethernet device via DT setup, we need to add it
> to a lookup list until this is properly handled later in a DT-only
> fashion.

> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>   arch/arm/mach-shmobile/clock-r8a7740.c | 1 +
>   1 file changed, 1 insertion(+)

> diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
> index 54afa04..008b11c 100644
> --- a/arch/arm/mach-shmobile/clock-r8a7740.c
> +++ b/arch/arm/mach-shmobile/clock-r8a7740.c
> @@ -592,6 +592,7 @@ static struct clk_lookup lookups[] = {
>   	CLKDEV_DEV_ID("sh_mmcif",		&mstp_clks[MSTP312]),
>   	CLKDEV_DEV_ID("e6bd0000.mmcif",         &mstp_clks[MSTP312]),
>   	CLKDEV_DEV_ID("sh-eth",			&mstp_clks[MSTP309]),
> +	CLKDEV_DEV_ID("e9a00000.sh-eth",	&mstp_clks[MSTP309]),

     I don't quite understand why this is needed. There's no device tree 
support for the 'sh_eth' driver yet. Oh well...

WBR, Sergei
