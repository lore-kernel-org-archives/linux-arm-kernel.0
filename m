From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 29 Apr 2014 12:10:57 +0530
Subject: [PATCH] arm: edma: Fix xbar mapping
In-Reply-To: <20140429060740.GM32284@intel.com>
References: <alpine.DEB.2.02.1404132123100.22697@ionos.tec.linutronix.de>
 <534BED36.2060907@ti.com>
 <alpine.DEB.2.02.1404282032150.6261@ionos.tec.linutronix.de>
 <20140429060740.GM32284@intel.com>
Message-ID: <535F4979.6030507@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 April 2014 11:37 AM, Vinod Koul wrote:
> On Mon, Apr 28, 2014 at 08:32:55PM +0200, Thomas Gleixner wrote:
>> On Mon, 14 Apr 2014, Sekhar Nori wrote:
>>>> Fix the issues by:
>>>>
>>>> - annotating the device tree entry with "/bits/ 16" as documented in
>>>>   the of_property_read_u16_array kernel doc
>>>>
>>>> - make the size of the xbar register mapping correct
>>>>
>>>> - invalidating the end of the array and not the start
>>>>
>>>> This convoluted mess wants to be completely rewritten as there is no
>>>> point to keep the xbar_chan array memory and the iomapping of the xbar
>>>> regs around forever. Marking the xbar mapped channels as used should
>>>> be done right there.
>>>>
>>>> But that's a different issue and this patch is small enough to make it
>>>> work and allows a simple backport for stable.
>>>>
>>>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>>>
>>> This time, I tested this patch and FWIW you can add:
>>>
>>> Acked-by: Sekhar Nori <nsekhar@ti.com>
>>
>> Can someone pick this up please?
> Shouldnt this go thru ARM tree?

I will send a pull request to ARM-SoC.

Thanks,
Sekhar
