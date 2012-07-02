From: tony@atomide.com (Tony Lindgren)
Date: Mon, 2 Jul 2012 01:10:19 -0700
Subject: [RESEND PATCH V3 1/2] arm/dts: OMAP2: Add support for
 OMAP2420H4 Board
In-Reply-To: <1339548046-27988-2-git-send-email-jon-hunter@ti.com>
References: <1339548046-27988-1-git-send-email-jon-hunter@ti.com>
 <1339548046-27988-2-git-send-email-jon-hunter@ti.com>
Message-ID: <20120702081018.GD1122@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jon Hunter <jon-hunter@ti.com> [120612 17:45]:
> Simple DTS file for OMAP2420H4 board adding memory information to allow
> device-tree testing on an OMAP2420. OMAP2420H4 board has 64MB of RAM.
> 
> Verified that kernel boots with DT using a simple RAMDISK file-system on
> OMAP2420H4.

Thanks, applying into dt branch.

Tony

 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
>  arch/arm/boot/dts/omap2420-h4.dts |   20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 arch/arm/boot/dts/omap2420-h4.dts
> 
> diff --git a/arch/arm/boot/dts/omap2420-h4.dts b/arch/arm/boot/dts/omap2420-h4.dts
> new file mode 100644
> index 0000000..25b50b7
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap2420-h4.dts
> @@ -0,0 +1,20 @@
> +/*
> + * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +/dts-v1/;
> +
> +/include/ "omap2.dtsi"
> +
> +/ {
> +	model = "TI OMAP2420 H4 board";
> +	compatible = "ti,omap2420-h4", "ti,omap2420", "ti,omap2";
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x80000000 0x84000000>; /* 64 MB */
> +	};
> +};
> -- 
> 1.7.9.5
> 
