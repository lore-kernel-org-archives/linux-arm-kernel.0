From: rjui@broadcom.com (Ray Jui)
Date: Wed, 2 Dec 2015 09:32:34 -0800
Subject: [PATCH 1/3] pinctrl: Broadcom NSP GPIO-a device tree bindings
In-Reply-To: <20151202150735.GA6165@rob-hp-laptop>
References: <1449031598-18849-1-git-send-email-yrdreddy@broadcom.com>
 <20151202150735.GA6165@rob-hp-laptop>
Message-ID: <565F2B32.6000808@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 12/2/2015 7:07 AM, Rob Herring wrote:
> On Tue, Dec 01, 2015 at 11:46:38PM -0500, Yendapally Reddy Dhananjaya Reddy wrote:
>> Device tree binding documentation for Broadcom NSP GPIO-a driver
>
> Bindings are for h/w, not drivers...
>
>>
>> Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yrdreddy@broadcom.com>
>> ---
>>   .../devicetree/bindings/pinctrl/brcm,nsp-gpio.txt  | 80 ++++++++++++++++++++++
>>   1 file changed, 80 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pinctrl/brcm,nsp-gpio.txt
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,nsp-gpio.txt b/Documentation/devicetree/bindings/pinctrl/brcm,nsp-gpio.txt
>> new file mode 100644
>> index 0000000..bea4211
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pinctrl/brcm,nsp-gpio.txt
>> @@ -0,0 +1,80 @@
>> +Broadcom Northstar plus (NSP) GPIO/PINCONF Controller
>> +
>> +Required properties:
>> +- compatible:
>> +    Must be "brcm,nsp-gpio-a"
>> +
>> +- reg:
>> +    Should contain the register physical address and length for each of
>> +    GPIO base, IO control registers
>> +
>> +- #gpio-cells:
>> +    Must be two. The first cell is the GPIO pin number (within the
>> +    controller's pin space) and the second cell is used for the following:
>> +    bit[0]: polarity (0 for active high and 1 for active low)
>> +
>> +- gpio-controller:
>> +    Specifies that the node is a GPIO controller
>> +
>> +- ngpios:
>> +    Number of gpios supported (58x25 supports 32 and 58x23 supports 24)
>
> 2 chips? You should have 2 compatible strings. I think this is incorrect
> use of ngpios which AIUI is not for how many lines there are, but how
> many can be used (e.g. not reserved).
>

I believe this is the identical GPIO controller IP that is integrated 
into two different SoC chip variants. The only difference is the 
supported number of GPIO pins.

In this case, I believe this is what Linus prefers: 1) Using a single 
compatible string (tied to the GPIO controller IP); 2) Addressing 
difference in number of GPIOs using DT property 'ngpios'.

Thanks,

Ray
