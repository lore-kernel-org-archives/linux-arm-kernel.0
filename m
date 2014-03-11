From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 11 Mar 2014 13:28:04 +0100
Subject: [PATCH 3/5] ARM: dts: exynos4x12: Add GPS_ALIVE power domain
In-Reply-To: <1394524494-30641-4-git-send-email-cw00.choi@samsung.com>
References: <1394524494-30641-1-git-send-email-cw00.choi@samsung.com>
 <1394524494-30641-4-git-send-email-cw00.choi@samsung.com>
Message-ID: <531F0154.9040409@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chanwoo,

On 11.03.2014 08:54, Chanwoo Choi wrote:
> This patch add GPS_ALIVE power domain for Exynos4x12 SoC. GPS_ALIVE power domain
> include GPS_BLK for GPS IP. Exynos SoC used generic power-domain driver to
> control power domain. After completed kernel booting, Exynos power-domain driver
> disable un-used power domain to reduce power-consumption/leak.
>
> If GPS_ALIVE power domain isn't registered to Exynos power-domain driver,
> happen power-leakage because GPS_ALIVE_CONFIGURATION is default power on state.
>
> - 0x10023D00 : GPS_ALIVE_CONFIGURATION register address
>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>   arch/arm/boot/dts/exynos4x12.dtsi | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
> index 1ec77f6..066eb35 100644
> --- a/arch/arm/boot/dts/exynos4x12.dtsi
> +++ b/arch/arm/boot/dts/exynos4x12.dtsi
> @@ -41,6 +41,11 @@
>   		compatible = "samsung,exynos4210-pd";
>   		reg = <0x10023CA0 0x20>;
>   	};
> +	
> +	pd_gps_alive: gps-alive-power-domain at 10023D00 {
> +		compatible = "samsung,exynos4210-pd";
> +		reg = <0x10023D00 0x20>;
> +	};
>

Exynos4210 seems to have this power domain as well, so I guess this 
change should be done to exynos4.dtsi instead.

Best regards,
Tomasz
