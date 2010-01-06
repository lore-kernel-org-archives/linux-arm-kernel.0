From: svenkatr@ti.com (Venkatraman S)
Date: Wed, 6 Jan 2010 20:15:07 +0530
Subject: [Patch v4] OMAP: sDMA driver: descriptor autoloading feature
In-Reply-To: <4B448D11.5060400@nokia.com>
References: <618f0c910912110701p771dcf6fg655bb0a7b9bdc96d@mail.gmail.com>
	<20091228214846.GP3512@atomide.com>
	<618f0c911001032303p5d103f3et6271a71e1e5fbc96@mail.gmail.com>
	<4B448D11.5060400@nokia.com>
Message-ID: <618f0c911001060645g4580a83je653fcdb3d0f2e7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 6, 2010 at 6:46 PM, Adrian Hunter <adrian.hunter@nokia.com> wrote:
> Venkatraman S wrote:
>>
>> On Tue, Dec 29, 2009 at 3:18 AM, Tony Lindgren <tony@atomide.com> wrote:
>>>
>>> * Venkatraman S <svenkatr@ti.com> [091211 07:01]:
>>>>
>>>> Here is the most updated version of the patch (thanks to Russell's
>>>> review). This patch is applicable to OMAP4xxx as well as OMAP3630
>>>> Reference to previous posts
>>>> v1 ?http://marc.info/?l=linux-omap&m=125012097403050&w=2
>>>> v2 ?http://marc.info/?l=linux-omap&m=125137152606644&w=2
>>>> v3 ?http://patchwork.kernel.org/patch/45408/
>>>
>>> Do you have a patch for drivers/mmc/host/omap_hsmmc.c to
>>> use this feature? Or some other driver?
>>>
>>> Regards,
>>>
>>> Tony
>>
>> I am about to start working on omap_hsmmc to use the descriptor load
>> feature. If the DMA changes are acceptable, I can post the driver
>> patch as well.
>
> I presume this is about performance. ?How does it compare to chained DMA?
> We have a patch for omap_hsmmc for chained DMA that we are still testing.
>
 The main difference would be the number of logical channels used.
With chaining, I assume you'd request for (or the API internally
reserves) as many logical channels as there are segments. Here a
single logical channel would do.
