From: ray.jui@broadcom.com (Ray Jui)
Date: Tue, 21 Mar 2017 23:07:34 -0700
Subject: [PATCH 10/15] ARM: dts: bcm: fix msi-controller name and unit
 address
In-Reply-To: <20170322020313.24338-10-robh@kernel.org>
References: <20170322020313.24338-1-robh@kernel.org>
 <20170322020313.24338-10-robh@kernel.org>
Message-ID: <85acf150-aaa4-efee-c477-6d8e5ccfdf1d@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,


On 3/21/2017 7:03 PM, Rob Herring wrote:
> The unit address for the msi controller is not valid as there is no reg
> property, so remove it. Also, msi-controller is the preferred node name.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: Jon Mason <jonmason@broadcom.com>
> Cc: bcm-kernel-feedback-list at broadcom.com
> ---
> Sub-arch maintainers, please apply to your trees unless arm-soc wants
> to take the whole lot.
>
>   arch/arm/boot/dts/bcm-cygnus.dtsi | 4 ++--
>   arch/arm/boot/dts/bcm-nsp.dtsi    | 6 +++---
>   2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
> index 8833a4c3cd96..9644fddb5e3c 100644
> --- a/arch/arm/boot/dts/bcm-cygnus.dtsi
> +++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
> @@ -205,7 +205,7 @@
>   			status = "disabled";
>   
>   			msi-parent = <&msi0>;
> -			msi0: msi at 18012000 {
> +			msi0: msi-controller {
>   				compatible = "brcm,iproc-msi";
>   				msi-controller;
>   				interrupt-parent = <&gic>;
> @@ -240,7 +240,7 @@
>   			status = "disabled";
>   
>   			msi-parent = <&msi1>;
> -			msi1: msi at 18013000 {
> +			msi1: msi-controller {
>   				compatible = "brcm,iproc-msi";
>   				msi-controller;
>   				interrupt-parent = <&gic>;
> diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
> index 832795b0fd0f..42c017df490f 100644
> --- a/arch/arm/boot/dts/bcm-nsp.dtsi
> +++ b/arch/arm/boot/dts/bcm-nsp.dtsi
> @@ -450,7 +450,7 @@
>   		status = "disabled";
>   
>   		msi-parent = <&msi0>;
> -		msi0: msi at 18012000 {
> +		msi0: msi-controller {
>   			compatible = "brcm,iproc-msi";
>   			msi-controller;
>   			interrupt-parent = <&gic>;
> @@ -486,7 +486,7 @@
>   		status = "disabled";
>   
>   		msi-parent = <&msi1>;
> -		msi1: msi at 18013000 {
> +		msi1: msi-controller {
>   			compatible = "brcm,iproc-msi";
>   			msi-controller;
>   			interrupt-parent = <&gic>;
> @@ -522,7 +522,7 @@
>   		status = "disabled";
>   
>   		msi-parent = <&msi2>;
> -		msi2: msi at 18014000 {
> +		msi2: msi-controller {
>   			compatible = "brcm,iproc-msi";
>   			msi-controller;
>   			interrupt-parent = <&gic>;
Looks good and thanks!

Acked-by: Ray Jui <ray.jui@broadcom.com>
