From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 25 Jan 2016 14:41:10 +0100
Subject: [PATCH 2/2] ARM: DTS: kirkwood-openrd: fix SD slot default
 configuration
In-Reply-To: <1452629253-21748-2-git-send-email-aaro.koskinen@iki.fi> (Aaro
 Koskinen's message of "Tue, 12 Jan 2016 22:07:33 +0200")
References: <1452629253-21748-1-git-send-email-aaro.koskinen@iki.fi>
 <1452629253-21748-2-git-send-email-aaro.koskinen@iki.fi>
Message-ID: <87r3h5epzd.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Aaro,
 
 On mar., janv. 12 2016, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:

> The SD card slot was enabled by default with legacy booting.
> It does not work anymore with DT boot. Fix by providing GPIO configuration
> that matches the old default.
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Applied on mvebu/dt with Andrew Reviewed-by

Thanks,

Gregory
> ---
>  arch/arm/boot/dts/kirkwood-openrd.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/boot/dts/kirkwood-openrd.dtsi b/arch/arm/boot/dts/kirkwood-openrd.dtsi
> index 2a3dafd..f65b727 100644
> --- a/arch/arm/boot/dts/kirkwood-openrd.dtsi
> +++ b/arch/arm/boot/dts/kirkwood-openrd.dtsi
> @@ -65,6 +65,14 @@
>  			status = "okay";
>  			cd-gpios = <&gpio0 29 9>;
>  		};
> +		gpio at 10140 {
> +			p2 {
> +				gpio-hog;
> +				gpios = <2 GPIO_ACTIVE_HIGH>;
> +				output-high; /* Select SD by default */
> +				line-name = "SelUARTorSD";
> +			};
> +		};
>  	};
>  };
>  
> -- 
> 2.4.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
