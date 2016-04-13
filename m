From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 13 Apr 2016 15:44:40 +0200
Subject: [PATCH 2/2] dt-bindings: Add Oxford Semiconductor OXNAS pinctrl
 and gpio bindings
In-Reply-To: <20160404051621.GM17806@rob-hp-laptop>
References: <1459689969-5326-1-git-send-email-narmstrong@baylibre.com>
 <1459689969-5326-3-git-send-email-narmstrong@baylibre.com>
 <20160404051621.GM17806@rob-hp-laptop>
Message-ID: <CACRpkdYYy2qObQDOP-FTPtwOgEqg6zgJOAwkSsYJaam6jqjSaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 4, 2016 at 7:16 AM, Rob Herring <robh@kernel.org> wrote:
> On Sun, Apr 03, 2016 at 03:26:09PM +0200, Neil Armstrong wrote:
>> Add pinctrl and gpio DT bindings for Oxford Semiconductor OXNAS SoC Family.
>> This version supports the ARM926EJ-S based OX810SE SoC with 34 IO pins.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  .../devicetree/bindings/gpio/gpio_oxnas.txt        | 43 ++++++++++++++++
>>  .../devicetree/bindings/pinctrl/oxnas,pinctrl.txt  | 57 ++++++++++++++++++++++
>>  2 files changed, 100 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio_oxnas.txt
>>  create mode 100644 Documentation/devicetree/bindings/pinctrl/oxnas,pinctrl.txt
>>
>> diff --git a/Documentation/devicetree/bindings/gpio/gpio_oxnas.txt b/Documentation/devicetree/bindings/gpio/gpio_oxnas.txt
>> new file mode 100644
>> index 0000000..ddd3de9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/gpio/gpio_oxnas.txt
>> @@ -0,0 +1,43 @@
>> +* Oxford Semiconductor OXNAS SoC GPIO Controller
>> +
>> +Required properties:
>> + - compatible: "oxsemi,ox810se-gpio"
>> + - reg: Base address and length for the device.
>> + - interrupts: The port interrupt shared by all pins.
>> + - gpio-controller: Marks the port as GPIO controller.
>> + - #gpio-cells: Two. The first cell is the pin number and
>> +   the second cell is used to specify the gpio polarity as defined in
>> +   defined in <dt-bindings/gpio/gpio.h>:
>> +      0 = GPIO_ACTIVE_HIGH
>> +      1 = GPIO_ACTIVE_LOW
>> + - interrupt-controller: Marks the device node as an interrupt controller.
>> + - #interrupt-cells: Two. The first cell is the GPIO number and second cell
>> +   is used to specify the trigger type as defined in
>> +   <dt-bindings/interrupt-controller/irq.h>:
>> +      IRQ_TYPE_EDGE_RISING
>> +      IRQ_TYPE_EDGE_FALLING
>> +      IRQ_TYPE_EDGE_BOTH
>> + - gpio-ranges: Interaction with the PINCTRL subsystem.
>
> This should say something about what is a valid value. Think how do you
> validate the example?

It should just reference gpio/gpio.txt I think. The binding
is described there. (Partly in BNF, which noone understands.)

Yours,
Linus Walleij
