From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 08 Mar 2012 22:26:00 -0700
Subject: [PATCH 2/5 v3] ARM: at91: sam9g20 add i2c DT support
In-Reply-To: <1331196635-27203-2-git-send-email-plagnioj@jcrosoft.com>
References: <1331196635-27203-1-git-send-email-plagnioj@jcrosoft.com>
 <1331196635-27203-2-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <20120309052600.B13BA3E0649@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu,  8 Mar 2012 09:50:32 +0100, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> wrote:
> For now on use i2c-gpio driver on the same pin as the hardware IP.
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: devicetree-discuss at lists.ozlabs.org
> ---
> v3:
> 
> 	update i2c binding (Rob comments)
> 
> Best Regards,
> J.
>  arch/arm/boot/dts/at91sam9g20.dtsi |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
> index 4b0dc99..072b2da 100644
> --- a/arch/arm/boot/dts/at91sam9g20.dtsi
> +++ b/arch/arm/boot/dts/at91sam9g20.dtsi
> @@ -189,4 +189,17 @@
>  			status = "disabled";
>  		};
>  	};
> +
> +	i2c-gpio at 0 {

i2c at 0

> +		compatible = "i2c-gpio";
> +		gpios = <&pioA 23 0 /* sda */
> +			 &pioA 24 0 /* scl */
> +			>;
> +		i2c-gpio,sda-open-drain;
> +		i2c-gpio,scl-open-drain;
> +		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "disabled";
> +	};

gpio-driven i2c busses are inherently board-specific.  Why is this
in the SoC include file?

Otherwise I think this patch series looks okay.

g.

>  };
> -- 
> 1.7.7
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies,Ltd.
