From: robh@kernel.org (Rob Herring)
Date: Fri, 9 Jun 2017 08:32:05 -0500
Subject: [PATCH v3 4/6] regulator: pfuze100: add fsl,pmic-stby-poweroff
 property
In-Reply-To: <20170606073146.26882-5-o.rempel@pengutronix.de>
References: <20170606073146.26882-1-o.rempel@pengutronix.de>
 <20170606073146.26882-5-o.rempel@pengutronix.de>
Message-ID: <20170609133205.v5tw2vn6ai74bjvr@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 06, 2017 at 09:31:44AM +0200, Oleksij Rempel wrote:
> Document the new optional "fsl,pmic_stby_poweroff" property.

Needs updating...

> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/regulator/pfuze100.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/pfuze100.txt b/Documentation/devicetree/bindings/regulator/pfuze100.txt
> index 444c47831a40..197f1a52e960 100644
> --- a/Documentation/devicetree/bindings/regulator/pfuze100.txt
> +++ b/Documentation/devicetree/bindings/regulator/pfuze100.txt
> @@ -4,6 +4,13 @@ Required properties:
>  - compatible: "fsl,pfuze100", "fsl,pfuze200", "fsl,pfuze3000"
>  - reg: I2C slave address
>  
> +Optional properties:
> +- fsl,pmic-stby-poweroff: if present, configure the PMIC to shutdown all
> +  power rails when PMIC_STBY_REQ line is asserted during the power off sequence.
> +  Use this option if the SoC should be powered off by external power
> +  management IC (PMIC) on PMIC_STBY_REQ signal.
> +  As opposite to PMIC_STBY_REQ boards can implement PMIC_ON_REQ signal.
> +
>  Required child node:
>  - regulators: This is the list of child nodes that specify the regulator
>    initialization data for defined regulators. Please refer to below doc
> -- 
> 2.11.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
