From: anilkumar@ti.com (AnilKumar, Chimata)
Date: Sat, 1 Sep 2012 07:05:58 +0000
Subject: [PATCH 5/5] of: Modify c_can binding documentation
In-Reply-To: <1346405361-29711-6-git-send-email-anilkumar@ti.com>
References: <1346405361-29711-1-git-send-email-anilkumar@ti.com>
 <1346405361-29711-6-git-send-email-anilkumar@ti.com>
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA234C7@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Fri, Aug 31, 2012 at 14:59:21, AnilKumar, Chimata wrote:
> Modify c_can binding documentation according to recent review comments
> on device tree data addition patches.
> 
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
>  .../devicetree/bindings/net/can/c_can.txt          |   25 ++++++++++++++++----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/c_can.txt b/Documentation/devicetree/bindings/net/can/c_can.txt
> index a43f083..90a70be 100644
> --- a/Documentation/devicetree/bindings/net/can/c_can.txt
> +++ b/Documentation/devicetree/bindings/net/can/c_can.txt
> @@ -8,6 +8,8 @@ Required properties:
>  			  registers map
>  - interrupts		: property with a value describing the interrupt
>  			  number
> +- status		: describes the node status either "disabled" or
> +			  "okay"
>  
>  Optional properties:
>  - interrupt-parent	: The parent interrupt controller
> @@ -20,18 +22,31 @@ Future plan is to migrate hwmod data base contents into device tree
>  blob so that, all the required data will be used from device tree dts
>  file.
>  
> -Examples:
> +Example:
>  
> -	d_can at 481D0000 {
> +Step1: SoC common .dtsi file
> +
> +	d_can1: d_can at 481d0000 {
>  		compatible = "bosch,d_can";
> -		reg = <0x481D0000 0x1000>;
> -		interrupts = <55 0x4>;
> +		reg = <0x481d0000 0x2000>;
> +		interrupts = <55>;
>  		interrupt-parent = <&intc>;
> +		status = "disabled";
>  	};
>  
>  (or)
>  
> -	d_can at 481D0000 {
> +	d_can1: d_can at 481d0000 {
>  		compatible = "bosch,d_can";
>  		ti,hwmods = "d_can1";
> +		reg = <0x481d0000 0x2000>;
> +		interrupts = <55>;
> +		interrupt-parent = <&intc>;
> +		status = "disabled";
> +	};
> +
> +Step 2: board specific .dts file
> +
> +	&dcan1 {
> +		status = "okay";
>  	};
> -- 
> 1.7.9.5
> 
> 

Can you review this patch and push it to linux-can tree?
Because initial version of this file c_can.txt is in
linux-can tree.

Thanks
AnilKumar
