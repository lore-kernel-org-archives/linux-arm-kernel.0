From: tony@atomide.com (Tony Lindgren)
Date: Fri, 8 Jun 2012 05:32:13 -0700
Subject: [PATCH 1/3] pinctrl: add samsung pinctrl and gpiolib driver
In-Reply-To: <CACRpkdZDnFW4-bDsHN5BOr2e5NLGzouSBY7ngf-VsoPn-SyxAA@mail.gmail.com>
References: <1337816857-14694-1-git-send-email-thomas.abraham@linaro.org>
 <1337816857-14694-2-git-send-email-thomas.abraham@linaro.org>
 <CACRpkdZDnFW4-bDsHN5BOr2e5NLGzouSBY7ngf-VsoPn-SyxAA@mail.gmail.com>
Message-ID: <20120608123213.GP12766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Linus Walleij <linus.walleij@linaro.org> [120531 18:40]:
> On Thu, May 24, 2012 at 7:47 AM, Thomas Abraham
> <thomas.abraham@linaro.org> wrote:
> 
> > diff --git a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
> 
> It would be nice if some DT person could review the bindings, but if
> nothing happens
> I will accept them as-is.

Looks OK to me, that's a bit slower way of parsing pins compared to
just register value pairs but allows naming them. And it was agreed
that it's up to the driver to define it's binding.
 
> This driver is special since it seems to keep all pin, group and
> function information
> in the device tree, but not like Tony is doing it in pinctrl-simple,
> if I understand
> correctly?

Looks like it's using static arrays which I was too using earlier.
That too should be OK for now, then at some point we can probably
have something generic to manage the pins for at least some drivers.

Regards,

Tony
 
