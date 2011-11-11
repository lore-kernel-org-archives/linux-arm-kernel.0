From: tanmay.upadhyay@einfochips.com (Tanmay Upadhyay)
Date: Fri, 11 Nov 2011 21:32:59 +0530
Subject: [PATCH] ARM: pxa168/gplugd: add the correct SSP device
In-Reply-To: <1321013994-6443-1-git-send-email-eric.y.miao@gmail.com>
References: <1321013994-6443-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <4EBD4733.4010801@einfochips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 11 November 2011 05:49 PM, Eric Miao wrote:
> There is no SSP0, but SSP2 is used on gplugd.
>
> Cc: Tanmay Upadhyay<tanmay.upadhyay@einfochips.com>
> Signed-off-by: Eric Miao<eric.y.miao@gmail.com>
> ---
>   arch/arm/mach-mmp/gplugd.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-mmp/gplugd.c b/arch/arm/mach-mmp/gplugd.c
> index 6915656..0469c74 100644
> --- a/arch/arm/mach-mmp/gplugd.c
> +++ b/arch/arm/mach-mmp/gplugd.c
> @@ -182,7 +182,7 @@ static void __init gplugd_init(void)
>
>   	/* on-chip devices */
>   	pxa168_add_uart(3);
> -	pxa168_add_ssp(0);
> +	pxa168_add_ssp(2);
>   	pxa168_add_twsi(0, NULL, ARRAY_AND_SIZE(gplugd_i2c_board_info));
>
>   	pxa168_add_eth(&gplugd_eth_platform_data);

Hi Eric,

HDMI chip (TDA9981A) on gplugD gets audio data from SSP0 - used as I2S. 
Page # 7 of [1] & page # 1 & 3 of [2] indicates this. SSP2 is also used 
on gplugD as SPI to talk to the NOR flash.

Thanks,

Tanmay

[1] http://www.globalscaletechnologies.com/download/gplugD-MBV2R1-web.pdf
[2] http://www.globalscaletechnologies.com/download/gplugD-IOV2R1-web.pdf
