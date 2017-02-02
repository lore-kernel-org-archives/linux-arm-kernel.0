From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 2 Feb 2017 16:02:39 +0300
Subject: [PATCH v2] ARM: dts: r8a7791: link DU to VSPDs
In-Reply-To: <CANqRtoTpsMix30+ESO-bEdaBM8H_9eTOLuoWShQABhmgJk23EA@mail.gmail.com>
References: <1529351.Fac5N2tKoF@wasted.cogentembedded.com>
 <2492577.tBEnW0tCHD@wasted.cogentembedded.com>
 <4ae454ad-296c-dec9-27e9-fd050333737f@cogentembedded.com>
 <CANqRtoSQTa0fHJSwAHbN3hXSZ=m1kuR2GsUWE5ojN5AN-9i6Bw@mail.gmail.com>
 <4bf0b27c-9641-391d-fc05-8cdc20ce4ec3@cogentembedded.com>
 <CANqRtoTpsMix30+ESO-bEdaBM8H_9eTOLuoWShQABhmgJk23EA@mail.gmail.com>
Message-ID: <afeb1f60-e60a-2c5c-4a12-7fda7bda7c50@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On 02/01/2017 03:01 PM, Magnus Damm wrote:

>>>>> Add the "vsps" property to the DU device node in order to link this node
>>>>> to
>>>>> the VSPD nodes.
>>>>>
>>>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>>>>
>>>>> ---
>>>>> Changes in version 2:
>>>>> - rebased the patch.
>>>>>
>>>>> This patch is against the 'renesas-devel-20170125-v4.10-rc5' of Simon
>>>>> Horman's
>>>>> 'renesas.git' repo.  It's  only meaningful if the DRM driver patches
>>>>> I've
>>>>> just
>>>>> posted are applied.
>>>>
>>>>
>>>>
>>>>    Forgot to note that without this patch the DU driver fails to link to
>>>> VSPD and probe correctly, so there's no video signal. So it makes sense
>>>> to
>>>> apply before the DU driver patch (once it's ACKed for merge)...
>>>
>>>
>>> Doesn't that translate to breaking the DT ABI? Is there someway we can
>>> avoid doing that?
>>
>>
>>    It doesn't -- if this patch is merged ahead of the DU patches.
>
> Perhaps I'm misunderstanding, but if you require a DTS patch to be
> merged before a driver change then doesn't this mean that older DTBs
> will stop working with newer kernels and the user is forced to update
> the DTB to avoid breakage?

    Yes, it seems so. :-(

> It would be nice if older DTBs could keep on working as before and the
> DU driver modification would work both with connected VSPs and also
> keep on working as before in case the VSP connection is not present in
> DT.

    I'll try to look into that...

> Cheers,
>
> / magnus

MBR, Sergei
