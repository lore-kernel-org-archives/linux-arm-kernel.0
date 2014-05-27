From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 May 2014 10:27:04 +0200
Subject: [PATCH 2/3] arm64:dts: Add APM X-Gene SoC GPIO controller DTS
 entries
In-Reply-To: <1400263432-922-3-git-send-email-fkan@apm.com>
References: <1400263432-922-1-git-send-email-fkan@apm.com>
 <1400263432-922-3-git-send-email-fkan@apm.com>
Message-ID: <CACRpkdaGj9pHFr=-HN65agpkhXphJy45yZREdEZvvuFzyuuo7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 16, 2014 at 8:03 PM, Feng Kan <fkan@apm.com> wrote:

> Add gpio dts node for APM X-Gene SoC platform.
>
> Signed-off-by: Feng Kan <fkan@apm.com>
(...)
> +               gpio: gpio at 1701c000 {
> +                       compatible = "apm,xgene-gpio";
> +                       reg = <0x0 0x1701c000 0x0 0x1000>;
> +
> +                       banka: gpio-controller at 0 {
> +                               compatible = "apm,xgene-gpio-port";
> +                               gpio-controller;
> +                               #gpio-cells = <2>;
> +                               ngpios = <16>;
> +                               bank = <0>;
> +                       };
> +                       bankb: gpio-controller at 1 {
> +                               compatible = "apm,xgene-gpio-port";
> +                               gpio-controller;
> +                               #gpio-cells = <2>;
> +                               ngpios = <16>;
> +                               bank = <1>;
> +                       };
> +                       bankc: gpio-controller at 2 {
> +                               compatible = "apm,xgene-gpio-port";
> +                               gpio-controller;
> +                               #gpio-cells = <2>;
> +                               ngpios = <16>;
> +                               bank = <2>;
> +                       };
> +               };

NAK, please construct this with one gpio per bank and
three independent entries instead of sub-banks.

Yours,
Linus Walleij
