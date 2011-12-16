From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Fri, 16 Dec 2011 06:54:08 +0000
Subject: [PATCH] arm/dts: Add support for OMAP3 Mistral EVM board
In-Reply-To: <1324015560-26735-1-git-send-email-hvaibhav@ti.com>
References: <1324015560-26735-1-git-send-email-hvaibhav@ti.com>
Message-ID: <79CD15C6BA57404B839C016229A409A805E4F0@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Hiremath, Vaibhav
> Sent: Friday, December 16, 2011 11:36 AM
> To: linux-omap at vger.kernel.org
> Cc: tony at atomide.com; linux-arm-kernel at lists.infradead.org; devicetree-
> discuss at lists.ozlabs.org; grant.likely at secretlab.ca; Cousson, Benoit;
> Hiremath, Vaibhav
> Subject: [PATCH] arm/dts: Add support for OMAP3 Mistral EVM board
> 
> Add OMAP3 Mistral EVM DTS file to use the omap3.dtsi SoC file,
> along with memory node information.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> ---
> Boot tested it on DM37x Mistral EVM, kernel parses the info correctly.
> 
>  arch/arm/boot/dts/omap3-evm.dts |   20 ++++++++++++++++++++
>  1 files changed, 20 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/boot/dts/omap3-evm.dts
> 
> diff --git a/arch/arm/boot/dts/omap3-evm.dts b/arch/arm/boot/dts/omap3-
> evm.dts
> new file mode 100644
> index 0000000..59b2de0
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap3-evm.dts
> @@ -0,0 +1,20 @@
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
> +	model = "TI OMAP3 Mistral EVM";
Just realized that, this is not in sync with current code. We always referred this EVM as "AM37x TI EVM".

Reposting it again... (with correction).

Thanks,
Vaibhav


> +	compatible = "ti,omap3-evm", "ti,omap3";
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x80000000 0x10000000>; /* 256 MB */
> +	};
> +};
> --
> 1.7.0.4
