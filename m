From: sbranden@broadcom.com (Scott Branden)
Date: Wed, 14 Oct 2015 12:44:24 -0700
Subject: [PATCH 2/2] dt-bindings: Add new boards to bcm4708 DT bindings
In-Reply-To: <20151014153420.GC15160@broadcom.com>
References: <1443824564-17291-1-git-send-email-jonmason@broadcom.com>
 <1443824564-17291-2-git-send-email-jonmason@broadcom.com>
 <561923BC.5040906@hauke-m.de> <20151013214051.GN12512@broadcom.com>
 <561D87BD.5030405@gmail.com> <20151014153420.GC15160@broadcom.com>
Message-ID: <561EB098.4090400@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

Yes, please only add SoC part number compatible strings, not board 
compatible strings.

On 15-10-14 08:34 AM, Jon Mason wrote:
> On Tue, Oct 13, 2015 at 03:37:49PM -0700, Florian Fainelli wrote:
>> On 13/10/15 14:40, Jon Mason wrote:
>>> On Sat, Oct 10, 2015 at 04:42:04PM +0200, Hauke Mehrtens wrote:
>>>> On 10/03/2015 12:22 AM, Jon Mason wrote:
>>>>> Add the 4708, 4709, and 953012k SVKs to the the documentation for the
>>>>> Broadcom Northstar device tree bindings.
>>>>>
>>>>> Signed-off-by: Jon Mason <jonmason@broadcom.com>
>>>>> ---
>>>>>   Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.txt | 7 +++++++
>>>>>   1 file changed, 7 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.txt
>>>>> index 6b0f49f..bdf4c06 100644
>>>>> --- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.txt
>>>>> +++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.txt
>>>>
>>>> What should be documented in this file? This is more a question to the
>>>> guys more familiar with arm in Linux. Currently the Linux kernel only
>>>> supports brcm,bcm4708 and all goes back to that one.
>>>
>>> I was under the impression that all boards should be added to these
>>> files.  We have been doing so for Cygnus and NSP.
>>
>> Tracking exactly which boards are supported by the brcm,bcm4708
>> compatible string might be tedious, I tend to agree with just listing
>> the supported SoCs, and leaving the specific board compatibles to the
>> individual DTS files instead.
>
> Ok, I'll simply add entries for NS and 4709 to this.
Good - we have only been adding SoC compatible strings for Cygnus and 
NSP - not board compatibles.

>
> Thanks,
> Jon
>
>>
>>>
>>> Thanks,
>>> Jon
>>>
>>>>
>>>>> @@ -5,4 +5,11 @@ Boards with the BCM4708 SoC shall have the following properties:
>>>>>
>>>>>   Required root node property:
>>>>>
>>>>> +bcm94709
>>>>>   compatible = "brcm,bcm4708";
>>>>> +
>>>>> +bcm94709
>>>>> +compatible = "brcm,bcm4709", "brcm,bcm4708";
>>>>> +
>>>>> +bcm953012k
>>>>> +compatible = "brcm,bcm5301k", "brcm,bcm4708";
>>>>>
>>>>
>>
>>
>> --
>> Florian
