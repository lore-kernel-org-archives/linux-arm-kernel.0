From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 30 May 2017 17:40:06 -0300
Subject: [PATCH] ARM: dts: imx6q-cm-fx6: add sdio wifi/bt nodes
In-Reply-To: <1a13681b84564bc18937eb54b8345957@rwthex-s1-b.rwth-ad.de>
References: <1a13681b84564bc18937eb54b8345957@rwthex-s1-b.rwth-ad.de>
Message-ID: <CAOMZO5Ca+8U2r5hHcUd__d8EPWHQzKg5-WOY8d2NxBGEz18=yw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christopher,

On Tue, May 30, 2017 at 5:16 PM,  <christopher.spinrath@rwth-aachen.de> wrote:

> +       awnh387_pwrseq: pwrseq {
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_pwrseq>;
> +               compatible = "mmc-pwrseq-sd8787";
> +               powerdown-gpios = <&gpio7 12 GPIO_ACTIVE_HIGH>;
> +               reset-gpios = <&gpio6 16 GPIO_ACTIVE_HIGH>;

At least in the AW-NH387 datasheet I found it says:

RESETn: Reset(active low at least 10ns)

Please double check the polarity in device tree.
