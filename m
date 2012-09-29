From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 29 Sep 2012 21:57:54 +0200
Subject: [PATCH RFC 1/2] gpio: Add a block GPIO API to gpiolib
In-Reply-To: <5065ED4F.5070700@antcom.de>
References: <1348780923-27428-1-git-send-email-stigge@antcom.de>
 <20120928024744.GV17667@game.jcrosoft.org>
 <50654E57.3080201@antcom.de>
 <20120928075145.GW17667@game.jcrosoft.org>
 <50656522.1050900@antcom.de>
 <20120928090848.GX17667@game.jcrosoft.org>
 <20120928102822.GY17667@game.jcrosoft.org>
 <50658AD0.1050501@antcom.de>
 <20120928160105.GA17667@game.jcrosoft.org>
 <5065ED4F.5070700@antcom.de>
Message-ID: <20120929195754.GC17667@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20:32 Fri 28 Sep     , Roland Stigge wrote:
> Hi,
> 
> On 28/09/12 18:01, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >>Maybe like this, for some struct block *?
> >>
> >>block = set_block_prepare(gc, pins, values, size);
> >>if (block) {
> >>	set_block(gc, block);
> >>	...
> >>	set_block_unprepare(gc, block);
> >>}
> >>
> >>Would mean that all supported drivers would need to implement those 3
> >>new functions... Need to be careful about not introducing bloat...
> >the prepare is gpiolib specific, it will be a helper to conver a gpio list to
> >a gpio block list
> >
> >I was thinking more
> >
> >block = gpio_block_prepare(pins, size);
> >
> >gpio_block_set_value(pin0, val);
> >gpio_block_set_value(pin1, val);
> >gpio_block_set_value(pin2, val);
> >gpio_block_set(block);
> >
> >andfor get
> >
> >gpio_block_get(block)
> >val = gpio_block_get_value(block, pin0);
> >val = gpio_block_get_value(block, pin1);
> >
> >for the gpio driver ti's transparent
> 
> Problem here is that it's only an intermediate format since hardware
> often needs special preparation of the data.
> 
> But will evaluate what makes most sense.
the key point here is to avoid to manipualte data each time we call
gpio_block_set

hardware specific will have to be handle at driver level

Best Regards,
J.
