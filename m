From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Dec 2014 10:56:16 +0100
Subject: [PATCH v1 1/3] gpio: Add APM X-Gene standby GPIO controller driver
In-Reply-To: <CAL4ahLfSZjmqqbQ9Xmqae_AVfFZLiUUEN+rABMwiu2_8u4mmPQ@mail.gmail.com>
References: <1412779948-28769-1-git-send-email-yvo@apm.com>
 <2250730.N6DdkCTXkh@wuerfel>
 <CAL4ahLfSZjmqqbQ9Xmqae_AVfFZLiUUEN+rABMwiu2_8u4mmPQ@mail.gmail.com>
Message-ID: <1878846.YCCkHOWfdd@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 December 2014 16:43:02 Y Vo wrote:
> >> +static int xgene_gpio_sb_get(struct gpio_chip *gc, u32 gpio)
> >> +{
> >> +       struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> >> +       struct xgene_gpio_sb *chip = to_xgene_gpio_sb(mm_gc);
> >> +       u32 data;
> >> +
> >> +       data = ioread32(mm_gc->regs + MPA_GPIO_IN_ADDR);
> >> +
> >> +       return (data &  GPIO_MASK(gpio)) ? 1 : 0;
> >> +}
> >
> > This would be actually broken, right? Maybe it's better to change the
> > driver so that it refuses to map GPIO lines that are hardwired to
> > the interrupt controller, until we can support that.
> 
> It still works if they are configure as GPIO.
> Do you have any reference to resolve it ?

Ok, I think I just misunderstood how this works, I assumed that you
could not reconfigure the lines. Seems ok then.

	Arnd
