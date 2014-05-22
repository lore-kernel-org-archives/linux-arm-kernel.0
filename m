From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 22 May 2014 14:39:20 -0400 (EDT)
Subject: [PATCH v2] ARM: realview: basic device tree implementation
In-Reply-To: <5233065.1vXjHiDqN2@wuerfel>
References: <1399586896-16906-1-git-send-email-linus.walleij@linaro.org>
 <5057707.jNCXlqf9dH@wuerfel>
 <alpine.LFD.2.11.1405221406100.17310@knanqh.ubzr>
 <5233065.1vXjHiDqN2@wuerfel>
Message-ID: <alpine.LFD.2.11.1405221431370.17310@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 May 2014, Arnd Bergmann wrote:

> On Thursday 22 May 2014 14:09:52 Nicolas Pitre wrote:
> > On Thu, 22 May 2014, Arnd Bergmann wrote:
> > 
> > > On Thursday 22 May 2014 15:45:03 Catalin Marinas wrote:
> > > > By making the DMA memory Strongly Ordered, we avoid the
> > > > L220 write buffer. In addition to the above commit, we also had
> > > > 2503a5ecd86c (ARM: 6201/1: RealView: Do not use outer_sync() on
> > > > ARM11MPCore boards with L220).
> > > 
> > > Ah, so this also stands in the way of multiplatform realview 
> > 
> > Isn't the real value of a multiplatform realview in the ability to use 
> > it with Qemu?  Did Qemu go to the extreme of emulating all those cache 
> > issues?
> 
> The qemu developers have in the past always argued strongly that they
> want to run the same kernel that runs on real hardware. Having a kernel
> that runs only on the emulated version but not on actual hardware is
> clearly against that goal, and  we should use CONFIG_ARCH_VIRT for
> that purpose.

But the kernel that actually runs on the real hardware also runs on Qemu 
already.  It is just that, by some coincidence, a multi-platform kernel 
that pretends to have the same peripherals as a Realview board could 
also be used on Qemu.

Otherwise I really don't see the point in making the code more complex 
just to make a multi-platform kernel run on actual Realview hardware 
that is quite obsolete now and that very few people have access to.


Nicolas
