From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 26 Nov 2013 03:09:50 +0100
Subject: [PATCH 3/3] ARM: shmobile: marzen: enable HSPI0 in DTS
In-Reply-To: <1385341216-27101-4-git-send-email-horms+renesas@verge.net.au>
References: <1385341216-27101-1-git-send-email-horms+renesas@verge.net.au>
 <1385341216-27101-4-git-send-email-horms+renesas@verge.net.au>
Message-ID: <7829758.zdhJHbHjWn@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

Thank you for the patch.

On Monday 25 November 2013 10:00:16 Simon Horman wrote:
> Based on work for the bockw board by Kuninori Morimoto.
> 
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm/boot/dts/r8a7779-marzen-reference.dts | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7779-marzen-reference.dts
> b/arch/arm/boot/dts/r8a7779-marzen-reference.dts index 918085c..76f5eef
> 100644
> --- a/arch/arm/boot/dts/r8a7779-marzen-reference.dts
> +++ b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
> @@ -97,6 +97,11 @@
>  		renesas,groups = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_cd";
>  		renesas,function = "sdhi0";
>  	};
> +
> +	hspi0_pins: hspi0 {
> +		renesas,groups = "hspi0";
> +		renesas,function = "hspi0";
> +	};

What about keeping the nodes in alphabetical order ?

>  };
> 
>  &sdhi0 {
> @@ -107,3 +112,9 @@
>  	bus-width = <4>;
>  	status = "okay";
>  };
> +
> +&hspi0 {
> +	pinctrl-0 = <&hspi0_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};

And here too ?

-- 
Regards,

Laurent Pinchart
