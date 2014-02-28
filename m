From: tony@atomide.com (Tony Lindgren)
Date: Fri, 28 Feb 2014 14:57:51 -0800
Subject: [PATCH] ARM: dts: am335x-evmsk: enable USB1
In-Reply-To: <1393571944-10438-1-git-send-email-yegorslists@googlemail.com>
References: <1393571944-10438-1-git-send-email-yegorslists@googlemail.com>
Message-ID: <20140228225750.GV13624@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* yegorslists at googlemail.com <yegorslists@googlemail.com> [140227 23:22]:
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> Enable second USB channel and set it into 'host' mode.
> 
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

Thanks applying into omap-for-v3.15/dt.

Tony

> ---
>  arch/arm/boot/dts/am335x-evmsk.dts |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
> index 486880b..40a66bd 100644
> --- a/arch/arm/boot/dts/am335x-evmsk.dts
> +++ b/arch/arm/boot/dts/am335x-evmsk.dts
> @@ -342,9 +342,18 @@
>  		status = "okay";
>  	};
>  
> +	usb-phy at 47401b00 {
> +		status = "okay";
> +	};
> +
>  	usb at 47401000 {
>  		status = "okay";
>  	};
> +
> +	usb at 47401800 {
> +		status = "okay";
> +		dr_mode = "host";
> +	};
>  };
>  
>  &epwmss2 {
> -- 
> 1.7.7
> 
