From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 2 Jan 2018 15:48:03 +0000
Subject: [PATCH 1/3] dt-bindings: mfd: axp20x: Document backup battery
 charging property
In-Reply-To: <20171230152330.28946-2-contact@paulk.fr>
References: <20171230152330.28946-1-contact@paulk.fr>
 <20171230152330.28946-2-contact@paulk.fr>
Message-ID: <20180102154803.esn3ybxut5iy4bnu@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 30 Dec 2017, Paul Kocialkowski wrote:

> This adds documentation for the "backup" property of the axp20x driver,
> that controls the charging mechanism for the backup battery on axp20x.
> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> 
> diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
> index 9455503b0299..382776b29932 100644
> --- a/Documentation/devicetree/bindings/mfd/axp20x.txt
> +++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
> @@ -58,6 +58,11 @@ Optional properties:
>  	      See Documentation/devicetree/bindings/regulator/regulator.txt
>  	      for more information on standard regulator bindings.
>  
> +- backup: An array of two integers for backup battery charging (axp20x-only),
> +	  describing the charging voltage in mV first and the charging current
> +	  in uA second. Backup battery charging is only enabled when these two
> +	  fields are filled.
> +
>  Optional properties for DCDC regulators:
>  - x-powers,dcdc-workmode: 1 for PWM mode, 0 for AUTO (PWM/PFM) mode
>  			  Default: Current hardware setting
> @@ -256,4 +261,6 @@ axp209: pmic at 34 {
>  			/* unused but preferred to be managed by OS */
>  		};
>  	};
> +
> +	backup = <3000 200>;

It's unlikely that this will become a generic property, so you should
prefix it with your vendor ID.

>  };

-- 
Lee Jones
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
