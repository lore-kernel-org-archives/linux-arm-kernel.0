From: sameo@linux.intel.com (Samuel Ortiz)
Date: Sat, 22 Sep 2012 00:20:53 +0200
Subject: [PATCH 15/19] mfd: Don't convert just one IRQ using irqdomain if
 a range is provided
In-Reply-To: <20120917141105.GE6777@gmail.com>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <201209071337.26587.arnd@arndb.de>
 <20120907134259.GJ29601@gmail.com>
 <201209071357.27779.arnd@arndb.de>
 <20120917134550.GU3647@sortiz-mobl>
 <20120917141105.GE6777@gmail.com>
Message-ID: <20120921222053.GC28670@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Mon, Sep 17, 2012 at 03:11:07PM +0100, Lee Jones wrote:
> On Mon, Sep 17, 2012 at 03:45:50PM +0200, Samuel Ortiz wrote:
> > Hi Lee, Arnd,
> > 
> > On Fri, Sep 07, 2012 at 01:57:27PM +0000, Arnd Bergmann wrote:
> > > On Friday 07 September 2012, Lee Jones wrote:
> > > > On Fri, Sep 07, 2012 at 01:37:26PM +0000, Arnd Bergmann wrote:
> > > > > On Friday 07 September 2012, Lee Jones wrote:
> > > > > > On Fri, Sep 07, 2012 at 12:35:41PM +0000, Arnd Bergmann wrote:
> > > > >
> > > > > The examples I had seen before were all just ranges of two interrupts,
> > > > > and in those cases it was clear that splitting them would be best.
> > > > > 
> > > > > In the exampled of the ab8500-gpio driver, it looks like the resource is
> > > > > not actually being used, and the gpio driver implements its own irq_chip,
> > > > > so maybe we can get away with not solving this problem for now.
> > > > 
> > > > Understood. I'd still feel more comfortable if we didn't trash the
> > > > range. I think it would be best to show the warning, and leave the
> > > > range for its target driver to take care - hence the patch.
> > > > 
> > > > ... but it's your call.
> > > 
> > > I'm fine with whatever Samuel sees fit here.  My personal opinion is
> > > that leaving the range alone for the child driver to do the conversion
> > > would be too inconsistent and only lead to confusion with driver authors.
> > Although I agree modifying the range is not very nice from the MFD core, I
> > also think that the actual mapping should always be handled by MFD and not
> > depend on wether the range is a singleton or not. Moreover the semantics of
> > leaving the range untouched meaning that we haven't done the mappings is
> > obscure.
> > So I'm not taking this patch, sorry Lee.
> 
> No problem.
> 
> Would it be better if we _did_ support ranges, and map all of the
> IRQs in the range instead?
I think that would be a reasonable solution, unless Arnd or Mark see a serious
problem with that.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
