From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 19 Oct 2016 14:16:13 +0200
Subject: [PATCH v2] ARM: bcm2835: Add names for the Raspberry Pi GPIO lines
In-Reply-To: <20161018163808.6318-1-eric@anholt.net>
References: <20161018163808.6318-1-eric@anholt.net>
Message-ID: <CACRpkda20M2YmTRBGA6nyv7t5GHU7_xWu3du0U4tXrnP-M63Og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2016 at 6:38 PM, Eric Anholt <eric@anholt.net> wrote:

> From: Linus Walleij <linus.walleij@linaro.org>
>
> The idea is to give useful names to GPIO lines that an implementer
> will be using from userspace, e.g. for maker type projects.  These are
> user-visible using tools/gpio/lsgpio.c
>
> v2: Major rewrite by anholt: Flatten each GPIO line to a line in the
>     file for better diffing, prefix all expansion header pins with
>     "P<number>" or "P5HEADER_P<number>" and drop the mostly-unused
>     GPIO_GEN<smallnumber> names in favor of GPIO<socgpionumber>, fix
>     extra '[]' on a couple of lines, fix locations of SD_CARD_DETECT,
>     CAM_GPIO and STATUS_LED, fix HDMI_HPD polarities, rewrite A+ using
>     unreleased schematics.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Eric Anholt <eric@anholt.net>

Generally looks good!

I fully trust your usage of he Pnn_* prefix, I assume this
makes a lot of sense to RPi users.

> Note: I haven't actually booted these and checked that the names line
> up, just tried to visually review them.  Hopefully with more
> GPIO<number> values, it's easier to spot errors.
>
> The only other thing here I think I would do is drop the [] around
> names for behavior when pinmuxed.  I find it more confusing than
> helpful.

I added this on the 96board HiKey instead of just leaving it blank.

The idea was to distinguish somehow between GPIO proper and
a GPIO line that is actually not used as GPIO. It is only really
reflecting the schematic, so whatever makes sense for someone
familiar with the schematics apply.

I think it is up to the .dts file maintainer to decide. May even be
different things that make sense on different boards.

> Linus, are these names considered ABI?  Will we be locked into
> whatever set of names we merge and release?  My assumption would be
> "yes".

It is ABI if there is a userspace making use of it. So once libs
like libmraa (is that the name?) and similar things that do userspace
GPIO start using it, it becomes ABI.

Yours,
Linus Walleij
