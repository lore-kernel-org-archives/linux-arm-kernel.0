From: nm@ti.com (Nishanth Menon)
Date: Tue, 28 Oct 2014 09:02:45 -0500
Subject: [PATCH V4 3/3] rtc: omap: Support regulator supply for RTC
In-Reply-To: <1414490332-14856-4-git-send-email-lokeshvutla@ti.com>
References: <1414490332-14856-1-git-send-email-lokeshvutla@ti.com>
 <1414490332-14856-4-git-send-email-lokeshvutla@ti.com>
Message-ID: <544FA205.3000102@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/28/2014 04:58 AM, Lokesh Vutla wrote:
> Certain SoCs such as DRA7, RTC is an independent voltage domain of it's own
> and on platforms such as DRA7-evm, this may be supplied by individual
> regulator on it's own.
> So make the OMAP RTC driver support a power regulator.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
> - Dropped the Reviewed-by tags as this patch is changed from previous version.
>  Documentation/devicetree/bindings/rtc/rtc-omap.txt |  6 ++++
>  drivers/rtc/rtc-omap.c                             | 41 +++++++++++++++++++++-
>  2 files changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/rtc-omap.txt b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
> index 750efd4..c1d84ac 100644
> --- a/Documentation/devicetree/bindings/rtc/rtc-omap.txt
> +++ b/Documentation/devicetree/bindings/rtc/rtc-omap.txt
> @@ -15,6 +15,9 @@ Required properties:
>  Optional properties:
>  - ti,system-power-controller: whether the rtc is controlling the system power
>    through pmic_power_en
> +- vrtc-supply: phandle to the regulator device tree node.
> +- vrtc-minuV: Minimum required voltage in uV, If default voltage needs to be changed
> +- vrtc-maxuV: Maximum acceptable voltage in uV, If default voltage needs to be changed
>  
>  Example:
>  
> @@ -25,4 +28,7 @@ rtc at 1c23000 {
>  		      19>;
>  	interrupt-parent = <&intc>;
>  	ti,system-power-controller;
> +	vrtc-supply = <&ldo9_reg>;
> +	vrtc-minuV = <1050000>;
> +	vrtc-maxuV = <1050000>;


why would we want to duplicate machine constraints that regulators
already have? if there is a constant voltage needed, then it should be
compatible property as it is not really a configuration option, right?

[...]
-- 
Regards,
Nishanth Menon
