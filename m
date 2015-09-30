From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 30 Sep 2015 15:21:54 +0200
Subject: [PATCH v2 2/2] regulator: act8865: add DT binding for property
 "active-semi, vsel-high"
In-Reply-To: <1443597950-27849-3-git-send-email-wenyou.yang@atmel.com>
References: <1443597950-27849-1-git-send-email-wenyou.yang@atmel.com>
 <1443597950-27849-3-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20150930132154.GI31199@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 30, 2015 at 03:25:50PM +0800, Wenyou Yang wrote:
> Add a DT property "active-semi,vsel-high" to indicate the VSEL pin
> is high. If this property is missing, then assume the VSEL pin is
> low(0).
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Reviewed-by: Ludovic Desroches <ludovic.desroches@atmel.com>

> ---
> 
> Changes in v2: None
> 
>  .../bindings/regulator/act8865-regulator.txt       |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/act8865-regulator.txt b/Documentation/devicetree/bindings/regulator/act8865-regulator.txt
> index e91485d..6067d98 100644
> --- a/Documentation/devicetree/bindings/regulator/act8865-regulator.txt
> +++ b/Documentation/devicetree/bindings/regulator/act8865-regulator.txt
> @@ -8,6 +8,8 @@ Required properties:
>  Optional properties:
>  - system-power-controller: Telling whether or not this pmic is controlling
>    the system power. See Documentation/devicetree/bindings/power/power-controller.txt .
> +- active-semi,vsel-high: Indicates the VSEL pin is high.
> +  If this property is missing, assume the VSEL pin is low(0).
>  
>  Optional input supply properties:
>  - for act8600:
> @@ -49,6 +51,7 @@ Example:
>  			pmic: act8865 at 5b {
>  				compatible = "active-semi,act8865";
>  				reg = <0x5b>;
> +				active-semi,vsel-high;
>  				status = "disabled";
>  
>  				regulators {
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
