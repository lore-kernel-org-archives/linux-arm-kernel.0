From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 22 Dec 2010 16:11:54 -0800
Subject: [PATCH v1] davinci: Add additional JTAG code for AM-1808 and
	OMAP-L138 Rev 2.0 SoCs
In-Reply-To: <4D128535.1000807@criticallink.com> (Michael Williamson's message
	of "Wed, 22 Dec 2010 18:09:41 -0500")
References: <1293047363-21353-1-git-send-email-michael.williamson@criticallink.com>
	<87aajxpin1.fsf@deeprootsystems.com>
	<4D128535.1000807@criticallink.com>
Message-ID: <87r5d9l54l.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael Williamson <michael.williamson@criticallink.com> writes:

> On 12/22/2010 05:06 PM, Kevin Hilman wrote:
>> Michael Williamson <michael.williamson@criticallink.com> writes:
>> 
>>> The JTAG variant code for Rev-2.0 silicon of the OMAP-L138 has changed.
>>> In addition, the variant code for the AM-1808 SoC appears to match
>>> the Rev-2.0 code for the OMAP-L138.  Add an additional entry to support
>>> these chips.
>> 
>> Tested on?  
>> 
>> I'm assuming on the Mity platforms, right?
>> 
>
> I tested this using an AM-1808 (456 MHz speedgrade) on a MityARM-1808
> configured SoM.  I don't have a rev-2.0 silicon OMAP-L138 to try, but
> according to the Rev B datasheet the variant will change as described.
> It doesn't break the Rev 1 OMAP-L138 silicon MityDSP-L138F SoM.
>
> There was a thread about this in this list (link below) and I also 
> have some background on an e2e link at TI (link below).  
>
> I had forgotten that I pulled this patch from Sudhakar Rajashekhara on the arago 
> omapl PSP kernel (link to patch below).  It's really his work.
>
> I can resubmit (with tested-by and correct authorship) 

Yes please.  Also add the links to the threads mentioned above.

Thanks,

Kevin

> unless someone at TI
> is prepping the same patch?  I sent it because the AM-1808 fails to boot without
> it.  Thanks.
Y
> -Mike
>
> davinci thread:
> http://linux.davincidsp.com/pipermail/davinci-linux-open-source/2010-November/021224.html
>
> e2e thread:
> http://e2e.ti.com/support/embedded/f/354/p/67290/248486.aspx
>
> arago kernel patch:
> http://arago-project.org/git/projects/?p=linux-omapl1.git;a=commit;h=6157618435e313a444cdf059702bd34036a6e2b7
>
>> Kevin
>> 
>>> Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
>>> ---
>>> This is against davinci-linux tree.
>>> Changes since v0, removed whitespace fixups not related to patch.
>>>
>>>  arch/arm/mach-davinci/da850.c |    7 +++++++
>>>  1 files changed, 7 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
>>> index 78b5ae2..2d0bba5 100644
>>> --- a/arch/arm/mach-davinci/da850.c
>>> +++ b/arch/arm/mach-davinci/da850.c
>>> @@ -764,6 +764,13 @@ static struct davinci_id da850_ids[] = {
>>>  		.cpu_id		= DAVINCI_CPU_ID_DA850,
>>>  		.name		= "da850/omap-l138",
>>>  	},
>>> +	{
>>> +		.variant	= 0x1,
>>> +		.part_no	= 0xb7d1,
>>> +		.manufacturer	= 0x017,	/* 0x02f >> 1 */
>>> +		.cpu_id		= DAVINCI_CPU_ID_DA850,
>>> +		.name		= "da850/omap-l138/am18xx",
>>> +	},
>>>  };
>>>  
>>>  static struct davinci_timer_instance da850_timer_instance[4] = {
