From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 17 May 2017 13:52:29 -0300
Subject: [PATCH v3] ARM: dts: imx7d-pico: Add initial support
In-Reply-To: <1495030219-2688-1-git-send-email-vanessa.maegima@nxp.com>
References: <1495030219-2688-1-git-send-email-vanessa.maegima@nxp.com>
Message-ID: <CAOMZO5Bq90AaiqnXy=sDP1V=sYbCgNt-wCUMaccAbOnXSMFzfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vanessa,

On Wed, May 17, 2017 at 11:10 AM, Vanessa Maegima
<vanessa.maegima@nxp.com> wrote:

> +       reg_usb_otg1_vbus: regulator-usb-otg1-vbus {
> +               compatible = "regulator-fixed";
> +               regulator-name = "usb_otg1_vbus";
> +               regulator-min-microvolt = <5000000>;
> +               regulator-max-microvolt = <5000000>;
> +               gpio = <&gpio4 5 GPIO_ACTIVE_LOW>;
> +               enable-active-low;

'enable-active-low' is not a valid property. Please remove it.

With this fixed you can add:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
