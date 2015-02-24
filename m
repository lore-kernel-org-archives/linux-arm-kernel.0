From: dinh.linux@gmail.com (Dinh Nguyen)
Date: Tue, 24 Feb 2015 17:55:05 -0600
Subject: [BUG] ARM: socfpga: L2 cache init
In-Reply-To: <20150217222817.GS8656@n2100.arm.linux.org.uk>
References: <20150206103946.GM15692@pengutronix.de>
 <20150206110557.GY8656@n2100.arm.linux.org.uk>
 <20150209155314.GA7994@pengutronix.de>
 <54D8E3BB.3060505@opensource.altera.com>
 <20150209185820.GB7994@pengutronix.de>
 <20150209213017.GC7994@pengutronix.de>
 <54DD2BB3.3090507@opensource.altera.com>
 <20150213080106.GD7994@pengutronix.de>
 <CADhT+wfbZb+u7a-aCi71rh9xFMuphOvqiyEgEYpmmTQtujLcVg@mail.gmail.com>
 <20150217222817.GS8656@n2100.arm.linux.org.uk>
Message-ID: <CADhT+wcpWcfca6JWLAfpQm_yPHOpTRRbCpiikUEs0ha1NHq3TQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 17, 2015 at 4:28 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Feb 17, 2015 at 04:00:47PM -0600, Dinh Nguyen wrote:
>> On Fri, Feb 13, 2015 at 2:01 AM, Steffen Trumtrar
>> <s.trumtrar@pengutronix.de> wrote:
>> > Yes, seems very likely that Russell is right.
>>
>> The bug doesn't happen if I disable the L2. Digging more...
>
> What ensures that the value written to socfpga_cpu1start_addr (by
> of_property_read_u32() in socfpga_sysmgr_init(), called at .init_irq
> time) is visible to the secondary CPU?

Yes, I was able use a JTAG debugger and can see that the
secondary CPU is not seeing socfpga_cpu1start_addr correctly when the
error occurs.

>
> From what I can see, the physical address written there is not
> guaranteed to be flushed from all levels of cache.
>
> The flush_cache_all() in socfpga_boot_secondary() won't do the job -
> that won't touch the L2C-310.
>

Do you have a recommendation on what should be done?

Thanks,
Dinh
