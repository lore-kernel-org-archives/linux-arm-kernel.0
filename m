From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 May 2010 23:06:53 +0100
Subject: [PATCH V2] [ARM] Add ARCH_PROVIDES_UDELAY config option
In-Reply-To: <4BF702CC.5000401@codeaurora.org>
References: <1272654736-28837-1-git-send-email-ccross@android.com>
	<u2pd73d4eaf1004301237k3ceb859dobe74fe53abec774d@mail.gmail.com>
	<87d3xgd20n.fsf@deeprootsystems.com>
	<20100501100148.GE12172@n2100.arm.linux.org.uk>
	<4BF702CC.5000401@codeaurora.org>
Message-ID: <20100521220653.GL11042@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 21, 2010 at 03:01:48PM -0700, Saravana Kannan wrote:
> Russell King - ARM Linux wrote:
>> We may be running into the same problem which we did with the printk
>> clock - that is using a machine provided sched_clock() or clocksource
>> requires MMIO accesses, which can only be done after the IO mappings
>> have been initialized.
>>
>> Let's hope no one ever uses udelay() before the necessary IO mappings
>> are present.
>
> Is the patch that uses CONFIG_ARCH_PROVIDES_UDELAY acceptable? I don't  
> care much for how each arch decides to implement it, but I think we  
> should have this config to let each arch decide how they want to handle  
> udelay.
>
> I personally prefer not to use the sched clock source due to the  
> unnecessary complexities. If you have a some kind of constant counter,  
> it sounds much simpler to just use it instead of adding dependencies  
> between udelay and sched clock.

My point is not specific to sched_clock, but to counters which on ARM
are 99.9% always memory mapped, and therefore inaccessible during the
very early kernel boot.  sched_clock was merely an illustration of the
problem.
