From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 22 May 2014 20:26:19 +0200
Subject: [PATCH v2] ARM: realview: basic device tree implementation
In-Reply-To: <alpine.LFD.2.11.1405221406100.17310@knanqh.ubzr>
References: <1399586896-16906-1-git-send-email-linus.walleij@linaro.org>
 <5057707.jNCXlqf9dH@wuerfel>
 <alpine.LFD.2.11.1405221406100.17310@knanqh.ubzr>
Message-ID: <5233065.1vXjHiDqN2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 22 May 2014 14:09:52 Nicolas Pitre wrote:
> On Thu, 22 May 2014, Arnd Bergmann wrote:
> 
> > On Thursday 22 May 2014 15:45:03 Catalin Marinas wrote:
> > > By making the DMA memory Strongly Ordered, we avoid the
> > > L220 write buffer. In addition to the above commit, we also had
> > > 2503a5ecd86c (ARM: 6201/1: RealView: Do not use outer_sync() on
> > > ARM11MPCore boards with L220).
> > 
> > Ah, so this also stands in the way of multiplatform realview 
> 
> Isn't the real value of a multiplatform realview in the ability to use 
> it with Qemu?  Did Qemu go to the extreme of emulating all those cache 
> issues?

The qemu developers have in the past always argued strongly that they
want to run the same kernel that runs on real hardware. Having a kernel
that runs only on the emulated version but not on actual hardware is
clearly against that goal, and  we should use CONFIG_ARCH_VIRT for
that purpose.

	Arnd
