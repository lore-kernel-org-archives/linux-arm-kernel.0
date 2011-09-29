From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 29 Sep 2011 14:42:03 -0400 (EDT)
Subject: Git pull request: mach/vmalloc.h removal,
	and ioremap optimizations
In-Reply-To: <4E84B80D.2020605@gmail.com>
References: <alpine.LFD.2.00.1109230908410.12663@xanadu.home>
	<4E8495D9.2030009@gmail.com>
	<20110929173731.GB21718@n2100.arm.linux.org.uk>
	<4E84B80D.2020605@gmail.com>
Message-ID: <alpine.LFD.2.02.1109291439110.9106@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 29 Sep 2011, Rob Herring wrote:

> On 09/29/2011 12:37 PM, Russell King - ARM Linux wrote:
> > My guess would be:
> > 
> >         }, {
> >                 .virtual        =  IO_ADDRESS(VERSATILE_SCTL_BASE),
> >                 .pfn            = __phys_to_pfn(VERSATILE_SCTL_BASE),
> >                 .length         = SZ_4K * 9,
> >                 .type           = MT_DEVICE
> >         },
> > #ifdef CONFIG_MACH_VERSATILE_AB
> >         {
> >                 .virtual        =  IO_ADDRESS(VERSATILE_GPIO0_BASE),
> >                 .pfn            = __phys_to_pfn(VERSATILE_GPIO0_BASE),
> >                 .length         = SZ_4K,
> >                 .type           = MT_DEVICE
> > 
> > #define VERSATILE_SCTL_BASE            0x101E0000	/* System controller */
> > #define VERSATILE_GPIO0_BASE           0x101E4000	/* GPIO port 0 */
> > 
> > I don't see why GPIO0 is explicitly listed here.
> 
> It works for PB and AB with that removed. Here's a patch:
[...]

Thanks for testing and the patch.  I've inserted it in my patch series 
and pushed the result out.


Nicolas
