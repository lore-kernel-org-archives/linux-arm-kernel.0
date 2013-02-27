From: dong.aisheng@linaro.org (Dong Aisheng)
Date: Wed, 27 Feb 2013 10:50:32 +0800
Subject: [PATCH 1/2] pinctrl: imx6q: add DTE pinctrl items for mx6q uart
In-Reply-To: <1361932553-8218-1-git-send-email-b32955@freescale.com>
References: <1361932553-8218-1-git-send-email-b32955@freescale.com>
Message-ID: <CAP1dx+xbKCVt11XvNqwR2O0KKf6pydeWb-KaHknbKxNdz4SKxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shijie,

On 27 February 2013 10:35, Huang Shijie <b32955@freescale.com> wrote:
> This patch adds two DTE pinctrl items for UART in mx6q.
>   MX6Q_PAD_EIM_D27__UART2_RXD_DTE: set the RX/TX into DTE mode.
>   MX6Q_PAD_EIM_D29__UART2_RTS_DTE: set the RTS/CTS into DTE mode.
>
> If the uart want to work in DTE mode and enable the hardware flow control,
> it must selects these two pinctrl items.
>
> Signed-off-by: Huang Shijie <b32955@freescale.com>

Thanks for the patch.
We're switching to use pre-proccessor feature provided by dtc and
changing the binding a bit.
So this patch may not be needed anymore.

Regards
Dong Aisheng

>  .../bindings/pinctrl/fsl,imx6q-pinctrl.txt         |    2 ++
>  drivers/pinctrl/pinctrl-imx6q.c                    |    2 ++
>  2 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx6q-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,imx6q-pinctrl.txt
> index a4119f6..91b8fa5 100644
> --- a/Documentation/devicetree/bindings/pinctrl/fsl,imx6q-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx6q-pinctrl.txt
> @@ -1628,3 +1628,5 @@ MX6Q_PAD_SD2_DAT3__SJC_DONE                       1589
>  MX6Q_PAD_SD2_DAT3__ANATOP_TESTO_3              1590
>  MX6Q_PAD_ENET_RX_ER__ANATOP_USBOTG_ID          1591
>  MX6Q_PAD_GPIO_1__ANATOP_USBOTG_ID              1592
> +MX6Q_PAD_EIM_D27__UART2_RXD_DTE                        1593
> +MX6Q_PAD_EIM_D29__UART2_RTS_DTE                        1594
> diff --git a/drivers/pinctrl/pinctrl-imx6q.c b/drivers/pinctrl/pinctrl-imx6q.c
> index 663346b..7eaacfb 100644
> --- a/drivers/pinctrl/pinctrl-imx6q.c
> +++ b/drivers/pinctrl/pinctrl-imx6q.c
> @@ -1952,6 +1952,8 @@ static struct imx_pin_reg imx6q_pin_regs[] = {
>         IMX_PIN_REG(MX6Q_PAD_SD2_DAT3, 0x0744, 0x035C, 7, 0x0000, 0), /* MX6Q_PAD_SD2_DAT3__ANATOP_TESTO_3 */
>         IMX_PIN_REG(MX6Q_PAD_ENET_RX_ER, 0x04EC, 0x01D8, 0, 0x0000, 0), /* MX6Q_PAD_ENET_RX_ER__ANATOP_USBOTG_ID */
>         IMX_PIN_REG(MX6Q_PAD_GPIO_1, 0x05F4, 0x0224, 3, 0x0000, 0), /* MX6Q_PAD_GPIO_1__ANATOP_USBOTG_ID */
> +       IMX_PIN_REG(MX6Q_PAD_EIM_D27, 0x03D4, 0x00C0, 4, 0x0928, 0), /* MX6Q_PAD_EIM_D27__UART2_RXD_DTE */
> +       IMX_PIN_REG(MX6Q_PAD_EIM_D29, 0x03DC, 0x00C8, 4, 0x0924, 0), /* MX6Q_PAD_EIM_D29__UART2_RTS_DTE */
>  };
>
>  /* Pad names for the pinmux subsystem */
> --
> 1.7.1
>
>
