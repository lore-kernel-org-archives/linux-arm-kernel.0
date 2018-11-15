From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Nov 2018 10:43:05 +0100
Subject: [PATCH 1/3] dt-bindings: gpio: add sama5d2 PIOBU support
In-Reply-To: <1541603580-17448-2-git-send-email-andrei.stefanescu@microchip.com>
References: <1541603580-17448-1-git-send-email-andrei.stefanescu@microchip.com>
 <1541603580-17448-2-git-send-email-andrei.stefanescu@microchip.com>
Message-ID: <CACRpkdZvJmH61C8Rd3TeTioag+11GHPGdCDwRHxx3UAzB-rUHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 7, 2018 at 4:12 PM <Andrei.Stefanescu@microchip.com> wrote:

> +Required properties:
> +- compatible:          "syscon", "microchip,sama5d2-piobu"

Looks like "syscon" should be dropped, it is using a syscon,
but it is no syscon.

> +       secumod at fc040000 {
> +               compatible = "syscon", "microchip,sama5d2-piobu";
> +               reg = <0xfc040000 0x100>;
> +
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +       };

Isn't it easiest to just make this driver be a subnode of the
syscon so it can just refer to its parent to find the
syscon it needs?

Just state that in the bindings and make an example where
it is inside the syscon.

Yours,
Linus Walleij
