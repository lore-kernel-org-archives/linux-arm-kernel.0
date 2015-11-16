From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 16 Nov 2015 16:11:32 +0100
Subject: [PATCH 1/2] ls2080a/dts: Add little endian property for GPIO IP
 block
In-Reply-To: <1446549552-40675-1-git-send-email-Gang.Liu@freescale.com>
References: <1446549552-40675-1-git-send-email-Gang.Liu@freescale.com>
Message-ID: <CACRpkdbf4X=dcZhtNrcJp7Zp_hnVDGH1gpKML-e=qcAgEzb0Nw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 3, 2015 at 12:19 PM, Liu Gang <Gang.Liu@freescale.com> wrote:

> The GPIO block for ls2080a platform has little endian registers,
> the GPIO driver needs this property to read/write registers by
> right interface.
>
> Signed-off-by: Liu Gang <Gang.Liu@freescale.com>
>
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-mpc8xxx.txt b/Documentation/devicetree/bindings/gpio/gpio-mpc8xxx.txt
> index f2455c5..c836dab 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-mpc8xxx.txt
> +++ b/Documentation/devicetree/bindings/gpio/gpio-mpc8xxx.txt
> @@ -10,6 +10,9 @@ Required properties:
>    the second cell is used to specify the gpio polarity:
>        0 = active high
>        1 = active low
> +- little-endian : Should be set if the GPIO has little endian
> +                 registers. No the property means the GPIO
> +                 registers are big endian mode.

That is a very generic binding and I would like the devicetree
maintainers to say something about this.

I would be OK if this is specified for *all* gpiochips in
Documentation/devicetree/bindings/gpio/gpio.txt
or even higher up in the desriptions.

Just for Freescale seems a bit too local.

Yours,
Linus Walleij
