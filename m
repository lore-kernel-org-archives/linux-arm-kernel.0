From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Sep 2012 13:57:27 +0000
Subject: [PATCH 15/19] mfd: Don't convert just one IRQ using irqdomain if
 a range is provided
In-Reply-To: <20120907134259.GJ29601@gmail.com>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <201209071337.26587.arnd@arndb.de> <20120907134259.GJ29601@gmail.com>
Message-ID: <201209071357.27779.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 September 2012, Lee Jones wrote:
> On Fri, Sep 07, 2012 at 01:37:26PM +0000, Arnd Bergmann wrote:
> > On Friday 07 September 2012, Lee Jones wrote:
> > > On Fri, Sep 07, 2012 at 12:35:41PM +0000, Arnd Bergmann wrote:
> >
> > The examples I had seen before were all just ranges of two interrupts,
> > and in those cases it was clear that splitting them would be best.
> > 
> > In the exampled of the ab8500-gpio driver, it looks like the resource is
> > not actually being used, and the gpio driver implements its own irq_chip,
> > so maybe we can get away with not solving this problem for now.
> 
> Understood. I'd still feel more comfortable if we didn't trash the
> range. I think it would be best to show the warning, and leave the
> range for its target driver to take care - hence the patch.
> 
> ... but it's your call.

I'm fine with whatever Samuel sees fit here.  My personal opinion is
that leaving the range alone for the child driver to do the conversion
would be too inconsistent and only lead to confusion with driver authors.

	Arnd
