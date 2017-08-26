From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Sat, 26 Aug 2017 09:00:03 +0800
Subject: [PATCH v11 1/6] ACPI: add APEI/HEST/CPER structures and macros
In-Reply-To: <69090a96-ce90-4b2b-a419-c8d847d56093@huawei.com>
References: <1503066227-18251-1-git-send-email-gengdongjiu@huawei.com>
 <1503066227-18251-2-git-send-email-gengdongjiu@huawei.com>
 <599EC7AB.3080604@huawei.com>
 <69090a96-ce90-4b2b-a419-c8d847d56093@huawei.com>
Message-ID: <59A0C813.2060201@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2017/8/25 18:37, gengdongjiu wrote:
>>> +
>>> >> +/* From the ACPI 6.1 spec, "18.3.2.9 Hardware Error Notification" */
>>> >> +
>> > It's better to refer to the first spec version of this structure and
>> > same with others you define.
>  do you mean which spec version? the definition is aligned with the linux kernel.
What I mean here is that it's better to refer to the ACPI spec version
which introduces Hardware Error Notification first time.

>> > 
>>> >> +enum AcpiHestNotifyType {
>>> >> +    ACPI_HEST_NOTIFY_POLLED = 0,
>>> >> +    ACPI_HEST_NOTIFY_EXTERNAL = 1,
>>> >> +    ACPI_HEST_NOTIFY_LOCAL = 2,
>>> >> +    ACPI_HEST_NOTIFY_SCI = 3,
>>> >> +    ACPI_HEST_NOTIFY_NMI = 4,
>>> >> +    ACPI_HEST_NOTIFY_CMCI = 5,  /* ACPI 5.0 */
>>> >> +    ACPI_HEST_NOTIFY_MCE = 6,   /* ACPI 5.0 */
>>> >> +    ACPI_HEST_NOTIFY_GPIO = 7,  /* ACPI 6.0 */
>>> >> +    ACPI_HEST_NOTIFY_SEA = 8,   /* ACPI 6.1 */
>>> >> +    ACPI_HEST_NOTIFY_SEI = 9,   /* ACPI 6.1 */
>>> >> +    ACPI_HEST_NOTIFY_GSIV = 10, /* ACPI 6.1 */
>>> >> +    ACPI_HEST_NOTIFY_RESERVED = 11  /* 11 and greater are reserved */
>> > In ACPI 6.2, 11 is for Software Delegated Exception, is this useful for
>> > your patchset?
>   it is usefull, for all the error source, I reserved the space for them.
> Because the space is allocated one time, is not dynamically allocated.
> so I use the ACPI_HEST_NOTIFY_RESERVED to specify that there is 11 error source.
> 
I mean whether the new type Software Delegated Exception is useful for
RAS. If so, we could add this new type here.

Thanks,
-- 
Shannon
