From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 04 May 2011 18:17:30 -0700
Subject: [RFC PATCH 08/12] ARM: msm: use remapped PPI interrupts for	local
	timer
In-Reply-To: <4DC19EC3.2070702@codeaurora.org>
References: <1303326501-15664-1-git-send-email-marc.zyngier@arm.com>	<1303326501-15664-9-git-send-email-marc.zyngier@arm.com>	<4DB6FD50.9070907@codeaurora.org>	<20110503190422.GA14176@n2100.arm.linux.org.uk>
	<4DC0E886.3010709@codeaurora.org> <4DC19EC3.2070702@codeaurora.org>
Message-ID: <4DC1FAAA.1040306@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/04/2011 11:45 AM, Jeff Ohlstein wrote:
> This won't work right with the maxcpus commandline option set to
> something lower than the number of cpus present on the system. This
> option controls how many cpus the system tries to bring up during boot,
> while still allowing one to hotplug the rest of them later. If you do
> hotplug them later, system_state will no longer be SYSTEM_BOOTING, and
> this code won't do what it needs to do.
>

Hmm the documentation isn't very clear there. I see in
Documentation/cpu-hotplug.txt that maxcpus=n means:

             Restrict boot time cpus to n. Say if you have 4 cpus, using
             maxcpus=2 will only boot 2. You can choose to bring the
             other cpus later online, read FAQ's for more info.

and then Documentation/kernel-parameters.txt says:

             [SMP] Maximum number of processors that an SMP kernel
             should make use of.  maxcpus=n : n >= 0 limits the
             kernel to using 'n' processors.  n=0 is a special case,
             it is equivalent to "nosmp", which also disables
             the IO APIC.

which doesn't agree. That should be reconciled.
