From: swetland@google.com (Brian Swetland)
Date: Mon, 16 Nov 2009 08:43:20 -0800
Subject: [PATCH 2/3] msm: add minimal board file for HTC Dream device
In-Reply-To: <20091116163659.GB3568@n2100.arm.linux.org.uk>
References: <20091102104949.GA23456@elf.ucw.cz>
	<20091116163659.GB3568@n2100.arm.linux.org.uk>
Message-ID: <a55d774e0911160843h22938604s8966a58ee71992a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2009 at 8:36 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Nov 02, 2009 at 11:49:49AM +0100, Pavel Machek wrote:
>> +MACHINE_START(TROUT, "HTC Dream")
>> +#ifdef CONFIG_MSM_DEBUG_UART
>> + ? ? .phys_io ? ? ? ?= MSM_DEBUG_UART_PHYS,
>> + ? ? .io_pg_offst ? ?= ((MSM_DEBUG_UART_BASE) >> 18) & 0xfffc,
>> +#endif
>
> Why is this ifdef'd? ?Two reasons why not to do this:
>
> 1. MSM_DEBUG_UART is always defined, so the conditional is pointless

For a default dream build, definitely, but not always on every msm7k
target (some devices may not have a serial port that can safely be
chattered at by the debug code).  For this board file, no harm to
require it.

> 2. the low level page table building code does not expect these to be
> ? unset (or even set to an invalid value). ?Leaving them unset and
> ? having DEBUG_LL enabled is a recipe to prevent booting.

What's the best way to handle a situation where there is no valid
debug uart?  Could the arch/platform require DEBUG_LL be unset via
Kconfig directives if it is configured in a way where there is no
valid debug uart?

> To put it another way, these two fields aren't optional.
>

Thanks,

Brian
