From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 7 Jan 2012 12:02:30 +0000
Subject: [PATCH] GPIO: sa1100: implement proper gpiolib gpio_to_irq
 conversion
In-Reply-To: <CACRpkdZ-W_JHYj2SHZb7wSVHKmnv7UiCgHE84DDcJfX0d_oTSA@mail.gmail.com>
References: <20111218182457.GV14542@n2100.arm.linux.org.uk>
 <CACRpkdZ-W_JHYj2SHZb7wSVHKmnv7UiCgHE84DDcJfX0d_oTSA@mail.gmail.com>
Message-ID: <20120107120230.GF13857@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2011 at 12:17:01AM +0100, Linus Walleij wrote:
> On Sun, Dec 18, 2011 at 7:24 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> 
> > From: Russell King <rmk+kernel@arm.linux.org.uk>
> >
> > The existing gpio_to_irq() implementation on sa1100 only translates
> > validly for internal GPIOs. ?Since this sub-arch enables GPIOLIB
> > support, this results in buggy translations for non-internal GPIOs.
> >
> > Get rid of the private gpio_to_irq() implementation, replacing it
> > with the .to_irq method in the sa1100 gpio chip instead.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Thanks Russell!
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Grant,

Have you queued this up or is it going to be missed for this merge window?

Thanks.
