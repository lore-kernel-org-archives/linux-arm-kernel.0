From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 27 May 2018 21:56:18 -0300
Subject: [PATCH 1/3] ARM: dts: imx6 wandboard and riotboard: remove
 regulators bus node
In-Reply-To: <20180526183053.14029-2-akurz@blala.de>
References: <20180526183053.14029-1-akurz@blala.de>
 <20180526183053.14029-2-akurz@blala.de>
Message-ID: <CAOMZO5A_eMtMNxyzqryDmmMYTrWOSwZAL++K9x4b9Lz5KpQjzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 26, 2018 at 3:30 PM, Alexander Kurz <akurz@blala.de> wrote:

> +       reg_usb_otg_vbus: fixedregulator at 2 {
> +               compatible = "regulator-fixed";
> +               regulator-name = "usb_otg_vbus";
> +               regulator-min-microvolt = <5000000>;
> +               regulator-max-microvolt = <5000000>;
> +               gpio = <&gpio3 22 0>;

Please use  gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>; instead.

> +               enable-active-high;
