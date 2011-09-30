From: will.deacon@arm.com (Will Deacon)
Date: Fri, 30 Sep 2011 10:38:19 +0100
Subject: [PATCH] arm: proc-v7: pc phy addresses before disable MMU
In-Reply-To: <4E858D0E.3000104@stericsson.com>
References: <1316851370-7284-1-git-send-email-per.forlin@stericsson.com>
	<20110924081342.GA2639@mwesterb-mobl.ger.corp.intel.com>
	<4E7DA3C0.7000208@stericsson.com>
	<20110924110024.GA20044@e102144-lin.cambridge.arm.com>
	<4E7DD34E.3060402@stericsson.com>
	<20110924130202.GF17169@n2100.arm.linux.org.uk>
	<4E8555A5.9090304@stericsson.com>
	<20110930083445.GA3895@e102144-lin.cambridge.arm.com>
	<4E858D0E.3000104@stericsson.com>
Message-ID: <20110930093819.GD3895@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 30, 2011 at 10:34:06AM +0100, Per F?rlin wrote:
> On 09/30/2011 10:34 AM, Will Deacon wrote:
> > I'm not sure why all of this is necessary. Take a look at my kexec patches
> > here:
> > 
> > http://www.linux-arm.org/git?p=linux-2.6-wd.git;a=shortlog;h=refs/heads/kexec-mmu-off
> > 
> > The interesting bit is __arm_machine_reset in kernel/process.c
> > 
> /* Switch to the identity mapping. */
> phys_reset = (phys_reset_t)virt_to_phys(cpu_reset);
> phys_reset(reset_args->reset_code_phys);
> Yes this is definitely how it should be done. My mind was stuck in the assembler code.

Easy mistake to make!

> If I get this right the bug I run into is already fixed by your kexec patches. I could simply use your patches?

Sure, I reworked them the other day so I'll post them to the list again
soon. There are still some open problems to solve but the reset code is
more-or-less there.

Will
