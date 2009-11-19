From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Nov 2009 09:43:59 +0000
Subject: drivers/rtc/rtc-pl031.c uses __raw_readl()?
In-Reply-To: <20091113232637.GB8637@n2100.arm.linux.org.uk>
References: <63386a3d0911110130j2056a355l16cade8d30edb6cd@mail.gmail.com>
	<63386a3d0911120043y2143c7f5w7289bc83b2e31847@mail.gmail.com>
	<20091113232637.GB8637@n2100.arm.linux.org.uk>
Message-ID: <20091119094359.GF13376@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 13, 2009 at 11:26:37PM +0000, Russell King - ARM Linux wrote:
> On Thu, Nov 12, 2009 at 09:43:43AM +0100, Linus Walleij wrote:
> > 2009/11/11 Linus Walleij <linus.ml.walleij@gmail.com>:
> > 
> > > Is there some special reason as to why drivers/rtc/rtc-pl031.c uses
> > > the __raw_[read|write]l() macro instead of plain [read|write]l()?
> > 
> > Reading the macro definitions I come to the conclusion that readl()
> > is always little-endian and __raw_readl() is the machine endianness,
> > so that if you put your ARM in BE mode or synthesize this PrimeCell
> > on PPC, it will not work. PrimeCell registers are always LE I believe.
> > 
> > Now none of that was exactly obvious so please correct me if I'm
> > wrong!
> 
> I think it's a question for Catalin - unfortunately the AMBA specifications
> (which I guess is where there's a definitive statement on the endianness
> for APB peripherals) is only available to registered users via the ARM
> website.

So where do we stand on this?  Are Primecell registers always LE?  Or
can they be BE if running in one of the BE modes?

I'm not merging the patch until we have a definitive answer on this.
