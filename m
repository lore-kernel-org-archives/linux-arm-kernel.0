From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 30 Jun 2014 02:08:43 -0700
Subject: [PATCH 2/2 v2] ARM: KVM: user_mem_abort: support stage 2 MMIO
 page mapping
In-Reply-To: <20140626084625.GA376@arm.com>
References: <1395785294-2545-1-git-send-email-kim.phillips@linaro.org>
 <1395785294-2545-2-git-send-email-kim.phillips@linaro.org>
 <20140506180448.GH3066@lvm>
 <87bnvaotei.fsf@approximate.cambridge.arm.com>
 <20140507145557.GJ3066@lvm> <20140624102327.GA9121@arm.com>
 <53A9556D.3000003@arm.com>
 <20140625194551.a6443252bf913023159d25fd@freescale.com>
 <20140626084625.GA376@arm.com>
Message-ID: <20140630090843.GB9233@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 26, 2014 at 09:46:26AM +0100, Will Deacon wrote:
> On Thu, Jun 26, 2014 at 01:45:51AM +0100, Kim Phillips wrote:
> > From: Kim Phillips <kim.phillips@linaro.org>
> > 
> > A userspace process can map device MMIO memory via VFIO or /dev/mem,
> > e.g., for platform device passthrough support in QEMU.
> > 
> > During early development, we found the PAGE_S2 memory type being used
> > for MMIO mappings.  This patch corrects that by using the more strongly
> > ordered memory type for device MMIO mappings: PAGE_S2_DEVICE.
> > 
> > Signed-off-by: Kim Phillips <kim.phillips@linaro.org>
> > Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
> > ---
> > Hi, here's a v2, upon request:
> > 
> > - rebased onto today's mainline ToT
> > - mmu.o-build tested only (ToT build doesn't complete)
> > - made commit text less terse
> > - added Christoffer's ack
> 
> Thanks for reposting this so quickly!
> 
>   Acked-by: Will Deacon <will.deacon@arm.com>
> 
Thanks,

Marc, will you apply this one to kvmarm/queue [and kvmarm/next]?

-Christoffer
