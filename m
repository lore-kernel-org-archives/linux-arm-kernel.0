From: olof@lixom.net (Olof Johansson)
Date: Thu, 10 Nov 2016 11:03:06 -0800
Subject: [PATCH v5 6/8] Documentation: bindings: add compatible specific
 to legacy SCPI protocol
In-Reply-To: <7ccc12bc-9a05-47e3-8ab8-d1b0ad31159e@arm.com>
References: <1478148731-11712-1-git-send-email-sudeep.holla@arm.com>
 <1478148731-11712-7-git-send-email-sudeep.holla@arm.com>
 <20161110012249.ed56ik6kdffoikym@rob-hp-laptop>
 <14e563ae-36c5-4bf9-0d51-3b07830de3db@arm.com>
 <CAL_JsqLW4JZHb0ncVUEefnKySA231EDgvCkY3xPdaJGf=uMJYg@mail.gmail.com>
 <7ccc12bc-9a05-47e3-8ab8-d1b0ad31159e@arm.com>
Message-ID: <CAOesGMj3TYLkvfGbq6BKqr+9i6mjArjRPuqeAN1-rGO2OhoSyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2016 at 6:34 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> On 10/11/16 14:12, Rob Herring wrote:
>>
>> On Thu, Nov 10, 2016 at 4:26 AM, Sudeep Holla <sudeep.holla@arm.com>
>> wrote:
>>>
>>>
>>>
>>> On 10/11/16 01:22, Rob Herring wrote:
>>>>
>>>>
>>>> On Wed, Nov 02, 2016 at 10:52:09PM -0600, Sudeep Holla wrote:
>>>>>
>>>>>
>>>>> This patch adds specific compatible to support legacy SCPI protocol.
>>>>>
>>>>> Cc: Rob Herring <robh+dt@kernel.org>
>>>>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>>>>> ---
>>>>>  Documentation/devicetree/bindings/arm/arm,scpi.txt | 4 +++-
>>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/arm/arm,scpi.txt
>>>>> b/Documentation/devicetree/bindings/arm/arm,scpi.txt
>>>>> index d1882c4540d0..ebd03fc93135 100644
>>>>> --- a/Documentation/devicetree/bindings/arm/arm,scpi.txt
>>>>> +++ b/Documentation/devicetree/bindings/arm/arm,scpi.txt
>>>>> @@ -7,7 +7,9 @@ by Linux to initiate various system control and power
>>>>> operations.
>>>>>
>>>>>  Required properties:
>>>>>
>>>>> -- compatible : should be "arm,scpi"
>>>>> +- compatible : should be
>>>>> +       * "arm,scpi" : For implementations complying to SCPI v1.0 or
>>>>> above
>>>>> +       * "arm,legacy-scpi" : For implementations complying pre SCPI
>>>>> v1.0
>>>>
>>>>
>>>>
>>>> I'd prefer that we explicitly enumerate the old versions. Are there
>>>> many?
>>>>
>>>
>>> I understand your concern, but this legacy SCPI protocol was not
>>> officially released. It was just WIP which vendors picked up from very
>>> early releases. Since they are not numbered, it's hard to have specific
>>> compatibles with different versions until v1.0. That's one of the reason
>>> to retain platform specific compatible so that we can add any quirks
>>> based on them if needed.
>>>
>>> I will probably add these information in the commit log so that it's
>>> clear why we can't do version based compatible.
>>
>>
>> This is exactly my point. By enumerate, I meant having platform
>> specific compatibles. Having "arm,legacy-scpi" is pointless because
>> who knows what version they followed and they may all be different.
>>
>
> OK, but IIUC Olof's concern wanted a generic one along with the platform
> specific compatible which kind of makes sense as so far we have seen
> some commonality between Amlogic and Rockchip.
>
> E.g. Amlogic follows most of the legacy protocol though it deviates in
> couple of things which we can handle with platform specific compatible
> (in the following patch in the series). When another user(Rockchip ?)
> make use of this legacy protocol, we can start using those platform
> specific compatible for deviations only.
>
> Is that not acceptable ?

If there's no shared legacy feature set, then it's probably less
useful to have a shared less precise compatible value.

What the main point I was trying to get across was that we shouldn't
expand the generic binding with per-vendor compatible fields, instead
we should have those as extensions on the side.

I'm also a little apprehensive of using "legacy", it goes in the same
bucket as "misc". At some point 1.0 will be legacy too, etc.


-Olof
