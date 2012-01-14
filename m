From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 13 Jan 2012 22:37:20 -0700
Subject: [PATCH] GPIO: sa1100: implement proper gpiolib gpio_to_irq
 conversion
In-Reply-To: <20120113231820.GJ1068@n2100.arm.linux.org.uk>
References: <20111218182457.GV14542@n2100.arm.linux.org.uk>
 <CACRpkdZ-W_JHYj2SHZb7wSVHKmnv7UiCgHE84DDcJfX0d_oTSA@mail.gmail.com>
 <20120107120230.GF13857@n2100.arm.linux.org.uk>
 <20120113231820.GJ1068@n2100.arm.linux.org.uk>
Message-ID: <20120114053720.GA4223@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2012 at 11:18:20PM +0000, Russell King - ARM Linux wrote:
> On Sat, Jan 07, 2012 at 12:02:30PM +0000, Russell King - ARM Linux wrote:
> > On Mon, Dec 19, 2011 at 12:17:01AM +0100, Linus Walleij wrote:
> > > On Sun, Dec 18, 2011 at 7:24 PM, Russell King - ARM Linux
> > > <linux@arm.linux.org.uk> wrote:
> > > 
> > > > From: Russell King <rmk+kernel@arm.linux.org.uk>
> > > >
> > > > The existing gpio_to_irq() implementation on sa1100 only translates
> > > > validly for internal GPIOs. ?Since this sub-arch enables GPIOLIB
> > > > support, this results in buggy translations for non-internal GPIOs.
> > > >
> > > > Get rid of the private gpio_to_irq() implementation, replacing it
> > > > with the .to_irq method in the sa1100 gpio chip instead.
> > > >
> > > > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > > 
> > > Thanks Russell!
> > > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > 
> > Grant,
> > 
> > Have you queued this up or is it going to be missed for this merge window?
> > 
> > Thanks.
> 
> Let's try that again, this time with Grant in the To: line rather than
> Linus.

Applied.  Sorry for the delay.  I dropped a lot of patches over
Christmas because I couldn't keep up on my email

g.
