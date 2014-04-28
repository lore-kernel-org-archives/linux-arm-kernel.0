From: tushar.behera@linaro.org (Tushar Behera)
Date: Mon, 28 Apr 2014 12:00:19 +0530
Subject: [PATCH 5/7] ARM: dts: enable hdmi for exynos5250 based snow board
In-Reply-To: <1397993044-14564-6-git-send-email-rahul.sharma@samsung.com>
References: <1397993044-14564-1-git-send-email-rahul.sharma@samsung.com>
 <1397993044-14564-6-git-send-email-rahul.sharma@samsung.com>
Message-ID: <535DF57B.5030301@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/20/2014 04:54 PM, Rahul Sharma wrote:
> From: Rahul Sharma <Rahul.Sharma@samsung.com>
> 
> Enable support for HDMI for exynos5250 based Snow board.
> 
> Signed-off-by: Rahul Sharma <Rahul.Sharma@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5250-cros-common.dtsi |   13 ++++++++++++-
>  arch/arm/boot/dts/exynos5250-snow.dts         |    7 +++++++
>  2 files changed, 19 insertions(+), 1 deletion(-)

[ ... ]

> diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
> index 52ae335..586cd38 100644
> --- a/arch/arm/boot/dts/exynos5250-snow.dts
> +++ b/arch/arm/boot/dts/exynos5250-snow.dts
> @@ -343,4 +343,11 @@
>  			pinctrl-0 = <&ptn3460_gpios>;
>  		};
>  	};
> +
> +	hdmi {
> +		hdmi-en-supply = <&tps65090_fet7>;

Looks like tps65090_fet7 is not defined yet or might be not mentioned as
dependency.

> +		vdd-supply = <&ldo8_reg>;
> +		vdd_osc-supply = <&ldo10_reg>;
> +		vdd_pll-supply = <&ldo8_reg>;
> +	};
>  };
> 

-- 
Tushar Behera
