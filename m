From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 21 Sep 2013 17:13:21 +0200
Subject: [PATCH 4/6] ARM: dts: exynos5250: add sclk_pcm_in to audss clock
 controller
In-Reply-To: <1379711637-5226-4-git-send-email-abrestic@chromium.org>
References: <1379711637-5226-1-git-send-email-abrestic@chromium.org>
 <1379711637-5226-4-git-send-email-abrestic@chromium.org>
Message-ID: <1544025.3hYklZrZrS@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Friday 20 of September 2013 14:13:55 Andrew Bresticker wrote:
> The parent of sclk_pcm in the AudioSS block is div_pcm0.
> 
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> ---
>  arch/arm/boot/dts/exynos5250.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi
> b/arch/arm/boot/dts/exynos5250.dtsi index 7d7cc77..bedc7a8 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -88,6 +88,8 @@
>  		compatible = "samsung,exynos5250-audss-clock";
>  		reg = <0x03810000 0x0C>;
>  		#clock-cells = <1>;
> +		clocks = <&clock 160>;
> +		clock-names = "sclk_pcm_in";

IMHO it would be reasonable to explicitly specify all the input clocks 
here.

Best regards,
Tomasz
