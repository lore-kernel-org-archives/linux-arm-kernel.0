From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Wed, 24 Jul 2013 08:11:33 +0200 (CEST)
Subject: [PATCH 01/19] ARM: shmobile: r8a73a4: Add pin control device to
 device tree
In-Reply-To: <803d319cb2fb41e646669061b45701f3ea78e611.1374625203.git.horms+renesas@verge.net.au>
References: <cover.1374625203.git.horms+renesas@verge.net.au>
 <803d319cb2fb41e646669061b45701f3ea78e611.1374625203.git.horms+renesas@verge.net.au>
Message-ID: <Pine.LNX.4.64.1307240811080.30777@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon

On Wed, 24 Jul 2013, Simon Horman wrote:

> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> Add a pfc node to the r8a73a4 device tree.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> [g.liakhovetski+renesas at gmail.com use 2 nodes for address and size]

it's actually "cells," not "nodes."

Thanks
Guennadi

> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm/boot/dts/r8a73a4.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
> index 4ff2019..b886afd 100644
> --- a/arch/arm/boot/dts/r8a73a4.dtsi
> +++ b/arch/arm/boot/dts/r8a73a4.dtsi
> @@ -85,4 +85,11 @@
>  		interrupt-parent = <&gic>;
>  		interrupts = <0 69 4>;
>  	};
> +
> +	pfc: pfc at e6050000 {
> +		compatible = "renesas,pfc-r8a73a4";
> +		reg = <0 0xe6050000 0 0x9000>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +	};
>  };
> -- 
> 1.8.2.1
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
