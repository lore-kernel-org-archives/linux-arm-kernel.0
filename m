From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 5 Jul 2013 12:30:07 -0400 (EDT)
Subject: kernel decompressor problem for ARMv7
In-Reply-To: <20130705095757.GA13063@mudshark.cambridge.arm.com>
References: <CAF1ivSakn8-HiAf+4_cLRWUUTDP9QBKpAt+hVQoMyAmKZ2-dJA@mail.gmail.com>
 <20130705095757.GA13063@mudshark.cambridge.arm.com>
Message-ID: <alpine.LFD.2.03.1307051225240.18597@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 5 Jul 2013, Will Deacon wrote:

> On Fri, Jul 05, 2013 at 09:44:12AM +0100, Lin Ming wrote:
> > Hi all,
> 
> Hello,
> 
> > I'm porting BSP code from v2.6.36 to v3.10 kernel. It's ARMv7 processor.
> 
> Which specific processor/SoC?
> 
> > But decompressor doesn't work. With a lot of debug, I finally find
> > below 2 commits related.
> > Kernel uncompress OK with these commits reverted.
> > 
> > dbece45: ARM: 7501/1: decompressor: reset ttbcr for VMSA ARMv7 cores
> > (Introduced in v3.6-rc6)
> > 
> > 5010192: ARM: 7583/1: decompressor: Enable unaligned memory access for
> > v6 and above
> > (Introduced in v3.7-rc8)
> > 
> > Any hint to fix it?
> 
> There's not really enough information to go on here. What specifically
> fails? Also, do you have to revert *both* of the above changes to get things
> working again?

Also, what is the bootloader used here?

Does the bootloader call the kernel with the MMU off as documented in 
Documentation/arm/Booting?



Nicolas
