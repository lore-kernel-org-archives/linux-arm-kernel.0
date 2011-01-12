From: robherring2@gmail.com (Rob Herring)
Date: Wed, 12 Jan 2011 15:28:14 -0600
Subject: [PATCH v2 3/3] ARM: twd_smp: add clock api support
In-Reply-To: <20101221134515.GB1556@n2100.arm.linux.org.uk>
References: <1286030086-25556-1-git-send-email-robherring2@gmail.com>
	<1286030086-25556-4-git-send-email-robherring2@gmail.com>
	<20101221134515.GB1556@n2100.arm.linux.org.uk>
Message-ID: <4D2E1CEE.5040900@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On 12/21/2010 07:45 AM, Russell King - ARM Linux wrote:
> On Sat, Oct 02, 2010 at 09:34:46AM -0500, Rob Herring wrote:
>> From: Rob Herring<rob.herring@smooth-stone.com>
>>
>> The private timer freq is currently dynamically detected
>> using jiffies count to determine the rate. This method adds
>> a delay to boot-up, so use the clock api instead to get the
>> clock rate.
> More or less the same comments go for this as well as the timer-sp code.

I've implemented your requested changes for timer-sp code. The problem 
with doing the same thing with smp_twd timer is I don't know what the 
frequency of the timer is on various platforms or an understanding of 
what their clock trees look like to do a proper implementation of the 
clocks. I could make calling twd_timer_init mandatory and replace direct 
setting of twd_base, but it would still fall back to calculating the 
rate if no clock found. These are the current users:

mach-omap2/timer-gp.c
mach-realview/realview_eb.c
mach-realview/realview_pb11mp.c
mach-realview/realview_pbx.c
mach-s5pv310/time.c
mach-shmobile/smp-sh73a0.c
mach-tegra/timer.c
mach-ux500/cpu.c
mach-vexpress/ct-ca9x4.c

Rob
