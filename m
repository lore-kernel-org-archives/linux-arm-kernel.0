From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 2 Nov 2016 22:37:10 -0600
Subject: [PATCH v4 6/8] dt-bindings: Add support for Amlogic GXBB SCPI
 Interface
In-Reply-To: <CAL_JsqJWABnX1-6SHZL8SOSt4OSPbTyXrCqTYCkXgxuO87gN-A@mail.gmail.com>
References: <1475652814-30619-1-git-send-email-narmstrong@baylibre.com>
 <1475652814-30619-7-git-send-email-narmstrong@baylibre.com>
 <CAOesGMjY5_ibP7E9+DBf30nuV+2z2kecLv_ddnHjp3txuq+Kdg@mail.gmail.com>
 <20161102222050.GA32189@e106835-lin.cambridge.arm.com>
 <CAL_JsqJWABnX1-6SHZL8SOSt4OSPbTyXrCqTYCkXgxuO87gN-A@mail.gmail.com>
Message-ID: <e02415f4-d789-c1ef-5c60-c09b73be9c05@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/11/16 21:51, Rob Herring wrote:
> On Wed, Nov 2, 2016 at 5:20 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> On Sat, Oct 29, 2016 at 11:39:05AM -0700, Olof Johansson wrote:
>>> Hi,
>>>
>>>
>>> On Wed, Oct 5, 2016 at 12:33 AM, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>>> Acked-by: Rob Herring <robh@kernel.org>
>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/arm/arm,scpi.txt | 8 +++++---
>>>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/arm,scpi.txt b/Documentation/devicetree/bindings/arm/arm,scpi.txt
>>>> index faa4b44..04bc171 100644
>>>> --- a/Documentation/devicetree/bindings/arm/arm,scpi.txt
>>>> +++ b/Documentation/devicetree/bindings/arm/arm,scpi.txt
>>>> @@ -7,7 +7,7 @@ by Linux to initiate various system control and power operations.
>>>>
>>>>  Required properties:
>>>>
>>>> -- compatible : should be "arm,scpi"
>>>> +- compatible : should be "arm,scpi" or "amlogic,meson-gxbb-scpi"
>>>
>>> This doesn't seem right to document here. If anything you might want
>>> to have a table of more-specific-compatibles for specific
>>> implementations, but "arm,scpi" should still be the compatible of the
>>> node (just not the most specific one).
>>>
>>
>> I completely agree with you and I was pushing for a generic "arm,legacy-scpi"
>> compatible until this binding was acked by Rob.
>
> Just because I ack something, that doesn't mean don't review or
> comment on it further.
>

Sorry I didn't mean to say that. I was initially pushing for the generic
binding and since it was reworked many times already, I didn't want to
postpone any further just for sake of that. I completely understand that
component maintainers have to review the bindings too. So clearly it was
my mistake.

>>
>> Anyways, I will add the generic compatible and post the changes.
>>
>>> Also, documenting it here indiciates that non-amlogic implementations
>>> can/should use that compatible, which is misleading.
>>>
>>
>> Agreed, it's better to keep them out of this generic binding document.
>>
>>>>  - mboxes: List of phandle and mailbox channel specifiers
>>>>           All the channels reserved by remote SCP firmware for use by
>>>>           SCPI message protocol should be specified in any order
>>>> @@ -60,7 +60,8 @@ A small area of SRAM is reserved for SCPI communication between application
>>>>  processors and SCP.
>>>>
>>>>  Required properties:
>>>> -- compatible : should be "arm,juno-sram-ns" for Non-secure SRAM on Juno
>>>> +- compatible : should be "arm,juno-sram-ns" for Non-secure SRAM on Juno,
>>>> +               or "amlogic,meson-gxbb-sram" for Amlogic GXBB SoC.
>>>
>>> Maybe you'd be better of with a meson-specific document that refers to
>>> these but with different compatible values.
>>>
>>> Come to think of it, the Juno-specific one maybe shouldn't be in
>>> arm,scpi at all, since that adds confusion here.
>>>
>>> It's somewhat confusing that ARM is both a platform, architecture and
>>> in some cases implementer of specific systems. :)
>>>
>>
>> Sorry for that, I will move all juno specific references in the binding
>> out of this document(except the examples, which I assume should be fine)
>>
>>>>  The rest of the properties should follow the generic mmio-sram description
>>>>  found in ../../sram/sram.txt
>>>> @@ -70,7 +71,8 @@ Each sub-node represents the reserved area for SCPI.
>>>>  Required sub-node properties:
>>>>  - reg : The base offset and size of the reserved area with the SRAM
>>>>  - compatible : should be "arm,juno-scp-shmem" for Non-secure SRAM based
>>>> -              shared memory on Juno platforms
>>>> +              shared memory on Juno platforms or
>>>> +              "amlogic,meson-gxbb-scp-shmem" for Amlogic GXBB SoC.
>>>
>>> Same here. It won't scale if all vendors are expected to add an entry here.
>>>
>>
>> I will rework the patches to address the concerns as I too did share same
>> concern.
>
> Guess I was optimistic that *every* platform wouldn't be different in
> some way. I should know better by now...

:)

-- 
Regards,
Sudeep
