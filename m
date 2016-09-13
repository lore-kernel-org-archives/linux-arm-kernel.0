From: fu.wei@linaro.org (Fu Wei)
Date: Tue, 13 Sep 2016 17:22:42 +0800
Subject: [PATCH v11 5/8] clocksource/drivers/arm_arch_timer: Simplify ACPI
 support code.
In-Reply-To: <CADyBb7uX79UP=mUxvP-EPGi56-46y2SCMPsWO=Uw-=N0GQERhA@mail.gmail.com>
References: <1473168352-5156-1-git-send-email-fu.wei@linaro.org>
 <1473168352-5156-6-git-send-email-fu.wei@linaro.org>
 <alpine.DEB.2.20.1609061635000.5647@nanos>
 <CADyBb7uX79UP=mUxvP-EPGi56-46y2SCMPsWO=Uw-=N0GQERhA@mail.gmail.com>
Message-ID: <CADyBb7v-b1bKGBdH6J78UhfCcQd=BJLFoZ16GNgmrd2EucjYDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas, Daniel,

For these  arm_arch_timer patches, do you have any other suggestion or comment?
I have deleted "skipping" in the error message.

I have prepared v12 (rebase to rc6 and on the top of IORT v11),
should I send it now (if you are OK with my arm_arch_timer patches ),
or anything I can do to improve this patchset ?

Thanks.

On 7 September 2016 at 17:23, Fu Wei <fu.wei@linaro.org> wrote:
> Hi Thomas
>
> On 6 September 2016 at 22:36, Thomas Gleixner <tglx@linutronix.de> wrote:
>> On Tue, 6 Sep 2016, fu.wei at linaro.org wrote:
>>> +     if (timer_count < 0)
>>> +             pr_err("Failed to get platform timer info, skipping.\n");
>>
>> So this prints something about skipping. But then it continues as if
>> nothing went wrong. That's either wrong or confusing or both.
>
> yes, you are right, this info is confusing.
> maybe we just delete the "skipping" ?
>
> ?timer_count < 0? is caused by some firmware bug, in gtdt.c:
> ----
> int __init acpi_gtdt_init(struct acpi_table_header *table)
> {
> ......
>         if (start < (void *)table + sizeof(struct acpi_table_gtdt)) {
>         pr_err(FW_BUG "Failed to retrieve timer info from firmware:
> invalid data.\n");
>         return -EINVAL;
> ......
> }
> ----
>
> But in this situation( without platform timers ), system still can work.
> So I thing we just need to print a error.
>
>>
>>> -     arch_timer_init();
>>> -     return 0;
>>> +     return arch_timer_init();
>>
>> Thanks,
>>
>>         tglx
>
>
>
> --
> Best regards,
>
> Fu Wei
> Software Engineer
> Red Hat



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
