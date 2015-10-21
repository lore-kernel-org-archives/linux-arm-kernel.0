From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 21 Oct 2015 12:13:54 +0100
Subject: [PATCH 10/19] ARM: dts: at91: replace gpio-key,wakeup with
 wakeup-source property
In-Reply-To: <CAPDyKFq8CfzVPPCz=1AxZM3wsw8pkOPG6Ua_5spDuYa=Gzshrw@mail.gmail.com>
References: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
 <1445422216-29375-11-git-send-email-sudeep.holla@arm.com>
 <5627672D.60108@atmel.com> <56276832.9040006@arm.com>
 <CAPDyKFq8CfzVPPCz=1AxZM3wsw8pkOPG6Ua_5spDuYa=Gzshrw@mail.gmail.com>
Message-ID: <56277372.6080203@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 21/10/15 12:01, Ulf Hansson wrote:
> On 21 October 2015 at 12:25, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>>
>> On 21/10/15 11:21, Nicolas Ferre wrote:
>>>
>>> Le 21/10/2015 12:10, Sudeep Holla a ?crit :
>>>>
>>>> Though the keyboard driver for GPIO buttons(gpio-keys) will continue to
>>>> check for/support the legacy "gpio-key,wakeup" boolean property to
>>>> enable gpio buttons as wakeup source, "wakeup-source" is the new
>>>> standard binding.
>>>>
>>>> This patch replaces the legacy "gpio-key,wakeup" with the unified
>>>> "wakeup-source" property in order to avoid any futher copy-paste
>>>> duplication.
>>>>
>>>> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
>>>
>>>
>>> I'm not against this if the whole series goes further.
>>> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>>>
>>
>> Thanks !
>>
>>> I suspect that we would need to take this patch with us on the AT91
>>> branches that would go to arm-soc. Is it the intentions?
>>>
>>
>> Yes that was my intention for splitting the patches per SoC group.
>> Many SoC maintainers prefer that.
>
> Hold on! All patches that changes the DT parsing to accept the
> "standardized wakeup-source" binding, need to be merged upstream
> before corresponding DTS changes.
>

Agreed. Sorry for that I forgot about it as there are only few
subsystems that needed additions. Most of the input subsystem had
already moved to new binding, just that binding documents were left
unchanged.

> Therefore, I suggest we go for a two step approach, starting with
> changes affecting the DT parsing/documentation for various
> drivers/subsystem and perhaps we can reach 4.4 for these.
> Then the DTS changes can go in at any later point.
>

Looks good to me.

-- 
Regards,
Sudeep
