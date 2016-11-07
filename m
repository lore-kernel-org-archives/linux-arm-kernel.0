From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 7 Nov 2016 12:07:32 -0300
Subject: [PATCH 4/6] ARM: dts: Add clock provider specific properties to
 max8997 node
In-Reply-To: <1478513376-14307-5-git-send-email-pankaj.dubey@samsung.com>
References: <1478513376-14307-1-git-send-email-pankaj.dubey@samsung.com>
 <1478513376-14307-5-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <ef27992b-87a0-6d18-35cc-83360e6d677a@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Pankaj,

On 11/07/2016 07:09 AM, Pankaj Dubey wrote:
> This patch adds a label and #clock-cells property to device node of
> max8997 PMIC to allow using it as a clock provider.
> 
> CC: Rob Herring <robh+dt@kernel.org>
> CC: devicetree at vger.kernel.org
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4210-origen.dts | 3 ++-
>  arch/arm/boot/dts/exynos4210-trats.dts  | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
> index cb3a255..6c7ef4e 100644
> --- a/arch/arm/boot/dts/exynos4210-origen.dts
> +++ b/arch/arm/boot/dts/exynos4210-origen.dts
> @@ -147,11 +147,12 @@
>  	pinctrl-0 = <&i2c0_bus>;
>  	pinctrl-names = "default";
>  
> -	max8997_pmic at 66 {
> +	max8997: max8997_pmic at 66 {

The ePAPR says that the node name should be "somewhat generic, reflecting
the function of the device and not its precise programming model". So I
think this should be instead:

        max8997: pmic at 66 {

[...]
  
> -	max8997_pmic at 66 {
> +	max8997: max8997_pmic at 66 {

Same here.

The rest looks good to me.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
