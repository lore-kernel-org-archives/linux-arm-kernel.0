From: robh@kernel.org (Rob Herring)
Date: Tue, 18 Oct 2016 09:27:43 -0500
Subject: [PATCH 4/9] regulator: lp873x: Add support for populating input
 supply
In-Reply-To: <20161014130033.14172-5-lokeshvutla@ti.com>
References: <20161014130033.14172-1-lokeshvutla@ti.com>
 <20161014130033.14172-5-lokeshvutla@ti.com>
Message-ID: <20161018142743.xfgjuaw4wlssmoxq@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 14, 2016 at 06:30:28PM +0530, Lokesh Vutla wrote:
> In order to have a proper topology of regulators for a platform, each
> registering regulator needs to populate supply_name field for identifying
> its supply's name. Add supply_name field for lp873x regulators.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>  Documentation/devicetree/bindings/mfd/lp873x.txt | 8 ++++++++
>  drivers/regulator/lp873x-regulator.c             | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/lp873x.txt b/Documentation/devicetree/bindings/mfd/lp873x.txt
> index 52766c2..936cba3 100644
> --- a/Documentation/devicetree/bindings/mfd/lp873x.txt
> +++ b/Documentation/devicetree/bindings/mfd/lp873x.txt
> @@ -7,6 +7,9 @@ Required properties:
>    - #gpio-cells:	Should be two.  The first cell is the pin number and
>  			the second cell is used to specify flags.
>  			See ../gpio/gpio.txt for more information.
> +  - xxx-supply:		Phandle to parent supply node of each regulator
> +			populated under regulators node. xxx should match
> +			the supply_name populated in driver.

xxx-in-supply?

>    - regulators:	List of child nodes that specify the regulator
>  			initialization data.
>  Example:
> @@ -17,6 +20,11 @@ pmic: lp8733 at 60 {
>  	gpio-controller;
>  	#gpio-cells = <2>;
>  
> +	buck0-in-supply = <&vsys_3v3>;
> +	buck1-in-supply = <&vsys_3v3>;
> +	ldo0-in-supply = <&vsys_3v3>;
> +	ldo1-in-supply = <&vsys_3v3>;
> +
>  	regulators {
>  		lp8733_buck0: buck0 {
>  			regulator-name = "lp8733-buck0";
