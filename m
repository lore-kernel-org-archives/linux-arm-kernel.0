From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Wed, 22 Jul 2015 11:11:45 +0200
Subject: [PATCH v2 2/3] ARM: STi: DT: STiH407: Add cpu-release-addr dt
 property.
In-Reply-To: <1433856824-30689-3-git-send-email-peter.griffin@linaro.org>
References: <1433856824-30689-1-git-send-email-peter.griffin@linaro.org>
 <1433856824-30689-3-git-send-email-peter.griffin@linaro.org>
Message-ID: <55AF5E51.8010006@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI Peter,

On 06/09/2015 03:33 PM, Peter Griffin wrote:
> To enable SMP when booting via u-boot we need to specify the
> newly implemented cpu-release-addr DT property.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Acked-by: Maxime Coquelin <maxime.coquelin@st.com>
> ---
>   arch/arm/boot/dts/stih407-family.dtsi | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> index c06a546..3c90227 100644
> --- a/arch/arm/boot/dts/stih407-family.dtsi
> +++ b/arch/arm/boot/dts/stih407-family.dtsi
> @@ -19,11 +19,15 @@
>   			device_type = "cpu";
>   			compatible = "arm,cortex-a9";
>   			reg = <0>;
> +			/* u-boot puts hpen in SBC dmem at 0xa4 offset */
> +			cpu-release-addr = <0x94100A4>;
>   		};
>   		cpu at 1 {
>   			device_type = "cpu";
>   			compatible = "arm,cortex-a9";
>   			reg = <1>;
> +			/* u-boot puts hpen in SBC dmem at 0xa4 offset */
> +			cpu-release-addr = <0x94100A4>;
>   		};
>   	};
>   

Patch applied for v4.3.

Thanks,
Maxime
