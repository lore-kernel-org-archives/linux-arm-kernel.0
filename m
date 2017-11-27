From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 27 Nov 2017 18:11:10 -0200
Subject: [PATCH 09/13] ARM: dts: imx6qdl-hummingboard: add SD card
 regulator
In-Reply-To: <E1eJMeI-0002rP-Rt@rmk-PC.armlinux.org.uk>
References: <20171127165134.GH31757@n2100.armlinux.org.uk>
 <E1eJMeI-0002rP-Rt@rmk-PC.armlinux.org.uk>
Message-ID: <CAOMZO5Ch5y-PJWTkwuV9HhasErqx+88wK-B+AtMKtCW3oj0ctg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 2:52 PM, Russell King
<rmk+kernel@armlinux.org.uk> wrote:

> +       v_sd: regulator-v-sd {
> +               compatible = "regulator-fixed";
> +               gpio = <&gpio4 30 GPIO_ACTIVE_HIGH>;

It seems this should be GPIO_ACTIVE_LOW instead because
'enable-active-high' is not passed here.
