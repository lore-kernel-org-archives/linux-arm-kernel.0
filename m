From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 04 Feb 2013 14:45:18 -0800
Subject: [PATCH] ARM: dts: Fix MSHC property and add RTC node
In-Reply-To: <1358959242-1667-1-git-send-email-tobetter@gmail.com>
References: <1358959242-1667-1-git-send-email-tobetter@gmail.com>
Message-ID: <11f301ce0329$50329dc0$f097d940$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dongjin Kim wrote:
> 
> This fixes the property of dw-mshc-sdr-timing and dw-mshc-ddr-timing as
> per
> its current binding, it only has two cells.

Yes, it should be fixed.

> And also RTC node is added new.

Above two changes should be separated.

> 
> Signed-off-by: Dongjin Kim <tobetter@gmail.com>
> ---
>  arch/arm/boot/dts/exynos4412-odroidx.dts |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts
> b/arch/arm/boot/dts/exynos4412-odroidx.dts
> index f41a84e..1c1d5ec 100644
> --- a/arch/arm/boot/dts/exynos4412-odroidx.dts
> +++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
> @@ -49,8 +49,8 @@
>  		fifo-depth = <0x80>;
>  		card-detect-delay = <200>;
>  		samsung,dw-mshc-ciu-div = <3>;
> -		samsung,dw-mshc-sdr-timing = <2 3 3>;
> -		samsung,dw-mshc-ddr-timing = <1 2 3>;
> +		samsung,dw-mshc-sdr-timing = <2 3>;
> +		samsung,dw-mshc-ddr-timing = <1 2>;
> 
>  		slot at 0 {
>  			reg = <0>;
> @@ -90,4 +90,8 @@
>  	serial at 13830000 {
>  		status = "okay";
>  	};
> +
> +	rtc at 10070000 {
> +		status = "okay";
> +	};

Please put above node in alphabetical order.

Thanks.

- Kukjin
