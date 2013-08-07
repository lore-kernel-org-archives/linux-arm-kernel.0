From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 7 Aug 2013 21:03:36 +0200
Subject: [PATCH 1/7] gpio: mxc: Support initialization as subdevice
In-Reply-To: <1375439907-10462-2-git-send-email-mpa@pengutronix.de>
References: <1375439907-10462-1-git-send-email-mpa@pengutronix.de>
 <1375439907-10462-2-git-send-email-mpa@pengutronix.de>
Message-ID: <CACRpkda+oLASgNkCWD5n9f6a2ECvvb95wJoEvqXF3ebeQu9Spw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 2, 2013 at 12:38 PM, Markus Pargmann <mpa@pengutronix.de> wrote:

> On imx27 and imx21, there is no clear seperation between iomux control
> registers and GPIO data registers. For easier pingroup definitions, the
> gpio drivers will be initialized as subnodes of the iomux controller. It
> is necessary to share the registers between iomux and gpio.
>
> This patch adds support to pass a register memory region via platform
> data.
>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

I think you have misunderstood that it is perfectly legal for
several drivers to remap the same memory range. I think
you should just drop this quirk and happily remap the memory
in both drivers.

Yours,
Linus Walleij
