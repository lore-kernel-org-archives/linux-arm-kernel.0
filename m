From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Oct 2011 17:11:13 +0200
Subject: [GIT PULL] DEBUG_LL platform updates for 3.2
In-Reply-To: <4EA18638.6020809@gmail.com>
References: <20110928103815.GA8344@e102144-lin.cambridge.arm.com>
	<20111021105941.GE30168@mudshark.cambridge.arm.com>
	<4EA18638.6020809@gmail.com>
Message-ID: <201110211711.13863.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 October 2011, Rob Herring wrote:
> On 10/21/2011 05:59 AM, Will Deacon wrote:
> > Hi Arnd,
> > 
> > On Thu, Oct 20, 2011 at 03:57:49PM +0100, Arnd Bergmann wrote:
> >> Ok, thanks a lot. I've updated my branches now and recreated
> >> the for-next branch with these. Can you have a look to make sure
> >> that everything looks good there now?
> > 
> > The cpu mapping and debug-ll stuff all looks good to me, thanks. On the
> > downside, I'm seeing a couple of problems with your for-next branch:
> > 
> > 1. I can't compile if !CONFIG_OF, because l2x0_init isn't declared in
> >    cache-l2x0.h. There seems to be some broken ifdeffery because of
> >    what looks like duplicate commits d94527dd and 5260f15b, although
> >    they are slightly different (and actually, both look broken to me
> >    anyway!).
> > 
> 
> This was caught in linux-next.

It was my fault, but I think it works now.

> > 2. The GIC is hosed on versatile express. Reverting e3f14d3 ("ARM: gic: add
> >    OF based initialization") and 2071a2a4 ("ARM: gic: add irq_domain support")
> >    allows me to boot again.
> > 
> 
> I'll take a look at it today. Do you have more details or a boot log?

I hope you find this, otherwise I'll have to take the next/soc branch out of
for-next in the meantime to avoid the regressions.

Thanks for looking into it!

	Arnd
