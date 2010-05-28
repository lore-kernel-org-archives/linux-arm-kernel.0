From: skannan@codeaurora.org (Saravana Kannan)
Date: Thu, 27 May 2010 17:41:14 -0700
Subject: [PATCH V2] [ARM] Add ARCH_PROVIDES_UDELAY config option
In-Reply-To: <20100521220653.GL11042@n2100.arm.linux.org.uk>
References: <1272654736-28837-1-git-send-email-ccross@android.com>
	<u2pd73d4eaf1004301237k3ceb859dobe74fe53abec774d@mail.gmail.com>
	<87d3xgd20n.fsf@deeprootsystems.com>
	<20100501100148.GE12172@n2100.arm.linux.org.uk>
	<4BF702CC.5000401@codeaurora.org>
	<20100521220653.GL11042@n2100.arm.linux.org.uk>
Message-ID: <4BFF112A.2060700@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> My point is not specific to sched_clock, but to counters which on ARM
> are 99.9% always memory mapped, and therefore inaccessible during the
> very early kernel boot.  sched_clock was merely an illustration of the
> problem.

Do you know any code which uses udelay that early? I can't imagine any 
non-driver code using udelay. If it's just drivers using udelay, then 
they need IO mapping to have been completed for the device register 
access to work and hence udelay won't have any problems.

-Saravana
