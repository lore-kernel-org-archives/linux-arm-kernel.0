From: ckeepax@opensource.wolfsonmicro.com (Charles Keepax)
Date: Sun, 22 Feb 2015 21:31:31 +0000
Subject: [PATCH] ARM: bcm2835: Add header file for pinctrl constants
In-Reply-To: <5700696.0jJhSRhno5@wuerfel>
References: <1424624396-812-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <5700696.0jJhSRhno5@wuerfel>
Message-ID: <20150222213131.GA9837@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 22, 2015 at 09:13:23PM +0100, Arnd Bergmann wrote:
> On Sunday 22 February 2015 16:59:56 Charles Keepax wrote:
> > +
> > +/* IRQ Flags */
> > +#define BCM2835_PIN_IRQ_RISING                         1
> > +#define BCM2835_PIN_IRQ_FALLING                                2
> > +#define BCM2835_PIN_IRQ_EDGE   (BCM2835_PIN_IRQ_RISING | \
> > +                                BCM2835_PIN_IRQ_FALLING)
> > +#define BCM2835_PIN_IRQ_LOW                            4
> > +#define BCM2835_PIN_IRQ_HIGH                           8
> 
> Are these different from the standard definitions?
> 
> > +/* Pin Function Settings */
> > +#define BCM2835_PIN_FUNC_GPIO_IN                       0
> > +#define BCM2835_PIN_FUNC_GPIO_OUT                      1
> > +#define BCM2835_PIN_FUNC_ALT5                          2
> > +#define BCM2835_PIN_FUNC_ALT4                          3
> > +#define BCM2835_PIN_FUNC_ALT0                          4
> > +#define BCM2835_PIN_FUNC_ALT1                          5
> > +#define BCM2835_PIN_FUNC_ALT2                          6
> > +#define BCM2835_PIN_FUNC_ALT3                          7
> 
> Why are these required? They don't seem to be used by any driver,
> which leads me to suspect that they are just the hardware numbers.
> 
> In that case, don't add any syntactical sugar like that and just
> use the hardware numbers directly.

Yeah they are just hardware numbers, I wasn't aware there was a
preference to use the numbers directly in which case just ignore
this patch.

> 
> What's with the strange mapping of numbers anyway?

You would need to ask Broadcom that :-)

Thanks,
Charles
