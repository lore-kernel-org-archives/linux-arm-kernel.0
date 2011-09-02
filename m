From: b-cousson@ti.com (Cousson, Benoit)
Date: Fri, 2 Sep 2011 13:43:48 +0200
Subject: [PATCH 6/7] OMAP3: board-dt: Add generic board file for DT support
In-Reply-To: <20110902104330.GR3548@atomide.com>
References: <1314897912-18178-1-git-send-email-b-cousson@ti.com>
	<1314897912-18178-7-git-send-email-b-cousson@ti.com>
	<20110902080944.GP3548@atomide.com> <4E609800.9090402@ti.com>
	<20110902104330.GR3548@atomide.com>
Message-ID: <4E60C174.50604@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/2/2011 12:43 PM, Tony Lindgren wrote:
> * Cousson, Benoit<b-cousson@ti.com>  [110902 11:13]:
>> Hi Tony,
>>
>> On 9/2/2011 10:09 AM, Tony Lindgren wrote:
>>> Hi,
>>>
>>> * Benoit Cousson<b-cousson@ti.com>   [110901 19:52]:
>>>> Create an OMAP3 generic board to start the DT migration.
>>>
>>> I don't think this needs to be SoC specific, we can add multiple
>>> DT_MACHINE_START entries into a single file. So it should be
>>> just board-omap-dt.c.
>>
>> I do agree, it should not, I made that comment into the
>> board-omap4-dt.c, but for the moment we still have dedicated OMAP
>> specifics stuff at board level, like the map_io.
> 
> Well map_io can also be set in DT_MACHINE_START. For most part
> it already is generic like omap3_map_io and omap4_map_io.
> So that should not stop anything.

OK, I think I was trying to be a little bit more extreme, meaning only one omap_map_io for every OMAPs.
Then, inside omap_map_io we can use the DT compatible information to retrieve the proper OMAPs revision and thus use the proper init table.

Whereas in your case you are still relying on the various DT_MACHINE entries to detect which OMAP revision is used.

It looks to me that relying on several DT_MACHINE_START to identify a SoC version is a little bit more a hack. 
I will let the device-tree experts answering that question :-)
For my point of view, using DT compatible in the various place where the OMAP revision is important, might allow a finer granularity.

>> I have an other series that make the map_io DT aware to get rid of
>> that, but it still not finalized.
> 
> Hmm maybe take a look again? We've already sorted out quite a bit
> of the init stuff over past few merge windows. If there's still
> something blocking that, let's clear it out ASAP.

Now that I understand your approach, it is fine. Please find below an example of what I was trying to achieve, and why that point was an issue.
The clear advantage of your method is that not further effort will be require for this part. At least for the moment.

>> My goal was have a single DT_MACHINE_START for every OMAPs.
>> But, meanwhile, if you prefer one file with many board descriptors,
>> that's fine.
> 
> Yes that's better. We should only need a separate DT_MACHINE_START
> for major SoC variants.

OK, I'll try that.

Thanks,
Benoit

---
