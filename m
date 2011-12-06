From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 5 Dec 2011 19:37:26 -0500 (EST)
Subject: realview compulsory enables CONFIG_ARM_PATCH_PHYS_VIRT on me
In-Reply-To: <20111205233621.GH14542@n2100.arm.linux.org.uk>
References: <CACRpkdZ8jpz7WTP3gpfcTykQZaCjQLN9PZCAS+UJOWrzZo1bjQ@mail.gmail.com>
 <4EDD3E5E.6050106@gmail.com> <alpine.LFD.2.02.1112051707520.2357@xanadu.home>
 <20111205233621.GH14542@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1112051934000.2357@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 5 Dec 2011, Russell King - ARM Linux wrote:

> On Mon, Dec 05, 2011 at 05:08:12PM -0500, Nicolas Pitre wrote:
> > On Mon, 5 Dec 2011, Rob Herring wrote:
> > 
> > > On 12/05/2011 03:22 PM, Linus Walleij wrote:
> > > > Hi Nico,
> > > > 
> > > > now I'm lost, I discussed by boot problems on ARM PB1176
> > > > with Marc and after some investigation I found this strange thing on
> > > > the lastest rc:s since -rc1:
> > > > 
> > > > In arch/arm/Kconfig ARM_PATCH_PHYS_VIRT is forcibly
> > > > disabled like so:
> > > > 
> > > > depends on !ARCH_REALVIEW || !SPARSEMEM
> > > 
> > > should be !ARCH_REALVIEW && !SPARSEMEM ?
> > 
> > Indeed.
> 
> No, it's correct.  None of you are understanding the logic.
> 
> If you don't understand it, draw up a truth table:
> 
> ARCH_REALVIEW	SPARSEMEM	result
> n		n		y
> n		y		y
> y		n		y
> y		y		n
> 
> And this clearly shows that if we have realview _and_ sparsemem enabled,
> then we don't want P2V patching in place.

I didn't look closely at Realview.  However the usefulness of P2V 
patching when sparsemem is used is somewhat questionable I would say. 


Nicolas
