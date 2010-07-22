From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Thu, 22 Jul 2010 09:57:36 +0900
Subject: [PATCH v3 1/7] ARM: S5PV210: Add a Kconfig entry
	"S5PC110_EVT0_WORKAROUND"
In-Reply-To: <4C46DE37.5060105@simtec.co.uk>
References: <1279517483-22751-1-git-send-email-myungjoo.ham@samsung.com>
	<1279517483-22751-2-git-send-email-myungjoo.ham@samsung.com>
	<4C464127.5040405@simtec.co.uk>
	<AANLkTikaUugKaDFCHW234eWLPn7KnV-wudeNY2-KwWR0@mail.gmail.com>
	<4C46DE37.5060105@simtec.co.uk>
Message-ID: <AANLkTinV8lnFUd5aD5gQSZ9MauUq1LW8PCamZVo03B-m@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 21, 2010 at 8:47 PM, Ben Dooks <ben@simtec.co.uk> wrote:
> On 21/07/10 02:13, MyungJoo Ham wrote:
>> On Wed, Jul 21, 2010 at 9:36 AM, Ben Dooks <ben@simtec.co.uk> wrote:
>>> On 07/19/10 06:31, MyungJoo Ham wrote:
>>>>
>>>> Early S5PC110 (EVT0) chip had some issues required workaround from a
>>>> kernel. We can add such workaround codes with this Kconfig entry.
>>>>
>>>> Signed-off-by: MyungJoo Ham<myungjoo.ham@samsung.com>
>>>> Signed-off-by: Kyungmin Park<kyungmin.park@samsung.com>
>>>> ---
>>>> ?arch/arm/mach-s5pv210/Kconfig | ? ?7 +++++++
>>>> ?1 files changed, 7 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
>>>> index 631019a..18802e7 100644
>>>> --- a/arch/arm/mach-s5pv210/Kconfig
>>>> +++ b/arch/arm/mach-s5pv210/Kconfig
>>>> @@ -101,4 +101,11 @@ config MACH_SMDKC110
>>>> ? ? ? ? ?Machine support for Samsung SMDKC110
>>>> ? ? ? ? ?S5PC110(MCP) is one of package option of S5PV210
>>>>
>>>> +config S5PC110_EVT0_WORKAROUND
>>>> + ? ? ? bool "S5PC110 Early Chip Workaround (EVT0)"
>>>> + ? ? ? help
>>>> + ? ? ? ? Early S5PC110 (so called EVT0) has errata items that should be
>>>> + ? ? ? ? addressed; otherwise the kernel may panic or be locked up.
>>>> Enable
>>>> + ? ? ? ? this option to execute workaround instructions.
>>>> +
>>>> ?endif
>>>
>>> What happens for non EVT0, is the a performance issue or is it exclusive?
>>>
>>
>> This S5PC110_EVT0_WORKAROUND addresses issues (erratic behaviors, not
>> performance issues) of "EVT-0" revisions, which is exclusive for these
>> EVT-0 only. They do not apply to the later (EVT-1 and so on) chips.
>
> Ok, so does the fix work for just EVT0? Does it exclude supporting other
> EVT sillicon as well?

Yes, it works only for EVT0, not for EVT1 or later revisions. When
it's enabled, it does not support EVT1 or others.

However, in the next revision of patches, the EVT determination is
done at run-time, not at compile-time.

>
> --
> Ben
>
>
>
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
