From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 29 Jan 2010 20:26:34 +0900
Subject: [PATCH 01/06] ARM: SuperH Mobile ARM, sh7367 and G3EVM support
In-Reply-To: <20100128220835.GA23471@n2100.arm.linux.org.uk>
References: <20100128124028.8982.16123.sendpatchset@rxone.opensource.se>
	<20100128124038.8982.82995.sendpatchset@rxone.opensource.se>
	<20100128220835.GA23471@n2100.arm.linux.org.uk>
Message-ID: <aec7e5c31001290326q76036a49p44fe5a5b31f5cd53@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 29, 2010 at 7:08 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> The entries in this choice menu are sorted by option text - please
> place your new option appropriately to avoid conflicts.

Ok, will make sure it gets sorted properly.

>> +static struct sh_timer_config cmt10_platform_data = {
>> + ? ? .name = "CMT10",
>> + ? ? .channel_offset = 0x10,
>> + ? ? .timer_bit = 0,
>> + ? ? .clk = "r_clk",
>
> I guess you can't do a lot about this because of arch/sh, but over in ARM
> land, we use clkdev to get the clock primerily by the device name rather
> than a string passed around; this is how the clk API is meant to be used.

At this early stage there is not so much to do. When I get around to
implement the clock framework and runtime pm for SuperH Mobile ARM
then I'll have a close look at clkdev.

I'll update and resend these patches next week.

Thanks!

/ magnus
