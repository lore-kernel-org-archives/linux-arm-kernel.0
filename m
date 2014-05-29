From: robherring2@gmail.com (Rob Herring)
Date: Wed, 28 May 2014 20:30:28 -0500
Subject: [PATCH 01/10] dt/bindings: add passthru-mask property to
 versatile-fpga-irq
In-Reply-To: <CAL_JsqJYzMvhWng7YUdQbKdFxVwUXZkB-h_kq7yZAOzi1biiPw@mail.gmail.com>
References: <1400620176-7239-1-git-send-email-robherring2@gmail.com>
 <1400620176-7239-2-git-send-email-robherring2@gmail.com>
 <CACRpkdZGevG9YaUPUs98pQidcGz7MxbxjuSxBn=cqaOYGhWegw@mail.gmail.com>
 <CAL_JsqJYzMvhWng7YUdQbKdFxVwUXZkB-h_kq7yZAOzi1biiPw@mail.gmail.com>
Message-ID: <CAL_JsqKKgQkerKGSqt=1QYurpKyEyaLuakmPF0jQvD7pNuMKeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 8:00 AM, Rob Herring <robherring2@gmail.com> wrote:
> On Fri, May 23, 2014 at 7:46 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Tue, May 20, 2014 at 11:09 PM, Rob Herring <robherring2@gmail.com> wrote:
>>
>>> From: Rob Herring <robh@kernel.org>
>>>
>>> Add a passthru-mask property for setting interrupts which are passed
>>> through directly to a primary controller.
>>>
>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>> Cc: Pawel Moll <pawel.moll@arm.com>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
>>> Cc: Kumar Gala <galak@codeaurora.org>
>>> ---
>>>  Documentation/devicetree/bindings/arm/versatile-fpga-irq.txt | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/versatile-fpga-irq.txt b/Documentation/devicetree/bindings/arm/versatile-fpga-irq.txt
>>> index c9cf605..956b71d 100644
>>> --- a/Documentation/devicetree/bindings/arm/versatile-fpga-irq.txt
>>> +++ b/Documentation/devicetree/bindings/arm/versatile-fpga-irq.txt
>>> @@ -34,3 +34,6 @@ Optional properties:
>>>  - interrupts: if the FPGA IRQ controller is cascaded, i.e. if its IRQ
>>>    output is simply connected to the input of another IRQ controller,
>>>    then the parent IRQ shall be specified in this property.
>>> +- passthru-mask: a u32 number representing a bit mas determining which of
>>
>> bit mask
>>
>> (speling)
>>
>>> +  the interrupts are directly passed through to the primary interrupt
>>> +  controller.
>>
>> This is very confusing on the Integrators. The FPGA IRQ controller
>> *is* the primary interrupt controller on these.
>
> Yes. Really, the h/w is not the same and we should have different
> compatible strings. Unfortunately, it is Integrator that should
> change.

I don't know what I was thinking... The compatible strings are
different as Versatile uses arm,versatile-sic, so I can drop this
passthru-mask.

Rob
