From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Tue, 19 Apr 2011 11:52:21 +0900
Subject: Cleanup Samsung stuff
In-Reply-To: <BANLkTimTuQ1YE8Xu04NyMZxF42KGDr_XBQ@mail.gmail.com>
References: <012801cbfe33$a76fa490$f64eedb0$%kim@samsung.com>
	<BANLkTimTuQ1YE8Xu04NyMZxF42KGDr_XBQ@mail.gmail.com>
Message-ID: <BANLkTi=3JOn4sc0_tXM1mROdTU0-Uwq_-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everyone,

Anyway, I've got a quick question about the directory structure in arch/arm/*

Is there any reason not to keep mach-* in plat-* directories while
mach-* appears to be a "sub-categories" of plat-*?

For example, rather than the current structure:
arch/arm/plat-samsung/
arch/arm/mach-s5pv210/
arch/arm/mach-s5p****/
, why don't we structure them like:
arch/arm/plat-samsung/mach-s5pv210/
arch/arm/plat-samsung/mach-s5p****/

For mach-* that is not included in and does not use any plat-*, we may
make "arch/arm/plat-common" or just put them at arch/arm/.

Probably there could be discussions like this (likely), but I just
don't know why we are not structured like that. If it is because we
have some mach-* that use multiple plat-*, (multiple inheritance?) we
may be able to move on with this consolidation.



Cheers!

- MyungJoo

2011/4/19 Kyungmin Park <kmpark@infradead.org>:
> On Tue, Apr 19, 2011 at 10:46 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
>> Hi all,
>>
>> I think, you know about current situation of Linux ARM world.
>>
>> So...
>>
>> As Russell suggested, I also will focus on consolidations and bug fixes for
>> Samsung stuff for a while so don't complain about missing new stuff. In my
>> opinion, we can keep going it later...
>>
>> As a note, I'm doing(or preparing) following at the moment.
>>
>> - Removing some "mach-s5pxxxx"s
> Why not mach-s3c series? don't you think too much plat-{s3c, s5p,
> samsung}? how about to use the plat-samsung only?
>> - Removing useless header files in include/{mach,plat} of Samsung
>> - Samsung GPIO stuff cleanup/consolidation
>> - Samsung DMA stuff consolidation?
> ? -> Move to dmaengine and use it.
>> - Device tree (with Linaro)
>> - and so on...
>
> ? - Strange Samsung Clock and names consolidation.
> ? - IRQ stuff (some parts are done by tglx but need to use the
> generic IRQ base instead of odd +32 magic)
> ? - generic IOMMU consolidation.
>
> BTW, who works on this at LSI?
>
> Thank you,
> Kyungmin Park
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



-- 
MyungJoo Ham (???), Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
