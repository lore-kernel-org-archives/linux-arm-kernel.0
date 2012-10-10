From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 10 Oct 2012 20:22:51 +0200
Subject: [PATCH 01/16] ARM: dts: exynos4210: Replace legacy GPIO bank
 nodes with pinctrl bank nodes
In-Reply-To: <20121010181253.GQ12552@atomide.com>
References: <1349685556-23718-1-git-send-email-t.figa@samsung.com>
 <5075A1EF.60900@wwwdotorg.org> <20121010181253.GQ12552@atomide.com>
Message-ID: <96424007.y4zaCRkHIe@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dnia ?roda, 10 pa?dziernika 2012 11:12:53 Tony Lindgren pisze:
> * Stephen Warren <swarren@wwwdotorg.org> [121010 09:36]:
> > On 10/10/2012 01:26 AM, Linus Walleij wrote:
> > > On Mon, Oct 8, 2012 at 10:39 AM, Tomasz Figa <t.figa@samsung.com> 
wrote:
> > >> Seuqential patches from this series introduce SoC-specific data 
parsing
> > >> from device tree.
> > >> 
> > >> This patch removes legacy GPIO bank nodes from exynos4210.dtsi and
> > >> replaces them with nodes and properties required for these patches.
> > > 
> > > So to be clear:
> > >> +       pinctrl-bank-types {
> > >> +               bank_off: bank-off {
> > >> +                       samsung,reg-names = "func", "dat", "pud",
> > >> +                                               "drv", "conpdn",
> > >> "pudpdn";
> > >> +                       samsung,reg-params = <0x00 4>, <0x04 1>, 
<0x08
> > >> 2>,
> > >> +                                               <0x0C 2>, <0x10 2>,
> > >> <0x14 2>; +               };
> > > 
> > > This is starting to look like a firmware language, I have mixed
> > > feelings about this. Shall this be read:
> > > 
> > > "Poke 4 into 0x00, poke 1 into 0x04, poke 2 into 0x08" etc?
> > > 
> > > We really need to discuss this, Grant has already NACK:ed
> > > such approaches once.
> > 
> > Well, I don't think he NACK'd Tony Lindgren's generic pinctrl driver,
> > which is doing this exact same thing. I did raise the same point about
> > Tony's driver when he posted it, but nobody seemed inclined to NACK it
> > based on that at the time, IIRC...
> 
> To summarize, using reg value pairs in DT makes sense if the amount
> of data is huge. Otherwise we'll be describing indidual hardware bits
> as properties in DT, or have to have huge amounts of static data in
> the kernel.
> 
> Where it does not make sense is if there's a sequence of reads
> and writes with test loops in between.. But that's does not look
> to be the case here.
> 
> The reg value pairs will be readable when the DT preprocessing is
> available, and that allows the values to be orred together while
> DT properties don't. The alternative is to describe hardware register
> bits as DT properties, which is very bloated.
> 
> But considering all this.. Are the samsung,reg-names really needed
> by the kernel?

They are used to specify which registers are defined in reg-params property 
and in which order. Most of the registers are not mandatory and this is 
needed to be able to specify only those that are present. At least I 
couldn't think of a better solution for this. Do you have some suggestions?

Best regards,
Tomasz Figa
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121010/8a94d561/attachment-0001.html>
