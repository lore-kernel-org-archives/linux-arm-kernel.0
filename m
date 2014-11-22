From: kgene@kernel.org (Kukjin Kim)
Date: Sat, 22 Nov 2014 11:39:03 +0900
Subject: [RESEND PATCH 1/2] ARM: dts: exynos4x12: Device tree node
 definition for TMU on Exynos4x12
In-Reply-To: <1416474343-1283-1-git-send-email-l.majewski@samsung.com>
References: <1416474343-1283-1-git-send-email-l.majewski@samsung.com>
Message-ID: <035001d005fd$7abac670$70305350$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lukasz Majewski wrote:
> 
+ Bart, Tomasz and MLs

Hi Lukasz,

Please post including MLs, even resending.

Will apply for v3.19, and just note that you asked me to apply this for 3.18
in personal talk but I couldn't see any requirements for fixes-3.18. If I'm
missing something, please let me know.

Thanks,
Kukjin

> The TMU device tree node definition for Exynos4x12 family of SoCs.
> 
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Reviewed-by: Tomasz Figa <tomasz.figa@gmail.com>
> ---
>  arch/arm/boot/dts/exynos4x12.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
> index 861bb91..2e9f1f7 100644
> --- a/arch/arm/boot/dts/exynos4x12.dtsi
> +++ b/arch/arm/boot/dts/exynos4x12.dtsi
> @@ -271,4 +271,14 @@
>  		compatible = "samsung,exynos4x12-usb2-phy";
>  		samsung,sysreg-phandle = <&sys_reg>;
>  	};
> +
> +	tmu at 100C0000 {
> +		compatible = "samsung,exynos4412-tmu";
> +		interrupt-parent = <&combiner>;
> +		interrupts = <2 4>;
> +		reg = <0x100C0000 0x100>;
> +		clocks = <&clock 383>;
> +		clock-names = "tmu_apbif";
> +		status = "disabled";
> +	};
>  };
> --
> 2.0.0.rc2
