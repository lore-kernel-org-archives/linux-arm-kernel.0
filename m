From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Mon, 10 Feb 2014 12:54:19 +0000
Subject: [PATCH 1/2] ARM: shmobile: r8a7791: add Ether DT support
In-Reply-To: <201402070112.48304.sergei.shtylyov@cogentembedded.com>
References: <201402070112.48304.sergei.shtylyov@cogentembedded.com>
Message-ID: <52F8CBFB.5060707@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/02/14 22:12, Sergei Shtylyov wrote:
> Define the generic R8A7791 part of the Ether device node.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> ---
>   arch/arm/boot/dts/r8a7791.dtsi |   15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
>
> Index: renesas/arch/arm/boot/dts/r8a7791.dtsi
> ===================================================================
> --- renesas.orig/arch/arm/boot/dts/r8a7791.dtsi
> +++ renesas/arch/arm/boot/dts/r8a7791.dtsi
> @@ -2,7 +2,8 @@
>    * Device Tree Source for the r8a7791 SoC
>    *
>    * Copyright (C) 2013 Renesas Electronics Corporation
> - * Copyright (C) 2013 Renesas Solutions Corp.
> + * Copyright (C) 2013-2014 Renesas Solutions Corp.
> + * Copyright (C) 2014 Cogent Embedded Inc.
>    *
>    * This file is licensed under the terms of the GNU General Public License
>    * version 2.  This program is licensed "as is" without any warranty of any
> @@ -366,6 +367,18 @@
>   		status = "disabled";
>   	};
>
> +	ether: ethernet at ee700000 {
> +		compatible = "renesas,ether-r8a7791";
> +		reg = <0 0xee700000 0 0x400>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 162 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp8_clks R8A7791_CLK_ETHER>;
> +		phy-mode = "rmii";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "disabled";
> +	};

Is the device only capable of doing RMII?


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
