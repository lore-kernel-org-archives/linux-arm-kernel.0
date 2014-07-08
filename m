From: fkan@apm.com (Feng Kan)
Date: Tue, 8 Jul 2014 15:54:55 -0700
Subject: [PATCH V5 2/3] Documentation: gpio: Add APM X-Gene SoC GPIO
 controller DTS binding
In-Reply-To: <20140630125339.GA21390@leverpostej>
References: <1403823587-23404-1-git-send-email-fkan@apm.com>
 <1403823587-23404-3-git-send-email-fkan@apm.com>
 <20140630125339.GA21390@leverpostej>
Message-ID: <CAL85gmDug-RHV+6gttLkDg+rM5PPHGew9KuX4SNbk9V3qE01=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 5:53 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Thu, Jun 26, 2014 at 11:59:46PM +0100, Feng Kan wrote:
>> Documentation for APM X-Gene SoC GPIO controller DTS binding.
>>
>> Signed-off-by: Feng Kan <fkan@apm.com>
>> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>>  .../devicetree/bindings/gpio/gpio-xgene.txt          | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-xgene.txt
>>
>> diff --git a/Documentation/devicetree/bindings/gpio/gpio-xgene.txt b/Documentation/devicetree/bindings/gpio/gpio-xgene.txt
>> new file mode 100644
>> index 0000000..bd5fd85
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/gpio/gpio-xgene.txt
>> @@ -0,0 +1,20 @@
>> +APM X-Gene SoC GPIO controller bindings
>> +
>> +This is a gpio controller that is part of the flash controller.
>> +This gpio controller controls a total of 48 gpios.
>> +
>> +Required properties:
>> +- compatible: "apm,xgene-gpio" for X-Gene GPIO controller
>> +- reg: Physical base address and size of the controller's registers
>
> There is just the one bank?

Internally there are three banks. Due to the fact the address space is
meshed, It was agreed that we turn this into one simple node.

>
>> +- #gpio-cells: Should be two.
>> +     - first cell is the pin number
>> +     - second cell is used to specify optional parameters (unused)
>
> Why is there an unused cell?
>
> Why not just make this a single cell if the binding defines no valid
> parameters?
I will update documentation to indicate second cell is used for active low and
active high setting since that is the behavior of the default of_xlate
function. All it is
seems to be doing is flipping the value of the gpio. I initially did
this because I
did not want to use additional attributes and followed the example
documentation of
number of other gpio driver.
>
>> +- gpio-controller: Marks the device node as a GPIO controller.
>
> No interrupts?

Yes, no interrupts in this block.
>
> Thanks,
> Mark.
>
>> +
>> +Example:
>> +     gpio0: gpio0 at 1701c000 {
>> +             compatible = "apm,xgene-gpio";
>> +             reg = <0x0 0x1701c000 0x0 0x40>;
>> +             gpio-controller;
>> +             #gpio-cells = <2>;
>> +     };
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
