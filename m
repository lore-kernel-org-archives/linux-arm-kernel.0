From: vigneshr@ti.com (Vignesh R)
Date: Mon, 17 Nov 2014 09:57:05 +0530
Subject: [PATCH v4 2/6] input: touchscreen: ti_am335x_tsc: Remove udelay
 in interrupt handler
In-Reply-To: <20141115192739.GA18766@localhost.localdomain>
References: <1415941651-28962-1-git-send-email-vigneshr@ti.com>
 <1415941651-28962-3-git-send-email-vigneshr@ti.com>
 <20141115192739.GA18766@localhost.localdomain>
Message-ID: <54697919.5030302@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Sunday 16 November 2014 12:57 AM, Richard Cochran wrote:
> On Fri, Nov 14, 2014 at 10:37:27AM +0530, Vignesh R wrote:
>> From: Brad Griffis <bgriffis@ti.com>
>>
>> TSC interrupt handler had udelay to avoid reporting of false pen-up
>> interrupt to user space. This patch implements workaround suggesting in
>> Advisory 1.0.31 of silicon errata for am335x, thus eliminating udelay
>> and touchscreen lag. This also improves performance of touchscreen and
>> eliminates sudden jump of cursor at touch release.
> 
> I back ported this series onto v3.15.1 in order to try this out on a
> custom, beaglebone-like board. With this series, the touch is really
> broken. (I had fixed the pen up problem in a totally different way for
> a customer, and so I wanted to try out your solution.)
> 
> I will try to port the board code to a more recent kernel to try your
> series again. With which kernel version did you test your patches?
> 
> And which board?
> 
Thanks for testing these patches.

My patches are based on v3.18rc2. I tested my patches on am335x-evm
using tslib.
If you are encountering false pen-ups, charge-delay parameter needs to
be tuned to your board. In some custom setups charge-delay of 0xB000
provided better performance.
If you are using ts_test (from tslib) for testing try
# ts_test > /dev/null
for better performance.

Please explain "touch is broken"? What is the behaviour of TSC?
Which ADC channels are being used for TSC?

Regards
Vignesh

> Thanks,
> Richard
> 
> 
