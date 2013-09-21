From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 21 Sep 2013 17:18:14 +0200
Subject: [PATCH 6/6] ARM: dts: exynos5420: add sclk_pcm_in to audss clock
 controller
In-Reply-To: <1379711637-5226-6-git-send-email-abrestic@chromium.org>
References: <1379711637-5226-1-git-send-email-abrestic@chromium.org>
 <1379711637-5226-6-git-send-email-abrestic@chromium.org>
Message-ID: <9260897.NJpGqJ1JKi@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Friday 20 of September 2013 14:13:57 Andrew Bresticker wrote:
> The parent of sclk_pcm in the AudioSS block is sclk_maupcm0.
> 
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> ---
>  arch/arm/boot/dts/exynos5420.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi
> b/arch/arm/boot/dts/exynos5420.dtsi index d537cd7..339ab93 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -72,8 +72,8 @@
>  		compatible = "samsung,exynos5420-audss-clock";
>  		reg = <0x03810000 0x0C>;
>  		#clock-cells = <1>;
> -		clocks = <&clock 148>;
> -		clock-names = "sclk_audio";
> +		clocks = <&clock 148>, <&clock 149>;
> +		clock-names = "sclk_audio", "sclk_pcm_in";

Same note as for Exynos 5250. I think it would be more reasonable to 
specify all the input clocks here.

Best regards,
Tomasz
