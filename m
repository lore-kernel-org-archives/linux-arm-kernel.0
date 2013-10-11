From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Fri, 11 Oct 2013 20:29:44 +0530
Subject: [PATCH v3 1/3] gpio: davinci: add OF support
In-Reply-To: <CACRpkdYxegBSYXR1-98smUNnDXpyRHo_vuYdnr3r7zhawENiUA@mail.gmail.com>
References: <1380902596-4693-1-git-send-email-sujithkv@ti.com>
 <1380902596-4693-2-git-send-email-sujithkv@ti.com>
 <CACRpkdYxegBSYXR1-98smUNnDXpyRHo_vuYdnr3r7zhawENiUA@mail.gmail.com>
Message-ID: <CA+V-a8vyPyL0j0nPOZyjxrecusFzXovFPsNBLKYXns5ASWR-wg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus ,

On 10/11/13, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Oct 4, 2013 at 6:03 PM, Prabhakar Lad
> <prabhakar.csengg@gmail.com> wrote:
>
>> This patch adds OF parser support for davinci gpio
>> driver and also appropriate documentation in gpio-davinci.txt
>> located at Documentation/devicetree/bindings/gpio/.
>>
>> Signed-off-by: KV Sujith <sujithkv@ti.com>
>> Signed-off-by: Philip Avinash <avinashphilip@ti.com>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> ^Don't trust this guy.
>
>> [prabhakar.csengg at gmail.com: simplified the OF code and also
>>                  the commit message]
>> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
>> ---
>>  .../devicetree/bindings/gpio/gpio-davinci.txt      |   34 +++++++++++
>>  drivers/gpio/gpio-davinci.c                        |   60
>> +++++++++++++++++++-
>>  2 files changed, 91 insertions(+), 3 deletions(-)
>>  create mode 100644
>> Documentation/devicetree/bindings/gpio/gpio-davinci.txt
>>
>> diff --git a/Documentation/devicetree/bindings/gpio/gpio-davinci.txt
>> b/Documentation/devicetree/bindings/gpio/gpio-davinci.txt
>> new file mode 100644
>> index 0000000..87abd3b
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/gpio/gpio-davinci.txt
>> @@ -0,0 +1,34 @@
>> +Davinci GPIO controller bindings
>> +
>> +Required Properties:
>> +- compatible: should be "ti,dm6441-gpio"
>> +
>> +- reg: Physical base address of the controller and the size of memory
>> mapped
>> +       registers.
>> +
>> +- gpio-controller : Marks the device node as a gpio controller.
>> +
>> +- interrupts: Array of GPIO interrupt number.
>> +
>> +- ngpio: The number of GPIO pins supported.
>> +
>> +- ti,davinci-gpio-irq-base: Base from where GPIO interrupt numbering
>> starts.
>
> What is this?
>
> If I have ever ACKed this I have been drunk. I take it back.
>
here is the ACK https://patchwork.kernel.org/patch/2721181/

> This "base" is a Linux-specific thing and has no place in the
> device tree, and shall not be there. You have to find some way to
> avoid this, what do you think some other OS should do with
> this value...
>
> All IRQs in Linux are assumed to be dynamically assigned numbers
> nowadays, with a property like this you can never switch on
> SPARSE_IRQ for the DaVinci.
>
Can you point to any alternative solution if you have any ?

-- 
Regards,
--Prabhakar Lad
