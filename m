From: olof@lixom.net (Olof Johansson)
Date: Fri, 20 Jan 2012 23:28:02 -0800
Subject: [RFC v3 PATCH 1/3] dt: device tree bindings for DDR memories
In-Reply-To: <4F188386.3080507@ti.com>
References: <1326983521-373-1-git-send-email-aneesh@ti.com>
 <1326983521-373-2-git-send-email-aneesh@ti.com>
 <CAOesGMikm8szKR_yyeV-4NbnknCLG3z9N_sj+zydyu+cosj-Tg@mail.gmail.com>
 <4F188386.3080507@ti.com>
Message-ID: <CAOesGMg01SvP1koV8GTJgeMATROZ0oP5BQSDqtmge_UZXvwZLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2012 at 12:56 PM, Aneesh V <aneesh@ti.com> wrote:
> Hi Olof,
>
>
> On Friday 20 January 2012 01:01 AM, Olof Johansson wrote:
>>
>> Hi,
>>
>> Sorry for the delay in responding, I know you pinged me about it
>> yesterday.
>>
>> On Thu, Jan 19, 2012 at 6:31 AM, Aneesh V<aneesh@ti.com> ?wrote:
>>>
>>> device tree bindings for LPDDR2 SDRAM memories compliant
>>> to JESD209-2 standard.
>>>
>>> The 'lpddr2' binding in-turn uses another binding 'lpddr2-timings'
>>> for specifying the AC timing parameters of the memory device at
>>> different speed-bins.
>>
>>
>> As I just commented on the thread with Mike, I think we would be
>> better off sticking to embedding a standard JEDEC SPD structure in the
>> device tree. It's not large (128-256 bytes depending on memory type),
>> and it's clearly defined and used all over the industry.
>>
>> It also has the benefit of reusing parsing code if you ever end up
>> with a system that uses DIMMs for memory, thus needing to parse the
>> SPD on said modules.
>
>
> I did mention in the previous thread why SPD doesn't work for us ([1] and
> [2]). Let me repeat the key points here.

Ah, sorry. Missed it in the chain of replies.

> 1. I couldn't find an SPD addendum for LPDDR2 from the JEDEC website.
> 2. This seems to indicate that SPD is not used for LPDDR2 devices.

Bummer. I'm guessing most applications where LPDDR* is used won't be
suitable for modular memory, so there's not the same need for SPD.

> 3. I tried to see if I can fit the DDR3 or DDR2 SPD for our needs. But
> some of the AC timing parameters needed by our controller are not
> available in those layouts.

Are those properties of the memory, or a combination of memory and
board properties? I think it still makes sense for the memories that
do have it to use the SPD format and extend with additional
properties, at least if it's only a few additional properties needed.

> I don't see any option other than defining a new binding for LPDDR2.

Yeah, agreed.


-Olof
