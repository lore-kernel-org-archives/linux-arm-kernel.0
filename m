From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 14 May 2014 21:44:55 +0200
Subject: [PATCH v4 2/5] ARM: dts: change to correct compatible string
 for exynos5420 hdmi
In-Reply-To: <1400035562-16832-3-git-send-email-rahul.sharma@samsung.com>
References: <1400035562-16832-1-git-send-email-rahul.sharma@samsung.com>
 <1400035562-16832-3-git-send-email-rahul.sharma@samsung.com>
Message-ID: <5373C7B7.5000300@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rahul,

On 14.05.2014 04:45, Rahul Sharma wrote:
> From: Rahul Sharma <Rahul.Sharma@samsung.com>
> 
> Replace compatible string for HDMI node in Exynos5420. Since
> latest restructring in Drm hdmi driver, it is agreed to use
> a seperate compatible string for Exynos5420 HDMI IP siince it
> uses APB mapped Phy.
> 
> Signed-off-by: Rahul Sharma <Rahul.Sharma@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420.dtsi |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index a802f74..016992c 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -640,7 +640,7 @@
>  	};
>  
>  	hdmi: hdmi at 14530000 {
> -		compatible = "samsung,exynos4212-hdmi";
> +		compatible = "samsung,exynos5420-hdmi";
>  		reg = <0x14530000 0x70000>;
>  		interrupts = <0 95 0>;
>  		clocks = <&clock CLK_HDMI>, <&clock CLK_SCLK_HDMI>,
> 

Acked-by: Tomasz Figa <t.figa@samsung.com>

The compatible string doesn't seem to be documented in linux-next,
though. Are the necessary patches adding it already merged?

Best regards,
Tomasz
