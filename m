From: rafael@kernel.org (Rafael J. Wysocki)
Date: Thu, 14 Jul 2016 03:15:27 +0200
Subject: [PATCH v9 0/7] ACPI / processor_idle: Add ACPI v6.0 LPI support
In-Reply-To: <5784E9AB.1070507@arm.com>
References: <1467997678-7107-1-git-send-email-sudeep.holla@arm.com>
 <5784D78E.7010409@arm.com> <2164074.OnkmXO2GSJ@vostro.rjw.lan>
 <5784E9AB.1070507@arm.com>
Message-ID: <CAJZ5v0jpfgVupHcoKR+vnjGYu=a5SRZEwAybH1JoCqidGXqdXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 12, 2016 at 2:59 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> On 12/07/16 13:09, Rafael J. Wysocki wrote:
>>
>> On Tuesday, July 12, 2016 12:42:06 PM Sudeep Holla wrote:
>>>
>>>
>>> On 08/07/16 18:07, Sudeep Holla wrote:
>>>>
>>>> ACPI 6.0 introduced LPI(Low Power Idle) states that provides an
>>>> alternate
>>>> method to describe processor idle states. It extends the specification
>>>> to allow the expression of idle states like C-states selectable by the
>>>> OSPM when a processor goes idle, but may affect more than one processor,
>>>> and may affect other system components.
>>>>
>>>> LPI extensions leverages the processor container device(again introduced
>>>> in ACPI 6.0) allowing to express which parts of the system are affected
>>>> by a given LPI state. It defines the local power states for each node
>>>> in a hierarchical processor topology. The OSPM can use _LPI object to
>>>> select a local power state for each level of processor hierarchy in the
>>>> system. They used to produce a composite power state request that is
>>>> presented to the platform by the OSPM.
>>>>
>>>> Since multiple processors affect the idle state for any non-leaf
>>>> hierarchy
>>>> node, coordination of idle state requests between the processors is
>>>> required. ACPI supports two different coordination schemes: Platform
>>>> coordinated and  OS initiated.
>>>>
>>>
>>> I was hoping to get this in v4.8 now that merge window is
>>> delayed/extended if you have no further comments on this series.
>>
>>
>> I'll get to it in the next couple of days.  If it looks all good and there
>> are
>> no comments, I'll queue it up.
>>
>
> Thanks for the update.

I've just looked at patch [2/7] and there still are things I'm not
particularly liking in it.

Apart from a bunch of minor stuff, acpi_processor_get_lpi_info() is
not my favorite.  The way it creates all of those temporary data
structures and then walks them recursively seems a bit excessive.

I need to think about it a bit more, so I'll send my comments on that
patch later this week.

Thanks,
Rafael
