From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 08 Jul 2015 17:25:05 +0900
Subject: [PATCH 3/4] ARM: dts: Include exynos5420-pinctrl after the nodes
 were defined
In-Reply-To: <1436333790-18219-4-git-send-email-javier@osg.samsung.com>
References: <1436333790-18219-1-git-send-email-javier@osg.samsung.com>
 <1436333790-18219-4-git-send-email-javier@osg.samsung.com>
Message-ID: <559CDE61.2040804@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.07.2015 14:36, Javier Martinez Canillas wrote:
> The dtc compiler combines all the defined nodes that have the same path
> so a device node definition can be in one file and later be extended in
> another one.
> 
> That's the case of the Exynos5420 pinctrl device nodes that are defined
> in the exynos5420.dtsi file and extended in exynos5420-pinctrl.dtsi.
> 
> But since the exynos5420.dtsi file includes the exynos5420-pinctrl.dtsi
> before the pinctrl device nodes are actually defined, the definition of
> the pinctrl device nodes happens in exynos5420-pinctrl.dtsi and are
> extended in exynos5420.dtsi.
> 
> That is the opposite of the original intention so even when there is no
> difference in practice, the exynos5420-pinctrl.dtsi include should be
> moved at the end of the exynos5420.dtsi file after the pinctrl device
> nodes have been already defined.
> 
> This will also allow to later change the exynos5420-pinctrl.dtsi file
> to use labels instead of full paths to extend the pinctrl nodes. Since
> keeping the include at the top, would cause a dtc build error due the
> pinctrl labels not being defined yet.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
> 
>  arch/arm/boot/dts/exynos5420.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)


Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
