From: scottwood@freescale.com (Scott Wood)
Date: Tue, 30 Jul 2013 17:40:11 -0500
Subject: [4/4] Added device tree entries for Legerity SLIC node on
 various Freescale Platforms
In-Reply-To: <1362655668-26721-4-git-send-email-Sandeep@freescale.com>
References: <1362655668-26721-4-git-send-email-Sandeep@freescale.com>
Message-ID: <20130730224011.GA15915@home.buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 07, 2013 at 04:57:48PM +0530, Sandeep Singh wrote:
> diff --git a/arch/powerpc/boot/dts/p1024rdb.dtsi b/arch/powerpc/boot/dts/p1024rdb.dtsi
> index b05dcb4..cec36a3 100644
> --- a/arch/powerpc/boot/dts/p1024rdb.dtsi
> +++ b/arch/powerpc/boot/dts/p1024rdb.dtsi
> @@ -164,6 +164,19 @@
>  				label = "SPI JFFS2 RFS";
>  			};
>  		};
> +
> +                tdm_phy_0: slic at 0 {
> +                        compatible = "zarlink,le88266", "tdm-phy-slic";
> +			reg = <1>;
> +			spi-max-frequency = <8000000>;
> +		};
> +
> +                tdm_phy_1: slic at 1 {
> +                        compatible = "zarlink,le88266", "tdm-phy-slic";
> +			reg = <2>;
> +			spi-max-frequency = <8000000>;
> +		};
> +
>  	};
>  
>  	i2c at 3000 {
> @@ -173,6 +186,11 @@
>  		};
>  	};
>  
> +        tdm at 16000 {
> +                num-phy = <2>;
> +                phy-handle = <&tdm_phy_0>, <&tdm_phy_1>;
> +        };
> +
>  	usb at 22000 {
>  		phy_type = "ulpi";
>  	};

Whitespace

What is "tdm-phy-slic"?  "num-phy"?  Document these in the binding and
use proper vendor prefixes.

Why "<&tdm_phy_0>, <&tdm_phy_1>" rather than "<&tdm_phy_0 &tdm_phy_1>"? 
And can you just use the length of phy-handle rather than having a
separate num-phy property?

-Scott
 
