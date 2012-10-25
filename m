From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Oct 2012 08:46:38 +0200
Subject: [PATCH] [RFC] pinctrl: mvebu: reset pins to an UNKNOWN state on
 startup
In-Reply-To: <1351106281-31288-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1351106281-31288-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CACRpkdaxUS95vPLsW0kSbPn3g0ywMg+MJhrbEJBRa4uaLvw4Fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2012 at 9:18 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> On many platforms, most of the pinmux initialization is done in the
> bootloader, and therefore persists when we boot the Linux kernel. This
> prevents us from making sure that the pinmux configuration in the
> board device trees is correct.
>
> One idea to make sure our device trees are correct in terms of
> pinmuxing is to set the state of each pin to an unavailable function
> during the initialization of the pinctrl driver. This way, only pins
> that are explicitly configured through proper device tree attributes
> will actually be functional.

Now I don't know which kernel senior being it was that told me
never to screw around with the defaults from the boot loader
if not really needed. It is better if the driver reads the hardware
to figure out what state it's in and move on from there.

There may be cases where it's still needed, such as to save
power, if pins (in this case) are set up such that they waste
power unless the default setting is overridden.

So I think it'd be nice if the actual reasons for doing this
movement to a known state were known? Else the design
pattern should be to discover the current state from the
actual hardware registers.

Depending on complexity the above may be a bit utopic...

Yours,
Linus Walleij
