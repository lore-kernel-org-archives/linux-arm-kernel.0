From: dong.aisheng@linaro.org (Dong Aisheng)
Date: Wed, 20 Feb 2013 17:30:25 +0800
Subject: [PATCH 2/3] ARM: dts: imx: replace magic number with pin function
 name
In-Reply-To: <1361344089-16804-3-git-send-email-shawn.guo@linaro.org>
References: <1361344089-16804-1-git-send-email-shawn.guo@linaro.org>
 <1361344089-16804-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <CAP1dx+xPAUPhRBs9tfPSCqWdQj2HYKEKx5Ac80Nb9EEwkEmjWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 February 2013 15:08, Shawn Guo <shawn.guo@linaro.org> wrote:
> This turns the imx pin function number defined by binding document
> into #define constants in header which can be used in dts and handled
> by pre-processor to improve the readability of device tree sources.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
.........
>                                 usdhc4 {
>                                         pinctrl_usdhc4_1: usdhc4grp-1 {
>                                                 fsl,pins = <
> -                                                       1386 0x17059    /* MX6Q_PAD_SD4_CMD__USDHC4_CMD */
> -                                                       1392 0x10059    /* MX6Q_PAD_SD4_CLK__USDHC4_CLK */
> -                                                       1462 0x17059    /* MX6Q_PAD_SD4_DAT0__USDHC4_DAT0 */
> -                                                       1470 0x17059    /* MX6Q_PAD_SD4_DAT1__USDHC4_DAT1 */
> -                                                       1478 0x17059    /* MX6Q_PAD_SD4_DAT2__USDHC4_DAT2 */
> -                                                       1486 0x17059    /* MX6Q_PAD_SD4_DAT3__USDHC4_DAT3 */
> -                                                       1493 0x17059    /* MX6Q_PAD_SD4_DAT4__USDHC4_DAT4 */
> -                                                       1501 0x17059    /* MX6Q_PAD_SD4_DAT5__USDHC4_DAT5 */
> -                                                       1509 0x17059    /* MX6Q_PAD_SD4_DAT6__USDHC4_DAT6 */
> -                                                       1517 0x17059    /* MX6Q_PAD_SD4_DAT7__USDHC4_DAT7 */
> +                                                       MX6Q_PAD_SD4_CMD__USDHC4_CMD   0x17059
> +                                                       MX6Q_PAD_SD4_CLK__USDHC4_CLK   0x10059
> +                                                       MX6Q_PAD_SD4_DAT0__USDHC4_DAT0 0x17059
> +                                                       MX6Q_PAD_SD4_DAT1__USDHC4_DAT1 0x17059
> +                                                       MX6Q_PAD_SD4_DAT2__USDHC4_DAT2 0x17059
> +                                                       MX6Q_PAD_SD4_DAT3__USDHC4_DAT3 0x17059
> +                                                       MX6Q_PAD_SD4_DAT4__USDHC4_DAT4 0x17059
> +                                                       MX6Q_PAD_SD4_DAT5__USDHC4_DAT5 0x17059
> +                                                       MX6Q_PAD_SD4_DAT6__USDHC4_DAT6 0x17059
> +                                                       MX6Q_PAD_SD4_DAT7__USDHC4_DAT7 0x17059

IMO we could also replace the config value with a macro.
You could either do it in this patch or another separate patch.
So,
Acked-by: Dong Aisheng <dong.aisheng@linaro.org>

Regards
Dong Aisheng
