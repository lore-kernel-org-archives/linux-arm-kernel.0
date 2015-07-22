From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Wed, 22 Jul 2015 11:12:00 +0200
Subject: [PATCH v2 3/3] ARM: STi: DT: STiH418: Add cpu-release-addr dt
 property.
In-Reply-To: <1433856824-30689-4-git-send-email-peter.griffin@linaro.org>
References: <1433856824-30689-1-git-send-email-peter.griffin@linaro.org>
 <1433856824-30689-4-git-send-email-peter.griffin@linaro.org>
Message-ID: <55AF5E60.2040105@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI Peter,

On 06/09/2015 03:33 PM, Peter Griffin wrote:
> To enable SMP when booting via u-boot we need to specify the
> newly implemented cpu-release-addr DT property for cores 2 & 3.
> Cores 0 & 1 are inherited from stih407-family.dtsi.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>   arch/arm/boot/dts/stih418.dtsi | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/stih418.dtsi b/arch/arm/boot/dts/stih418.dtsi
> index 354d90f..8160a75 100644
> --- a/arch/arm/boot/dts/stih418.dtsi
> +++ b/arch/arm/boot/dts/stih418.dtsi
> @@ -17,11 +17,15 @@
>   			device_type = "cpu";
>   			compatible = "arm,cortex-a9";
>   			reg = <2>;
> +			/* u-boot puts hpen in SBC dmem at 0xa4 offset */
> +			cpu-release-addr = <0x94100A4>;
>   		};
>   		cpu at 3 {
>   			device_type = "cpu";
>   			compatible = "arm,cortex-a9";
>   			reg = <3>;
> +			/* u-boot puts hpen in SBC dmem at 0xa4 offset */
> +			cpu-release-addr = <0x94100A4>;
>   		};
>   	};
>   

Patch applied for v4.3.

Thanks,
Maxime
