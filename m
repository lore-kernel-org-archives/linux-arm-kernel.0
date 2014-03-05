From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 5 Mar 2014 09:23:22 +0800
Subject: [PATCHv9][ 2/2] ARM: dts: mbimxsd35: Add sound support.
In-Reply-To: <1389806606-21521-2-git-send-email-denis@eukrea.com>
References: <1389806606-21521-1-git-send-email-denis@eukrea.com>
 <1389806606-21521-2-git-send-email-denis@eukrea.com>
Message-ID: <20140305012319.GA8784@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 15, 2014 at 06:23:26PM +0100, Denis Carikli wrote:
> Cc: Eric B?nard <eric@eukrea.com>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: devicetree at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Denis Carikli <denis@eukrea.com>

Applied, thanks.

Shawn

> ---
> ChangeLog v8->v9:
> - Better Cc list.
> 
> ChangeLog v7->v8:
> - Ajusted to match the driver changes.
> ---
>  .../boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts  |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts b/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts
> index 23f6fe1..3e207df 100644
> --- a/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts
> +++ b/arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts
> @@ -46,6 +46,14 @@
>  			linux,default-trigger = "heartbeat";
>  		};
>  	};
> +
> +	sound {
> +		compatible = "eukrea,asoc-tlv320";
> +		eukrea,model = "imx35-eukrea-tlv320aic23";
> +		ssi-controller = <&ssi1>;
> +		fsl,mux-int-port = <1>;
> +		fsl,mux-ext-port = <4>;
> +	};
>  };
>  
>  &audmux {
> @@ -118,6 +126,7 @@
>  };
>  
>  &ssi1 {
> +	codec-handle = <&tlv320aic23>;
>  	fsl,mode = "i2s-slave";
>  	status = "okay";
>  };
> -- 
> 1.7.9.5
> 
