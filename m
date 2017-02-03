From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 Feb 2017 20:11:33 +0100
Subject: [PATCH 3/5] Documentation: dt: iio: document stm32 exti trigger
In-Reply-To: <1485784663-19505-4-git-send-email-fabrice.gasnier@st.com>
References: <1485784663-19505-1-git-send-email-fabrice.gasnier@st.com>
 <1485784663-19505-4-git-send-email-fabrice.gasnier@st.com>
Message-ID: <CACRpkdZLFKQbDjDXo+ir=8d8gEd=9dLicuVLEXAF2OoWefKJcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2017 at 2:57 PM, Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Add dt documentation for st,stm32-exti-trigger.
> EXTi gpio signal can be routed internally as trigger source for various
> IPs (e.g. for ADC or DAC conversions).

And you say this is done using pin control, elsewhere in the conversation
if I understand it correctly?

> +Contents of a stm32 exti trigger root node:
> +-------------------------------------------
> +Required properties:
> +- compatible: Should be "st,stm32-exti-trigger"
> +- extiN-gpio: optional gpio line that may be used as external trigger source
> +  (e.g. N may be 0..15. For example, exti11-gpio can trig ADC on stm32f4).
> +
> +Example:
> +       triggers {
> +               compatible = "st,stm32-exti-trigger";
> +               exti11-gpio=<&gpioa 11 0>;
> +       };

So what I do not understand i if this has any stm32-specific behaviour at all,
so that compatible-string has any meaning.

Should we not rather define compatible = "gpio-trigger"; to be used by
everyone? Especially for the device tree?

If it's "mostly generic, a bit specific too" it should likely be:

compatible = "gpio-trigger", "st,stm32-exit-trigger";

Yours,
Linus Walleij
