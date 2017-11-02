From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 02 Nov 2017 19:39:18 +0200
Subject: [PATCH] ARM: dts: koelsch: Move cec_clock to root node
In-Reply-To: <20171102091805.24967-1-horms+renesas@verge.net.au>
References: <20171102091805.24967-1-horms+renesas@verge.net.au>
Message-ID: <14112514.nMv28tbzn2@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

Thank you for the patch.

On Thursday, 2 November 2017 11:18:05 EET Simon Horman wrote:
> cec-clock is a fixed clock generator that is not controlled by i2c5 and
> thus should not be a child of the i2c5 bus node. Rather, it should be
> a child of the root node of the DT.
> 
> Fixes: 02a5ab18d366 ("ARM: dts: koelsch: Add CEC clock for HDMI
> transmitter") Reported-by: Laurent Pinchart
> <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  arch/arm/boot/dts/r8a7791-koelsch.dts | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts
> b/arch/arm/boot/dts/r8a7791-koelsch.dts index e164eda69baf..4126de417922
> 100644
> --- a/arch/arm/boot/dts/r8a7791-koelsch.dts
> +++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
> @@ -278,6 +278,12 @@
>  		};
>  	};
> 
> +	cec_clock: cec-clock {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <12000000>;
> +	};
> +
>  	hdmi-out {
>  		compatible = "hdmi-connector";
>  		type = "a";
> @@ -640,12 +646,6 @@
>  		};
>  	};
> 
> -	cec_clock: cec-clock {
> -		compatible = "fixed-clock";
> -		#clock-cells = <0>;
> -		clock-frequency = <12000000>;
> -	};
> -
>  	hdmi at 39 {
>  		compatible = "adi,adv7511w";
>  		reg = <0x39>;


-- 
Regards,

Laurent Pinchart
