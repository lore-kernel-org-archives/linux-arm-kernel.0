From: rafael@kernel.org (Rafael J. Wysocki)
Date: Wed, 29 Jun 2016 23:26:36 +0200
Subject: [PATCH V2 1/4] ACPI,PCI,IRQ: factor in PCI possible
In-Reply-To: <280859fd-07a0-9cea-c9d4-f956241e8986@codeaurora.org>
References: <1467188859-28188-1-git-send-email-okaya@codeaurora.org>
 <1467188859-28188-2-git-send-email-okaya@codeaurora.org>
 <CAJZ5v0j1m4oGJfdOC8uerKc-3ksq6k2e9RdjEnk0sWmsq4RHRQ@mail.gmail.com>
 <8a40e242-fca4-5681-e480-e29ec05354ac@codeaurora.org>
 <CAJZ5v0hUpxxEjVxMBW6p6q0MSB5nFxnVL0g5dw4HBAsyK4yisg@mail.gmail.com>
 <280859fd-07a0-9cea-c9d4-f956241e8986@codeaurora.org>
Message-ID: <CAJZ5v0jjopsNJnjZxPZALH5LYamKs4eentUy7HLF38bUVfUEwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2016 at 11:21 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 6/29/2016 5:19 PM, Rafael J. Wysocki wrote:
>> On Wed, Jun 29, 2016 at 8:47 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
>>> On 6/29/2016 9:13 AM, Rafael J. Wysocki wrote:
>>>> On Wed, Jun 29, 2016 at 10:27 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
>>>>> The change introduced in commit 103544d86976 ("ACPI,PCI,IRQ: reduce
>>>>> resource requirements") omitted the initially assigned POSSIBLE penalty
>>>>> when the IRQ is active.
>>>>
>>>> It would be good to say what can go wrong with that here.
>>>>
>>>
>>> I can add more description. Here is a first attempt.
>>>
>>> Incorrect calculation of penalty leads to ACPI code assigning the wrong
>>> interrupt number to PCI INTx interrupts.
>>>
>>> This would not be as bad as it sounds in theory. You would just cause the
>>> interrupts to be shared and observe performance penalty.
>>>
>>> However, some drivers like parallel port driver doesn't like interrupt
>>> sharing as in this example and causes all other PCI drivers sharing the interrupt
>>> to malfunction.
>>>
>>> The issue has not been caught because the behavior is platform specific
>>> and depends on the peripheral drivers sharing the IRQ.
>>>
>>> I can claim that this could be a BIOS bug. if interrupt 7 is not good for PCI,
>>> it shouldn't have been listed in the possible PCI interrupts to begin with.
>>> Given this is an existing platform, I don't think we have the luxury to request
>>> all BIOS to be updated. This bugfix is needed to support existing platforms.
>>>
>>>
>>> Feel free to request more information if the above description is not clear.
>>
>> It is clear enough.  I can add it to the changelog when applying the patch.
>
> OK

BTW, care to add Fixes: tags to these patches?

Thanks,
Rafael
