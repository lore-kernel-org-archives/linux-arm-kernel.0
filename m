From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 16 Oct 2015 08:44:52 +0900
Subject: [PATCH v2 2/2] ARM: dts: exynos5250: Add clocks to DISP1 domain
In-Reply-To: <1444905084-22540-3-git-send-email-tomeu.vizoso@collabora.com>
References: <1444905084-22540-1-git-send-email-tomeu.vizoso@collabora.com>
 <1444905084-22540-3-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <56203A74.7040305@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15.10.2015 19:31, Tomeu Vizoso wrote:
> Adds to the node of the DISP1 power domain the two clocks that need to
> be reparented while the domain is powered off:
> CLK_MOUT_ACLK200_DISP1_SUB and CLK_MOUT_ACLK300_DISP1_SUB.
> 
> Otherwise the state is unknown at power up and the mixer's clocks are
> all messed up.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Link: http://lkml.kernel.org/g/561CDC33.7050103 at collabora.com
> ---
> 
> 
>  arch/arm/boot/dts/exynos5250.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index b24610ea8c2a..88b9cf5f226f 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -130,6 +130,10 @@
>  		compatible = "samsung,exynos4210-pd";
>  		reg = <0x100440A0 0x20>;
>  		#power-domain-cells = <0>;
> +		clocks = <&clock CLK_FIN_PLL>,
> +			 <&clock CLK_MOUT_ACLK200_DISP1_SUB>,
> +			 <&clock CLK_MOUT_ACLK300_DISP1_SUB>;
> +		clock-names = "oscclk", "clk0", "clk1";
>  	};
>  
>  	clock: clock-controller at 10010000 {
> 

I reviewed it already. Any changes here since v1?

Best regards,
Krzysztof
