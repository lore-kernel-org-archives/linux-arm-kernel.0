From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 18 Sep 2015 16:09:22 +0200
Subject: [PATCH] ARM: at91/dt: ov2640: add hsync/vsync-active property
In-Reply-To: <1442575702-22315-1-git-send-email-josh.wu@atmel.com>
References: <1442575702-22315-1-git-send-email-josh.wu@atmel.com>
Message-ID: <55FC1B12.8000703@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 18/09/2015 13:28, Josh Wu a ?crit :
> On at91sam9x5ek/at91sam9m10g45ek/sama5d3xek boards, we use the parallel
> connection for ov2640. So we must set the hsync/vsync property (1 means
> active high).
> Otherwise, the connection would be seen as BT.656 or BT.1120.
> 
> Signed-off-by: Josh Wu <josh.wu@atmel.com>

Hi Josh,

Does this patch apply because of the new enhancement that you had
proposed in "media: atmel-isi: parse the DT parameters for
vsync/hsync/pixclock polarity" or does it apply even before?
Is it a fix that applies to older kernels?

So, should I wait for the enhancements to enter media git tree or can I
take them anyway?

Bye,

> ---
> 
>  arch/arm/boot/dts/at91sam9m10g45ek.dts | 2 ++
>  arch/arm/boot/dts/at91sam9x5ek.dtsi    | 2 ++
>  arch/arm/boot/dts/sama5d3xmb.dtsi      | 2 ++
>  3 files changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
> index d1ae60a..9d16ef8 100644
> --- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
> +++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
> @@ -198,6 +198,8 @@
>  					isi_0: endpoint {
>  						remote-endpoint = <&ov2640_0>;
>  						bus-width = <8>;
> +						vsync-active = <1>;
> +						hsync-active = <1>;
>  					};
>  				};
>  			};
> diff --git a/arch/arm/boot/dts/at91sam9x5ek.dtsi b/arch/arm/boot/dts/at91sam9x5ek.dtsi
> index d237c46..479f200 100644
> --- a/arch/arm/boot/dts/at91sam9x5ek.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5ek.dtsi
> @@ -66,6 +66,8 @@
>  					isi_0: endpoint at 0 {
>  						remote-endpoint = <&ov2640_0>;
>  						bus-width = <8>;
> +						vsync-active = <1>;
> +						hsync-active = <1>;
>  					};
>  				};
>  			};
> diff --git a/arch/arm/boot/dts/sama5d3xmb.dtsi b/arch/arm/boot/dts/sama5d3xmb.dtsi
> index 83bee7a..8901042 100644
> --- a/arch/arm/boot/dts/sama5d3xmb.dtsi
> +++ b/arch/arm/boot/dts/sama5d3xmb.dtsi
> @@ -87,6 +87,8 @@
>  					isi_0: endpoint {
>  						remote-endpoint = <&ov2640_0>;
>  						bus-width = <8>;
> +						vsync-active = <1>;
> +						hsync-active = <1>;
>  					};
>  				};
>  			};
> 


-- 
Nicolas Ferre
