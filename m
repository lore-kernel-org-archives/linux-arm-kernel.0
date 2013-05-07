From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 07 May 2013 11:54:20 +0200
Subject: [PATCH V2 2/3] ARM: dts: add Exynos audio subsystem clock
 controller node
In-Reply-To: <1367909016-19657-3-git-send-email-padma.v@samsung.com>
References: <1367909016-19657-1-git-send-email-padma.v@samsung.com>
 <1367909016-19657-3-git-send-email-padma.v@samsung.com>
Message-ID: <2829319.bZPJnVErnQ@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Padmavathi,

On Tuesday 07 of May 2013 12:13:35 Padmavathi Venna wrote:
> Audio subsystem introduced in s5pv210 and exynos platforms
> which has a internal clock controller. This patch adds a node
> for the same on exynos5250.
> 
> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5250.dtsi |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi
> b/arch/arm/boot/dts/exynos5250.dtsi index 36c9d8d..7026de0 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -72,6 +72,12 @@
>  		#clock-cells = <1>;
>  	};
> 
> +	clock_audss: audss-clock-controller at 0x03810000 {

Just a nitpick: this should be @3810000, without the 0x and leading zeroes.

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
SW Solution Development, Kernel and System Framework

> +		compatible = "samsung,exynos5250-audss-clock";
> +		reg = <0x03810000 0x0C>;
> +		#clock-cells = <1>;
> +	};
> +
>  	gic:interrupt-controller at 10481000 {
>  		compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
>  		#interrupt-cells = <3>;
