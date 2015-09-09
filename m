From: alexanders83@web.de (Alexander Stein)
Date: Wed, 09 Sep 2015 11:00:43 +0200
Subject: [PATCH v5 0/6] bcm2835: auxiliar device support for spi
In-Reply-To: <87h9n4weg8.fsf@eliezer.anholt.net>
References: <1441359711-2800-1-git-send-email-kernel@martin.sperl.org>
 <87h9n4weg8.fsf@eliezer.anholt.net>
Message-ID: <2757852.TDqE8OEVr2@ws-stein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
On Tuesday 08 September 2015 18:48:07, Eric Anholt wrote:
> I finally had a chance to sit down and look at what the hardware's doing
> with the enable bit (also, I've read a whole lot more of the hardware
> now, so I'm a lot faster at answering questions like this).  The enable
> bits are a clock gate off of the VPU clock.

Are any hardware documents about such things available (in public)?

> I knocked together the enable bits as a clock gate driver, since I'd
> just written very similar code for the audio domain clock driver (and I
> assume you are grumpy about how much time you've spent on this one
> stupid register).  It's up at
> https://github.com/anholt/linux/tree/bcm2835-clock-aux and I can submit
> it if you like the result.  I've compile tested it only, but I'm hoping
> you could just drop your aux SPI driver on top of it and have things
> work.

IMHO line 45 (https://github.com/anholt/linux/commit/facb4ba917a1b9f6c2ee0cea7d529acf55f584dd#diff-1b6f753c132811b3f6d70f5b31866950R45) should be like this
> onecell->clks = kzalloc(sizeof(*onecell->clks) * BCM2835_AUX_CLOCK_COUNT, GFP_KERNEL);
or you will only allocate a single struct clk*.

Best regards,
Alexander
