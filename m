From: khilman@ti.com (Kevin Hilman)
Date: Tue, 14 Feb 2012 14:59:33 -0800
Subject: [PATCH 6/6] arm: omap: pm-debug: enhanced usecount debug support
In-Reply-To: <20120214202740.GT1426@atomide.com> (Tony Lindgren's message of
 "Tue, 14 Feb 2012 12:27:40 -0800")
References: <1329237402-26008-1-git-send-email-t-kristo@ti.com>
 <1329237402-26008-7-git-send-email-t-kristo@ti.com>
 <20120214202740.GT1426@atomide.com>
Message-ID: <87fwed58dm.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> * Tero Kristo <t-kristo@ti.com> [120214 08:19]:
>> Voltdm, pwrdm, clkdm, hwmod and clk usecounts are now separeted to
>> their own file, 'usecount'. This file shows the usecounts for every
>> active domain and their children recursively. 'count' file now only
>> shows power state counts for powerdomains.
>> 
>> This patch also provices a way to do printk dumps from kernel code,
>> by calling the pm_dbg_dump_X functions. The plan is to call these
>> functions once an error condition is detected, e.g. failed suspend.
>
> Why don't you replace this all with a userspace tool that deciphers
> the registers for you?

This patch isn't deciphering registers, it's just dumping usecounts, and
I think that is extremely useful to have in debugfs.

I've already removed all the register dumping from the kernel in the
hopes that someone will write a userspace tool for that.

Kevin
