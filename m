From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 06 Aug 2013 09:51:26 +0200
Subject: [PATCH RESEND] ARM: dts: Add USB host node for Exynos4
In-Reply-To: <1375726159-20486-1-git-send-email-tobetter@gmail.com>
References: <1375726159-20486-1-git-send-email-tobetter@gmail.com>
Message-ID: <3592591.kYsJ5mO7Zi@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dongjin,

On Tuesday 06 of August 2013 03:09:19 Dongjin Kim wrote:
> This patch adds EHCI and OHCI host device nodes for Exynos4.
> 
> CC: Jingoo Han <jg1.han@samsung.com>
> Signed-off-by: Dongjin Kim <tobetter@gmail.com>
> ---
>  arch/arm/boot/dts/exynos4.dtsi |   18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos4.dtsi
> b/arch/arm/boot/dts/exynos4.dtsi index 3f94fe8..cbe5219 100644
> --- a/arch/arm/boot/dts/exynos4.dtsi
> +++ b/arch/arm/boot/dts/exynos4.dtsi
> @@ -155,6 +155,24 @@
>  		status = "disabled";
>  	};
> 
> +	ehci at 12580000 {
> +		compatible = "samsung,exynos4210-ehci";
> +		reg = <0x12580000 0x100>;
> +		interrupts = <0 70 0>;
> +		clocks = <&clock 304>;
> +		clock-names = "usbhost";
> +		status = "disabled";
> +	};
> +
> +	ohci at 12590000 {
> +		compatible = "samsung,exynos4210-ohci";
> +		reg = <0x12590000 0x100>;
> +		interrupts = <0 70 0>;
> +		clocks = <&clock 304>;
> +		clock-names = "usbhost";
> +		status = "disabled";
> +	};
> +
>  	mfc: codec at 13400000 {
>  		compatible = "samsung,mfc-v5";
>  		reg = <0x13400000 0x10000>;

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
