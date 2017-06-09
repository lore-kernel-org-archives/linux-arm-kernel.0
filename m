From: david@lechnology.com (David Lechner)
Date: Fri, 9 Jun 2017 16:17:19 -0500
Subject: [PATCH v2 2/2] ARM: dts: da850-evm: drop VPIF endpoints
In-Reply-To: <20170609172111.23057-3-khilman@baylibre.com>
References: <20170609172111.23057-1-khilman@baylibre.com>
 <20170609172111.23057-3-khilman@baylibre.com>
Message-ID: <b659fcf2-518a-4c1a-4989-d53dfc951ff2@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/09/2017 12:21 PM, Kevin Hilman wrote:
> Drop the unused endpoints.  They should only be used when there is
> an actual remote-endpoint connected.
> 

Would it make sense to implement the status property here instead of 
removing the nodes completely? If other property values are the same for 
all users, then it seems like making all users have to dig up the docs 
and copy/paste is not as nice as just overriding the status property. 
But, if users have to change other values as well, then it makes sense 
to just delete these.


 > -	/* VPIF capture port */
 > -	port at 0 {

-->		status = "disabled";

 > -		vpif_input_ch0: endpoint at 0 {
 > -			reg = <0>;
 > -			bus-width = <8>;
 > -		};
 > -
 > -		vpif_input_ch1: endpoint at 1 {
 > -			reg = <1>;
 > -			bus-width = <8>;
 > -			data-shift = <8>;
 > -		};
 > -	};
 > -
 > -	/* VPIF display port */
 > -	port at 1 {

-->		status = "disabled";

 > -		vpif_output_ch0: endpoint {
 > -			bus-width = <8>;
 > -		};
 > -	};

> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> ---
>   arch/arm/boot/dts/da850-evm.dts | 21 ---------------------
>   1 file changed, 21 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
> index a423e8ebfb37..67e72bc72e80 100644
> --- a/arch/arm/boot/dts/da850-evm.dts
> +++ b/arch/arm/boot/dts/da850-evm.dts
> @@ -301,25 +301,4 @@
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&vpif_capture_pins>, <&vpif_display_pins>;
>   	status = "okay";
> -
> -	/* VPIF capture port */
> -	port at 0 {
> -		vpif_input_ch0: endpoint at 0 {
> -			reg = <0>;
> -			bus-width = <8>;
> -		};
> -
> -		vpif_input_ch1: endpoint at 1 {
> -			reg = <1>;
> -			bus-width = <8>;
> -			data-shift = <8>;
> -		};
> -	};
> -
> -	/* VPIF display port */
> -	port at 1 {
> -		vpif_output_ch0: endpoint {
> -			bus-width = <8>;
> -		};
> -	};
>   };
> 
