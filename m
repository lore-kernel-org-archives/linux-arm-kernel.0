From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 02 Feb 2015 11:39:07 +0100
Subject: [PATCH 2/2] ARM: dts: Add syscon phandle to the video-phy node for
 Exynos4
In-Reply-To: <1421429438-32090-2-git-send-email-s.nawrocki@samsung.com>
References: <1421429438-32090-1-git-send-email-s.nawrocki@samsung.com>
 <1421429438-32090-2-git-send-email-s.nawrocki@samsung.com>
Message-ID: <54CF53CB.3050100@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On 16/01/15 18:30, Sylwester Nawrocki wrote:
> This is required to fix regression after introducing the PMU device
> nodes required for the PMU driver modified in commit
> 14fc8b93d47323561edf5d482d4a4b3ee1b90286
> ("ARM: EXYNOS: Add platform driver support for Exynos PMU").
> This change is needed to make MIPI DSI displays and MIPI CSI-2
> camera sensors working again on Exynos4 boards.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4.dtsi |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
> index b8168f1..250ee50 100644
> --- a/arch/arm/boot/dts/exynos4.dtsi
> +++ b/arch/arm/boot/dts/exynos4.dtsi
> @@ -76,6 +76,7 @@
>  		compatible = "samsung,s5pv210-mipi-video-phy";
>  		reg = <0x10020710 8>;
>  		#phy-cells = <1>;
> +		syscon = <&pmu_system_controller>;
>  	};
>  
>  	pd_mfc: mfc-power-domain at 10023C40 {

I'd like to remind you about a few pending dts patches I send to you, except
the above one there are:

[PATCH V3 15/15] ARM: dts: Fix I2S1, I2S2 compatible for exynos4 SoCs
[PATCH] ARM: dts: Fix CLK_MOUT_CAMn parent clocks assignment for Trats2
[PATCH] ARM: dts: Fix CLK_UART_ISP_SCLK clock assignment in exynos4x12.dtsi
 
and

[PATCH v2 14/16] ARM: dts: Exynos4 and Odroid X2/U3 sound device nodes update

but this one depends on ASoC patch:
[PATCH V3 11/15] ASoC: samsung: i2s: Add clk provider DT binding documentation

hence it could be probably merged only after 3.20-rc1 release. 

--
Thanks,
Sylwester
