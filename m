From: anders.berg@lsi.com (Anders Berg)
Date: Fri, 25 Apr 2014 11:43:43 +0200
Subject: [PATCH v2 3/6] ARM: dts: Device tree for AXM55xx.
In-Reply-To: <CACRpkdZ1CA4mqcd5MA5HFmXSeGp-wspA0M6wnPbAsgL_gX76Fw@mail.gmail.com>
References: <cover.1398335771.git.anders.berg@lsi.com>
 <2386bd1367aa44741979461358a72dec89608597.1398335771.git.anders.berg@lsi.com>
 <CACRpkdbU6UashxCuPMDjEB_nbB=mXicGpjJy=HGC6r3qfxCtVQ@mail.gmail.com>
 <20140424174741.GA23444@swsaberg01>
 <CACRpkdZ1CA4mqcd5MA5HFmXSeGp-wspA0M6wnPbAsgL_gX76Fw@mail.gmail.com>
Message-ID: <20140425094343.GA3160@swsaberg01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 25, 2014 at 11:16:18AM +0200, Linus Walleij wrote:
> On Thu, Apr 24, 2014 at 7:47 PM, Anders Berg <anders.berg@lsi.com> wrote:
> > On Thu, Apr 24, 2014 at 03:24:14PM +0200, Linus Walleij wrote:
> 
> >> One interrupt per CPU core?
> >>
> >> The drivers for these blocks will really just grab the first IRQ and
> >> then I guess they
> >> will only be able to execute on CPU0.
> >>
> >> It's definately correct to list all the IRQs here, but how do you envision
> >> the drivers making use of them in the long run?
> >
> > It's one interrupt line per input pin (so with the current driver only the first pin
> > is usable as interrupt source).
> 
> Hm I'm not sure I understand what a "pin" is in this concept ...
> being maintainer of the pin control subsystem and all that really
> triggers my interest.
> 

Ok, maybe should replace "pin" with "GPIO" in my previous comment.

So, a clarification. In one of the PL061 blocks (named gpio0 in the dts) there
is a separate interrupt per GPIO (I assume the motivation here is to enable to
control irq affinity per GPIO), where as the other block has a more standard
configuration with a single interrupt for all 8 GPIOs in that block.

/Anders


> Yours.
> Linus Walleij
> 
