From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 23 Jul 2012 14:10:42 +0100
Subject: Device tree.
In-Reply-To: <alpine.LFD.2.02.1207191648080.9293@xanadu.home>
References: <500552C9.4090107@codethink.co.uk> <50056E22.5040308@gmail.com>
 <5b5e32ecde7b96d3af217054150eb43c@codethink.co.uk>
 <13863985.aH2icoQzEI@flexo> <50057CD2.2060001@codethink.co.uk>
 <alpine.LFD.2.02.1207171712070.9293@xanadu.home>
 <50066AE6.6000002@codethink.co.uk>
 <alpine.LFD.2.02.1207180929230.9293@xanadu.home>
 <5007CE35.8060705@codethink.co.uk>
 <alpine.LFD.2.02.1207191648080.9293@xanadu.home>
Message-ID: <20120723131042.GD8302@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 19, 2012 at 05:32:09PM -0400, Nicolas Pitre wrote:
> On Thu, 19 Jul 2012, Ian Molton wrote:

> > * Old bootloaders cant always be replaced (ROM) or chainload (lack
> >   of flash) a newer one.

> Hence CONFIG_ARM_APPENDED_DTB.  And don't tell me that you have u-Boot 
> in ROM, in which case uImage shouldn't matter.

For most of the boards I have it doesn't matter that the bootloader is
in flash, there's no way I'm going to risk bricking the board by trying
to replace the bootloader as I've got no way to recover the board if the
bootloader fails.  There's also the fact that if the bootloader supplies
the DT it can't boot kernels that don't understand DT as the machine ID
is changed (which isn't enormously helpful).

> > If zImage is the one true way, thats fine - and I actually would prefer
> > that, I think uImages are stupid.

> > But - since its not the only way, it'd be sensible if the 'other way'
> > actually worked, or was officially made an out of tree option (thus
> > making it work again because you can concat. the .dtb file prior to
> > making the uImage.)

> Isn't that what I just showed above?

It's possible to work with it, but then it's not clear to me why we have
CONFIG_ARM_APPENDED_DTB at all since pretty much the same thing applies
to non-DT cases.
