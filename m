From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 2 Dec 2013 09:52:53 +0000
Subject: [PATCH 1/1] ARM: dts: Add missing clock names for exynos4412
 dwmmc node
In-Reply-To: <1385892707-25063-1-git-send-email-kasimling@gmail.com>
References: <1385892707-25063-1-git-send-email-kasimling@gmail.com>
Message-ID: <20131202095253.GC12952@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 01, 2013 at 10:11:47AM +0000, Alex Ling wrote:
> This patch adds "biu" and "ciu" clock names for exynos4412 dwmmc
> node. Without this patch, dwmmc host driver will skip enabling the
> two clocks and it will break dwmmc host function on exynos4412.
> Tested on FriendlyARM TINY4412 board.

The patch description is a little off; this patch adds the clocks as
well as the clock-names.

The patch itself looks fine to me.

Mark.

> 
> Signed-off-by: Alex Ling <kasimling@gmail.com>
> ---
>  arch/arm/boot/dts/exynos4412.dtsi |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
> index e743e67..67bef99 100644
> --- a/arch/arm/boot/dts/exynos4412.dtsi
> +++ b/arch/arm/boot/dts/exynos4412.dtsi
> @@ -67,5 +67,7 @@
>  		interrupts = <0 77 0>;
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> +		clocks = <&clock 301>, <&clock 149>;
> +		clock-names = "biu", "ciu";
>  	};
>  };
> -- 
> 1.7.9.5
> 
> 
