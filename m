From: zonque@gmail.com (Daniel Mack)
Date: Sun, 04 Aug 2013 16:13:13 +0200
Subject: [PATCH 3/5] gpio: pxa: Documentation: provide example bindings
 for PXA3xx
In-Reply-To: <CAN1soZxWPqd8c-4+=mg0TMH0-zbGv+ckT5o0Z7Q3KFxni2yd1g@mail.gmail.com>
References: <1373555877-29887-1-git-send-email-zonque@gmail.com>
 <1373555877-29887-4-git-send-email-zonque@gmail.com>
 <CAN1soZxWPqd8c-4+=mg0TMH0-zbGv+ckT5o0Z7Q3KFxni2yd1g@mail.gmail.com>
Message-ID: <51FE6179.5000702@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04.08.2013 16:11, Haojian Zhuang wrote:
> On Thu, Jul 11, 2013 at 11:17 PM, Daniel Mack <zonque@gmail.com> wrote:
>> Add another example to describe bindings that work for PXA3xx boards.
>>
>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/gpio/mrvl-gpio.txt | 15 ++++++++++++++-
>>  1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/gpio/mrvl-gpio.txt b/Documentation/devicetree/bindings/gpio/mrvl-gpio.txt
>> index 6641626..b2afdb2 100644
>> --- a/Documentation/devicetree/bindings/gpio/mrvl-gpio.txt
>> +++ b/Documentation/devicetree/bindings/gpio/mrvl-gpio.txt
>> @@ -19,7 +19,7 @@ Required properties:
>>  - gpio-controller : Marks the device node as a gpio controller.
>>  - #gpio-cells : Should be one.  It is the pin number.
>>
>> -Example:
>> +Example for a MMP platform:
>>
>>         gpio: gpio at d4019000 {
>>                 compatible = "marvell,mmp-gpio";
>> @@ -32,6 +32,19 @@ Example:
>>                 #interrupt-cells = <1>;
>>        };
>>
>> +Example for a PXA3xx platform:
>> +
>> +       gpio: gpio at 40e00000 {
>> +               compatible = "intel,pxa3xx-gpio";
>> +               reg = <0x40e00000 0x10000>;
>> +               interrupt-names = "gpio0", "gpio1", "gpio_mux";
>> +               interrupts = <8 9 10>;
>> +               gpio-controller;
>> +               #gpio-cells = <0x2>;
>> +               interrupt-controller;
>> +               #interrupt-cells = <0x2>;
>> +       };
>> +
>>  * Marvell Orion GPIO Controller
>>
>>  Required properties:
>> --
>> 1.8.1.4
>>
>>
> 
> Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>

Ok, great, thanks Haojian.

Linus W, 4/5 and 5/5 will be picked and merged by Haojian's tree. That
makes more sense as I have more pxa patches coming.


Thanks,
Daniel
