From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 30 Sep 2011 14:44:56 +0530
Subject: [PATCH 7/8] OMAP4: clock: Add CPU local timer clock node.
In-Reply-To: <alpine.DEB.2.00.1109291308060.26728@utopia.booyaka.com>
References: <1315459327-3285-1-git-send-email-santosh.shilimkar@ti.com>
	<1315459327-3285-8-git-send-email-santosh.shilimkar@ti.com>
	<alpine.DEB.2.00.1109291308060.26728@utopia.booyaka.com>
Message-ID: <CAMQu2gzPyAObKwQ+CUXwseotJShA7Vfwb5AWPLzKPgx=NXjO-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 30, 2011 at 12:42 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi Santosh,
>
> On Thu, 8 Sep 2011, Santosh Shilimkar wrote:
>
>> Local timer clock is sourced from the CPU clock and hence changes
>> along with CPU clock. These per CPU local timers are used as
>> clock-events, so they need to be reconfigured on CPU frequency
>> change as part of CPUfreq governor.
>>
>> Newly introduced clockevents_reconfigure() needs to know the
>> twd clock-rate. Provide a clock-node to make clk_get_rate() work
>> for TWD.
>>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> Cc: Kevin Hilman <khilman@ti.com>
>
> This clock looks like the ARM Cortex-A9 MPCore PERIPHCLK, correct? ?From
> ARM Cortex-A9 MPCore Technical Reference Manual (DDI 0407G) Section 5.1
> "Clocks"?
>
Yes. Peripheral clock/2

> Assuming that is so, I've modified this patch appropriately, and added
> support to the autogeneration script to generate this clock node.
> Care to take a quick look at it to make sure it's okay?
>
Thanks a lot Paul. It looks good.

Regards
Santosh
