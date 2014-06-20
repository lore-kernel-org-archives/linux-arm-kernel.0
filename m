From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 20 Jun 2014 10:11:37 +0100
Subject: [PATCH] ARM: multi_v7_defconfig: Add QCOM GSBI driver
In-Reply-To: <1403081542-28291-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1403081542-28291-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <53A3FAC9.3040709@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd/Olof,

Can you take this fix for next RC, without this patch we can not see 
serial working on IFC6410 board.

thanks
srini

On 18/06/14 09:52, Srinivas Kandagatla wrote:
> This patch adds QCOM GSBI config option to multi_v7_defconfig. Serial
> driver on QCOM APQ8064 depends on GSBI driver, so without this patch
> there is no serial console on IF6410 board using multi_v7_defconfig.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   arch/arm/configs/multi_v7_defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index e2d6204..f71731f 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -352,6 +352,7 @@ CONFIG_MFD_NVEC=y
>   CONFIG_KEYBOARD_NVEC=y
>   CONFIG_SERIO_NVEC_PS2=y
>   CONFIG_NVEC_POWER=y
> +CONFIG_QCOM_GSBI=y
>   CONFIG_COMMON_CLK_QCOM=y
>   CONFIG_MSM_GCC_8660=y
>   CONFIG_MSM_MMCC_8960=y
>
