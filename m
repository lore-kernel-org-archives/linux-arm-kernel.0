From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 22 Feb 2018 14:11:26 +0100
Subject: [PATCH 1/6] dt-bindings: mfd: Add ST Multi-Function eXpander
 driver
In-Reply-To: <1518100057-23234-2-git-send-email-amelie.delaunay@st.com>
References: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com>
 <1518100057-23234-2-git-send-email-amelie.delaunay@st.com>
Message-ID: <CACRpkdZxJhntgHwgsg=P98i0aGnXSQ2rXO16H0U=cJ+sBbF27g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 8, 2018 at 3:27 PM, Amelie Delaunay <amelie.delaunay@st.com> wrote:

> +Required properties:
> +- compatible: must be "st,mfx"

I bet this should be more specific. Tomorrow there will be a new
version of this expander and then we will wish that we used
a more specific compatible for the first one.

Does this chip have any kind of product number on it?

Else I would be tempted to use the compatible "st,mfx-0000"
or something, indicating it is the first of its kind.

> +- reg: I2C address of the device
> +- interrupts: interrupt triggered by MFX_IRQ_OUT signal
> +- interrupt-parent: interrupt controller MFX is connected to
> +- interrupt-controller: marks the device as an interrupt controller
> +- #interrupt-cells: should be <1>, index of the interrupt within the
> +  controller, in accordance with the "one cell" variant of
> +  <devicetree/bindings/interrupt-controller/interrupt.txt>

Seems fine.

> +Optional nodes:
> +
> +* GPIO eXpander
> +MFX provides 16 programmable GPIOs, and it is also possible to recover 8
> +alternate GPIOs if the main functions are not used (touchscreen controller and
> +IDD measurement not enabled).

Apparenly Rob thinks this should go elsewhere.

> +- gpio-controller: marks the device node as a GPIO controller
> +- #gpio-cells: should be <2>, the first cell is the GPIO offset on this GPIO
> +  controller, the second cell is the gpio flags in accordance with
> +  <dt-bindings/gpio/st-mfx-gpio.h>.

Let's discuss these extra GPIO flag bindings separately.

Yours,
Linus Walleij
