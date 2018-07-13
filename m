From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 13 Jul 2018 14:59:13 -0300
Subject: [PATCH] ARM: dts: imx6sl-evk: add missing GPIO iomux setting
In-Reply-To: <1531468530-25667-1-git-send-email-Anson.Huang@nxp.com>
References: <1531468530-25667-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <CAOMZO5D2HiWsYYKUXV-7srXwvOBQE487ARs8J3=hvYpXcqm3TQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anson,

On Fri, Jul 13, 2018 at 4:55 AM, Anson Huang <Anson.Huang@nxp.com> wrote:
> On i.MX6SL EVK board, the MX6SL_PAD_KEY_ROW5 pin is
> used as lcd 3v3 regulator control pin, need to make
> sure MX6SL_PAD_KEY_ROW5 is muxed as GPIO function
> for controlling lcd 3v3 regulator.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm/boot/dts/imx6sl-evk.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
> index 50bdc65..1294fba 100644
> --- a/arch/arm/boot/dts/imx6sl-evk.dts
> +++ b/arch/arm/boot/dts/imx6sl-evk.dts
> @@ -283,6 +283,7 @@
>         imx6sl-evk {
>                 pinctrl_hog: hoggrp {
>                         fsl,pins = <
> +                               MX6SL_PAD_KEY_ROW5__GPIO4_IO03    0x17059

You could add a specific group for it instead of putting it inside the
hog group.
