From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 2 Jul 2017 03:52:39 +0200
Subject: [PATCH 4/6] dt-bindings: serial: Document RDA Micro UART
In-Reply-To: <CAL_JsqLatRUwdA6GeWCHXFTHMUYY27pdmUpPEoHwCCFMg2F21Q@mail.gmail.com>
References: <20170627005520.23731-1-afaerber@suse.de>
 <20170627005520.23731-5-afaerber@suse.de>
 <20170629201051.cfr37kh2gozompqo@rob-hp-laptop>
 <e8b8eb0c-0362-0cfb-4d18-3e1ab2b77412@suse.de>
 <CAL_JsqLatRUwdA6GeWCHXFTHMUYY27pdmUpPEoHwCCFMg2F21Q@mail.gmail.com>
Message-ID: <d9b00fd8-2e9e-fb01-9056-db0d32b3e80b@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 30.06.2017 um 16:27 schrieb Rob Herring:
> On Fri, Jun 30, 2017 at 6:12 AM, Andreas F?rber <afaerber@suse.de> wrote:
>> Am 29.06.2017 um 22:10 schrieb Rob Herring:
>>> On Tue, Jun 27, 2017 at 02:55:18AM +0200, Andreas F?rber wrote:
>>>> Add an initial binding for the RDA8810PL UART.
>>>>
>>>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>>>> ---
>>>>  Documentation/devicetree/bindings/serial/rda-uart.txt | 13 +++++++++++++
>>>>  1 file changed, 13 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/serial/rda-uart.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/serial/rda-uart.txt b/Documentation/devicetree/bindings/serial/rda-uart.txt
>>>> new file mode 100644
>>>> index 000000000000..6840a8aee035
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/serial/rda-uart.txt
>>>> @@ -0,0 +1,13 @@
>>>> +RDA Micro UART
>>>> +
>>>> +Required properties:
>>>> +- compatible :  "rda,8810pl-uart" for RDA8810PL
>>>> +- reg        :  Offset and length of the register set for the device.
>>>
>>> No clocks or interrupts?
>>
>> Not yet. I've only pieced together an earlycon driver so far, no full
>> serial driver. The .dtsi doesn't even have an interrupt-controller node
>> yet - wasn't clear to me whether this SoC even has a GIC and, if so,
>> where, from the downstream pre-DT code.
> 
> How far can you boot with no interrupts?

That was described in the cover letter, as usual.

> DT bindings shouldn't unnecessarily evolve. Really, anything added
> should be optional to maintain compatibility. Sometimes that's
> unavoidable, but this isn't one of those cases.

Makes sense. Maybe this series should've been marked RFC. It's too late
for 4.13 anyway, so there's lots of time left to extend the bindings.

BTW I saw that Kevin was adding a disclaimer to the Amlogic bindings
that they are not stable. Is that required here, too?

> So submit this when
> you have something more complete.

Negative. I worked weeks and months towards perfect STM32 drivers, and
despite showing it to ST and at a LinuxCon Japan, someone else sent less
sophisticated patches (e.g., fixed-clocks) and took all the credit. Same
with Turris Omnia. Therefore I am now submitting my new patches early,
not just when everything is complete.

It took weeks just to get any earlycon output on the 2G-IoT at all - not
my serial driver or my DT was broken, but the vendor's U-Boot just
wasn't passing the .dtb to the kernel properly, as it turned out. Now
that we know how to boot a DT-based kernel and get serial output, it
becomes much easier for me and potential contributors to add drivers.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
