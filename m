From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 31 Dec 2010 13:46:00 +0800
Subject: [PATCH 15/23] Alternative mmc structure to support pxa168,
	pxa910, mmp2 family SD
In-Reply-To: <037EAE31-B07C-4134-B810-A5A1E83517B8@marvell.com>
References: <22DA8CC3-8CB2-4EEE-AAD8-8599BD589CCE@marvell.com>
	<201012221510.36878.arnd@arndb.de>
	<037EAE31-B07C-4134-B810-A5A1E83517B8@marvell.com>
Message-ID: <AANLkTikmZ=c8LnOwxLqx9w6cXV07eVL7AZ0qQmXKojs9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 23, 2010 at 6:58 AM, Philip Rakity <prakity@marvell.com> wrote:
>
> On Dec 22, 2010, at 6:10 AM, Arnd Bergmann wrote:
>
>> On Wednesday 22 December 2010 08:09:58 Philip Rakity wrote:
>>> The PXA168, PXA910, and MMP2 are not the same SOC. ?The family
>>> of embedded processors have slightly different internal blocks
>>> for SD, I2C, etc. ?Sometimes it is important to know which SOC
>>> is being used due to differences in the silicon. ?Sometimes it
>>> is important to know evaluation boards should be selected based
>>> on the SOC on the board.
>>
>> This looks like you're moving in the wrong direction.
>>
>> If the chips are just slightly different, you'd certainly
>> want to make sure that you can detect the difference at runtime,
>> and be able to use the same kernel on all of the variants.
>
> MMP2 used PJ4 core --- PXA168/PXA910 use PJ1 so rather different architecture.
>
> PXA168/PXA910 have slightly different internal peripherals with different quirks.
> Certainly possible to tell this apart at runtime but not all peripherals are the same
> and startup files ARE different.
>
>
MMP2 and PJ4 are different SoC silicons. But they're using similar SD
IP, so we can share same driver to them. Different quirks can be
handled by different flags in run time.

There's no reason to copy driver for each silicon.

>>
>> Instead, you promote each of the SOCs to a top-level family
>> in this patch, which makes it impossible to build a kernel
>> for more than one of them at a time.
>
> That was the intent to handle the case of development board selection.
> it is meaningless to select MMP2 development board with say PXA168 SoC.
>
> Open to other way to handle this problem. ?Suggestions welcome.
>
Again, you did wrong. You couldn't make patch for top-level family. It
will introduce a lot of error to maintainers.

Your patches will make them mess.

Thanks
Haojian

>>
>> ? ? ? Arnd
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
