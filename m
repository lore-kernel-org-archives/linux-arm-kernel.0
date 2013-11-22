From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 22 Nov 2013 08:41:13 -0500
Subject: [PATCH] ARM: mvebu: Add DT entry for ReadyNAS Duo v2 to use
 gpio-poweroff driver
In-Reply-To: <87iovl4ahq.fsf@natisbad.org>
References: <87iovl4ahq.fsf@natisbad.org>
Message-ID: <20131122134113.GF29241@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 22, 2013 at 12:10:25AM +0100, Arnaud Ebalard wrote:
> 
> Without that fix, at the end of the shutdown process, the board is
> still powered (led glowing, fan running, ...).
> 
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> ---
> Hi,
> 
> I have prepared some cleanup patches for existing ReadyNAS .dts files
> which I intend to send for review in the next fex days. The GPIO
> voltage level is still a value below but the cleanup patch for this
> .dts will handle that globally.
> 
>  arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts b/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
> index e6a102c..4e3cae1 100644
> --- a/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
> +++ b/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
> @@ -60,6 +60,10 @@
>  				marvell,pins = "mpp29";
>  				marvell,function = "gpio";
>  			};
> +			pmx_poweroff: pmx-poweroff {
> +				marvell,pins = "mpp30";
> +				marvell,function = "gpio";
> +			};
>  		};
>  
>  		clocks {
> @@ -158,6 +162,13 @@
>  		};
>  	};
>  
> +	gpio-poweroff {
> +		compatible = "gpio-poweroff";
> +		pinctrl-0 = <&pmx_poweroff>;
> +		pinctrl-names = "default";
> +		gpios = <&gpio0 30 1>;

GPIO_... ?

thx,

Jason.
