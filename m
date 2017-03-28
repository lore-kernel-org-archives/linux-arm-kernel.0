From: rafael@kernel.org (Rafael J. Wysocki)
Date: Wed, 29 Mar 2017 00:06:45 +0200
Subject: [PATCH] ACPI / IPMI: change warning to debug on timeout
In-Reply-To: <67243d7f-0195-a214-b9d4-bdac48743893@acm.org>
References: <1490283150-24000-1-git-send-email-okaya@codeaurora.org>
 <537c0d7a-fd95-2e7f-be07-9e3ca79ca07a@acm.org>
 <39c54677-1472-afff-ec70-45a790f56e50@codeaurora.org>
 <67243d7f-0195-a214-b9d4-bdac48743893@acm.org>
Message-ID: <CAJZ5v0hbPkzwV0wkTm1rE4d3R-xu9CAQBV68p=S-eHWCQMEuRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 28, 2017 at 10:01 PM, Corey Minyard <minyard@acm.org> wrote:
> On 03/25/2017 09:08 AM, Sinan Kaya wrote:
>>
>> On 3/24/2017 10:55 PM, Corey Minyard wrote:
>>>
>>> Why would a timeout for a message be expected?  The BMC should
>>> at least respond with an error for an incorrect message.
>>
>> Let me add some more context...
>>
>> In this particular case, the FRU ID that I was trying to access was
>> correct.
>>
>> Platform supports PCIe hotplug. The FRU is embedded into the HW that
>> is being removed. That's what I mean by non-existent.
>>
>> When the device is ejected and a FRU command is executed, BMC times out
>> reaching to the FRU on the device.
>>
>> When the device is inserted, everything works as expected.
>
>
> I haven't added this yet.  Someone who knows more about the ACPI side of
> IPMI
> should probably comment.  So I've added Lv Zheng.
>
> This is ok with me, though.  If you remove a management controller, a
> timeout is
> expected.  However, if the management controller is still present, a timeout
> is
> probably not the best error code, "destination unavailable" is probably a
> better
> choice.
>
> So:
>
> Acked-by: Corey Minyard <cminyard@mvista.com>
>
> -corey

FWIW, this change is fine by me, so please feel free to route this
through the IPMI tree along with the other patch from Sinan.

Thanks,
Rafael
