From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 06 Jan 2014 11:10:41 +0100
Subject: [PATCH v2 1/2] ARM: mvebu: Add support to get the ID and the
 revision of a SoC
In-Reply-To: <52CA7D87.9070606@free-electrons.com>
References: <1388743185-24822-1-git-send-email-gregory.clement@free-electrons.com>
 <1388743185-24822-2-git-send-email-gregory.clement@free-electrons.com>
 <201401051525.52459.arnd@arndb.de> <20140105154023.GA2048@lunn.ch>
 <20140105172756.GA11280@obsidianresearch.com> <52C99851.70806@gmail.com>
 <20140105230746.GB11280@obsidianresearch.com> <52C9E6D0.3000406@gmail.com>
 <20140105234009.GC11280@obsidianresearch.com> <52C9F32D.5080007@gmail.com>
 <20140106001709.GD4093@lunn.ch> <52CA7D87.9070606@free-electrons.com>
Message-ID: <52CA8121.2020105@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/2014 10:55, Gregory CLEMENT wrote:
> Hi Andrew,
> 
> On 06/01/2014 01:17, Andrew Lunn wrote:
>>>>> Does that power down really disable reading from PCIe controller
>>>>> registers or is it just PHY power down?
>>>>
>>>> I haven't experimented with it, but every block that has a clock gate
>>>> has a power down, so I doubt it is just a phy power down.
>>>
>>> Ok, I see. But it isn't documented in the public FS, is it? If there is
>>> an extra powerdown register for each ip block, I guess it will also
>>> break reading from its registers.
>>
>> Hi Sebastian
>>
>> The public Kirkwood FS has a memory power management control register,
>> Offset 0x20118. It is unclear what it actually does, and if you can
>> still access registers when it is off. We would have to poke it and
>> see.
> 
> Interesting, this registers is mentioned under the section "Core Clock
> Power Saving" in the kirkwood datasheet, so maybe we should add this
> register to the gating clock
> 
> I found similar registers for Armada XP/370, I am going to test what happen
> if the PCxy  Memory Power Down are down.

So I have just put all the  Memory Power Down for all the PCIe
slot and I still managed to read the ID so it won't be an issue
(at least on Armada XP)

> 
> 
> Thanks,
> 
> Gregory
> 
> 
> 
>>
>> 	Andrew
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
