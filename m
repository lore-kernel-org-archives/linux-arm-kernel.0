From: nm@ti.com (Nishanth Menon)
Date: Wed, 25 Nov 2015 15:41:19 -0600
Subject: [PATCH 15/18] ARM: am57xx: sbc-am57x: dts: add GPIO extender
 support
In-Reply-To: <1448433590-1399-16-git-send-email-lifshitz@compulab.co.il>
References: <1448433590-1399-1-git-send-email-lifshitz@compulab.co.il>
 <1448433590-1399-16-git-send-email-lifshitz@compulab.co.il>
Message-ID: <56562AFF.1070802@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/25/2015 12:39 AM, Dmitry Lifshitz wrote:
> Add PCA9555 GPIO extender support (over I2C5 bus).

I think you meant to say "GPIO expander" in commit message and
$subject perhaps?

> 
> Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
> Acked-by: Igor Grinberg <grinberg@compulab.co.il>
> ---
>  arch/arm/boot/dts/am57xx-sbc-am57x.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am57xx-sbc-am57x.dts b/arch/arm/boot/dts/am57xx-sbc-am57x.dts
> index 7b65efb..8b7c0b5 100644
> --- a/arch/arm/boot/dts/am57xx-sbc-am57x.dts
> +++ b/arch/arm/boot/dts/am57xx-sbc-am57x.dts
> @@ -90,4 +90,11 @@
>  		reg = <0x50>;
>  		pagesize = <16>;
>  	};
> +
> +	pca9555: pca9555 at 20 {
> +		compatible = "nxp,pca9555";
> +		reg = <0x20>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +	};
>  };
> 


-- 
Regards,
Nishanth Menon
