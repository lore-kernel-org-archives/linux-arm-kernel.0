From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 27 Nov 2017 18:12:38 -0200
Subject: [PATCH 02/13] ARM: dts: imx6qdl: SolidRun: move AR8035 into
 microsom
In-Reply-To: <E1eJMdi-0002qY-Ta@rmk-PC.armlinux.org.uk>
References: <20171127165134.GH31757@n2100.armlinux.org.uk>
 <E1eJMdi-0002qY-Ta@rmk-PC.armlinux.org.uk>
Message-ID: <CAOMZO5C+z2nFv0pFz5XDY-DGtj2YvhU_kNh1H8mdq6GOUqc_Mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 2:52 PM, Russell King
<rmk+kernel@armlinux.org.uk> wrote:

> +               pinctrl_microsom_enet_ar8035: microsom-enet-ar8035 {
> +                       fsl,pins = <
> +                               MX6QDL_PAD_ENET_MDIO__ENET_MDIO         0x1b8b0
> +                               MX6QDL_PAD_ENET_MDC__ENET_MDC           0x1b0b0
> +                               /* AR8035 reset */
> +                               MX6QDL_PAD_KEY_ROW4__GPIO4_IO15         0x130b0
> +                               /* AR8035 interrupt */
> +                               MX6QDL_PAD_DI0_PIN2__GPIO4_IO18         0x80000000

Please avoid  0x80000000 and use the real IOMUX value instead.

> +                               /* GPIO16 -> AR8035 25MHz */
> +                               MX6QDL_PAD_GPIO_16__ENET_REF_CLK        0xc0000000

Ditto.

> +                               MX6QDL_PAD_RGMII_TXC__RGMII_TXC         0x80000000

Ditto.
