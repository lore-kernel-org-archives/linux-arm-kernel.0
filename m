From: balajitk@ti.com (Balaji T K)
Date: Fri, 11 Oct 2013 21:13:35 +0530
Subject: [PATCH 4/6] pinctrl: single: Add support for wake-up interrupts
In-Reply-To: <20131011153654.GN29913@atomide.com>
References: <20131003054104.8941.88857.stgit@localhost>
 <20131003054221.8941.87801.stgit@localhost> <5256AA7F.8030005@ti.com>
 <20131010160018.GA29913@atomide.com>
 <CACRpkdaG-PQA39XSjKUgM9TyeD7srgm_8s+NazrDKJ0gmNLcwg@mail.gmail.com>
 <20131010162015.GC29913@atomide.com>
 <CACRpkdYF83ghUf60Wmrti53UJ1bWV30GW_P9GjWnsOcZHbsv+Q@mail.gmail.com>
 <5257BD3E.5000707@ti.com> <20131011153654.GN29913@atomide.com>
Message-ID: <52581CA7.20606@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 October 2013 09:06 PM, Tony Lindgren wrote:
>>> What the pin control driver should do is control the pins. Whether the registers
>>> are spread out in the entire IO-memory does not matter. We did have one system
>>> which placed the IO-muxing together with each peripheral (!) and I did
>>> still want
>>> that to be handled by a single pinctrl driver picking out windows to all these
>>> IO-ranges.
>>>
>>> Things like the PRM which has (my guess) a gazillion registers related to its
>>> deep-core SoC stuff should be handled by things like
>>> drivers/mfd/syscon.c, which means it is dead simple for some other driver
>>> using "just this one register" in that range to get a handle at it and poke it
>>> using syscon_node_to_regmap() (just derference an ampersand ref)
>>> syscon_regmap_lookup_by_compatible() (use a compatible string)
>>> all returning a regmap * that you can use to poke these registers.
>>
>> The register handling is fine. But how do we deal with resource handling?
>> e.g. the block that has the deep-core registers might need to be clocked or powered
>> before the registers can be accessed.
>
> Right, that's the key issue here. The register access would have to be conditional
> based on the hardware modules PM state. Otherwise we'll have hard to trace hangs
> and oopses.
>
Hi Tony,

How are the clocks/power state currently handled in case of omap4_pmx_core,
omap4_pmx_wkup register access via pinctrl-single ?

Thanks and Regards,
Balaji T K
