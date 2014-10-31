From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 31 Oct 2014 09:49:35 +0100
Subject: [RFC PATCH 1/2] pinctrl: Add output-disable
In-Reply-To: <1414529835-16207-1-git-send-email-dianders@chromium.org>
References: <1414529835-16207-1-git-send-email-dianders@chromium.org>
Message-ID: <CACRpkdagHFAaPmQptsm7pz_JqYUCbU-0FoH45vrXo8pG6mTAxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 28, 2014 at 9:57 PM, Doug Anderson <dianders@chromium.org> wrote:
> The pinctrl bindings / API allow you to specify that:
> - a pin should be an output
> - a pin should have its input path enabled / disabled
>
> ...but they don't allow you to tell a pin to stop outputting.  Lets
> add a new setting for that just in case the bootloader (or the default
> state) left a pin as an output and we don't want it that way anymore.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
(...)
> + * @PIN_CONFIG_OUTPUT_DISABLE: this will configure the pin _not_ to output.
> + *     Parameter should be 1.

This doesn't make sense. The pin is either low, high, some analog mode
or tristate/high impedance.

It does *not* stop existing.

Figure out the exact electronic meaning of what happens when you do
"output disable" in your hardware, I think it is very likely that
PIN_CONFIG_BIAS_HIGH_IMPEDANCE is what you are really
after here.

Yours,
Linus Walleij
