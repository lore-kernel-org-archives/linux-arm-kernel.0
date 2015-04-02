From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 02 Apr 2015 17:35:39 +0200
Subject: [PATCH] ARM: mvebu: use 0xf1000000 as internal registers on Armada
 370 DB
In-Reply-To: <20150402161626.182e267d@free-electrons.com>
References: <1427966184-8288-1-git-send-email-thomas.petazzoni@free-electrons.com>	<2321040.CmsL1gluUd@wuerfel>	<20150402153650.2cc9c3d7@free-electrons.com>	<2515980.d69ggAvHPo@wuerfel>
 <20150402161626.182e267d@free-electrons.com>
Message-ID: <551D61CB.6000008@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 02/04/2015 16:16, Thomas Petazzoni wrote:
> Arnd,
> 
> On Thu, 02 Apr 2015 16:09:03 +0200, Arnd Bergmann wrote:
> 
>> This device has 1GB, doing an incompatible change to an existing machine
>> is completely moronic. How hard can it be to special-case this board
>> in u-boot?
> 
> The device has a DIMM slot for RAM. 1 GB in the DT is just an example,
> and it gets updated through ATAGS, or directly by the bootloader with
> the real amount of RAM that you have, which can go up to 4 GB.
> 
>>> Also, the proposed change is exactly the same we've done on several
>>> Marvell evaluation boards in the past:
>>>
>>>   http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/arch/arm/boot/dts/armada-xp-gp.dts?id=91ed32200e6ea1df19df01355c5c7747f9014102
>>>   http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/arch/arm/boot/dts/armada-xp-db.dts?id=82066bdb5a759ec00c18f9667853c4fe8840e83d
>>
>> I'm aware of those, I just wish they would learn from their mistakes.
> 
> There was no mistake at all. You have no idea what the history of this
> problem is, and you're giving lessons.
> 
> As Andrew Lunn said, on *all* Marvell EBU platforms the internal
> registers have always been remapped at 0xf1000000. Look at Kirkwood,
> Orion, Dove.
> 
> Marvell wanted to do exactly the same for Armada 370 and XP, which is
> perfectly sane: keep the same behavior.
> 
> Except that the very early steppings of Armada 370 and Armada XP had a
> bug, which prevented from changing the internal register base address,
> so they had no other choice but to keep it at 0xd0000000. And then,
> once those early steppings were replaced by real production steppings,
> the bug was fixed, and they migrated to 0xf1000000, and the situation
> was back to normal.

As Andrew and Jason seem also agree with this patch, I would like to apply
on it on the mvebu tree. However there is no point to do it if at the end
you won't take it. Given the new information given by Thomas, do you agree
with this patch?

Thanks,

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
