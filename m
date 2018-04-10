From: liviu.dudau@arm.com (Liviu Dudau)
Date: Tue, 10 Apr 2018 10:24:47 +0100
Subject: [PATCH] arm64: dts: juno: drop unnecessary address-cells and
 size-cells properties
In-Reply-To: <1523286560-30889-1-git-send-email-sudeep.holla@arm.com>
References: <1523270385-30461-1-git-send-email-sudeep.holla@arm.com>
 <1523286560-30889-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <20180410092447.GE10254@e110455-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 09, 2018 at 04:09:20PM +0100, Sudeep Holla wrote:
> /smb at 8000000/motherboard/gpio_keys node doesn't have "ranges" or "reg"
> property in child nodes. So it's unnecessary to have address-cells
> as well as size-cells properties which results in below warning.
> 
> Warning (avoid_unnecessary_addr_size):
> /smb at 8000000/motherboard/gpio_keys:
> 	unnecessary #address-cells/#size-cells without "ranges" or child "reg"
> 	property
> 
> This patch drops the unnecessary address+size-cell properties.
> 
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Looks like the sensible thing to do!

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  arch/arm64/boot/dts/arm/juno-motherboard.dtsi | 2 --
>  1 file changed, 2 deletions(-)
> 
> (Missed cc-ed people earlier)
> 
> diff --git a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
> index 2ac43221ddb6..69804c5f1197 100644
> --- a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
> @@ -56,8 +56,6 @@
> 
>  			gpio_keys {
>  				compatible = "gpio-keys";
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> 
>  				power-button {
>  					debounce_interval = <50>;
> --
> 2.7.4
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
