From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Fri, 3 Feb 2012 06:42:15 +0000
Subject: [PATCH 2/2] arm/dts: Add support for TI AM335x EVM board
In-Reply-To: <1326870839-19951-2-git-send-email-hvaibhav@ti.com>
References: <1326870839-19951-1-git-send-email-hvaibhav@ti.com>
 <1326870839-19951-2-git-send-email-hvaibhav@ti.com>
Message-ID: <79CD15C6BA57404B839C016229A409A8317BE7E1@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2012 at 12:43:59, Hiremath, Vaibhav wrote:
> Add AM335x EVM DTS file to use the omap3.dtsi SoC file,
> along with memory node and i2c information.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/boot/dts/am335x-evm.dts |   39 ++++++++++++++++++++++++++++++++++++++
>  1 files changed, 39 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/boot/dts/am335x-evm.dts
> 
> diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
> new file mode 100644
> index 0000000..8cc877f
> --- /dev/null
> +++ b/arch/arm/boot/dts/am335x-evm.dts
> @@ -0,0 +1,39 @@
> +/*
> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +/dts-v1/;
> +
> +/include/ "omap3.dtsi"
> +
> +/ {
> +	model = "TI AM335x EVM";
> +	compatible = "ti,am335x-evm", "ti,am33xx", "ti,omap3";
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x80000000 0x10000000>; /* 256 MB */
> +	};
> +};
> +
> +&intc {
> +	/*
> +	 * AM33XX family of devices have 128 interrupts
> +	 */
> +	ti,intc-size = <128>;
> +};
> +
> +&i2c1 {
> +	clock-frequency = <400000>;
> +};
> +
> +&i2c2 {
> +	clock-frequency = <400000>;
> +};
> +
> +&i2c3 {
> +	clock-frequency = <400000>;
> +};

Grant,

If there are not review comments, can you also ack this patch as well?

Thanks,
Vaibhav

> --
> 1.7.0.4
> 
> 
