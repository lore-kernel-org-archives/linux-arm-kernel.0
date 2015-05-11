From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Mon, 11 May 2015 11:36:55 +0200
Subject: [PATCH 1/2] Regulator: mc34708: Add DT binding documentation
In-Reply-To: <20150428141738.16243.18377.stgit@localhost>
References: <20150428141736.16243.57292.stgit@localhost>
 <20150428141738.16243.18377.stgit@localhost>
Message-ID: <CABxcv=nEuVj-svKyUAGnptz8G=xVbXxOLVEApXmnjF7EUQawvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Martin,

I haven't looked at your regulator driver in detail so this is not a
full review but I just noticed something so I wanted mention.

> +
> +
> +Example:
> +&i2c3 {
> +       pmic: mc34708 at 08 {
> +               compatible = "fsl,mc34708";
> +               reg = <0x08>;
> +               regulators {
> +#define PMIC_REGMODE_SW_PFM    1
> +#define PMIC_REGMODE_SW_AUTO   2
> +#define PMIC_REGMODE_SW_PWM    3
> +#define PMIC_REGMODE_LDO_LP    1
> +#define PMIC_REGMODE_LDO_NORMAL        2
> +

I see that you are defining these constants in your driver too (albeit
with slightly different names). These kind of constants that are
shared between the driver implementation and the Device Tree source
files should be added to include/dt-bindings/regulator/ and included
in both the driver and the DTS.

Best regards,
Javier
