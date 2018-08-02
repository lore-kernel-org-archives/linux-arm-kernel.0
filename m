From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 02 Aug 2018 13:16:18 +0200
Subject: [PATCH v2 3/5] dt-bindings: mfd: rk808: Add binding informations
 for RK809 and RK817.
In-Reply-To: <1533023850-29004-4-git-send-email-tony.xie@rock-chips.com>
References: <1533023850-29004-1-git-send-email-tony.xie@rock-chips.com>
 <1533023850-29004-4-git-send-email-tony.xie@rock-chips.com>
Message-ID: <2820701.ErqR8ge6r7@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

Am Dienstag, 31. Juli 2018, 09:57:28 CEST schrieb Tony Xie:
> Add device tree bindings documentation for Rockchip's RK809 & RK817 PMIC.
> 
> Signed-off-by: Tony Xie <tony.xie@rock-chips.com>

I don't see the devicetree binding maintainers listed in the recipient
list, so adding them in the next iteration might increase your chances
to get an Ack on the binding.

scripts/get_maintainer.pl -f Documentation/devicetree/bindings lists

Rob Herring <robh+dt@kernel.org>
Mark Rutland <mark.rutland@arm.com>

as the main dt maintainers.

[...]

> @@ -99,6 +147,13 @@ number as described in RK818 datasheet.
>  	- HDMI_SWITCH
>  	- OTG_SWITCH
>  
> +There are three pins needed to config, named "gpio_ts" "gpio_gt" "gpio_slp".
> +	The gpio_gt and gpio_ts pins support the gpio function.
> +	The gpio_slp pin is for controlling the pmic states, as below:
> +		- reset
> +		- power down
> +		- sleep
> +

Is this common for all rk8xx pmics or just the two new ones?
As the paragraph above makes it sound like these are present on all
and I didn't find mention of them in the datasheets for previous pmics
I have.

Also to me it is not clear in what way these should be used and I didn't
find any mention of them at all in the rest of your series.


Heiko
