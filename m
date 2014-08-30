From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 30 Aug 2014 21:08:16 +0100
Subject: [PATCH v6 2/2] dt-bindings: document Rockchip saradc
In-Reply-To: <1737237.SiLPTrUivB@diego>
References: <1984475.34C1XMW1q3@diego> <8132020.MqcOnlblHg@diego>
 <53E38A18.5090203@kernel.org> <1737237.SiLPTrUivB@diego>
Message-ID: <54022F30.8070001@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/08/14 13:41, Heiko St?bner wrote:
> Am Donnerstag, 7. August 2014, 15:15:52 schrieb Jonathan Cameron:
>> On 23/07/14 22:24, Heiko St?bner wrote:
>>> This add the necessary binding documentation for the saradc found in all
>>> recent processors from Rockchip.
>>>
>>> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>>
>> Applied to the togreg branch of iio.git.
>> I have exercised a small amount of discretion wrt to the standard 3 weeks
>> as there really is very little different in here from previous versions
>> and no one has raised any comments on them.
> 
> Did the binding patch make it into any tree? Because when I grep for saradc in 
> either linux-next or the iio tree I only get patch 1/2 (the driver itself) but 
> the binding document is somehow missing.
Good spot.  Interestingly I had the file in my local tree but not the commit.
Odd, but now applied to the togreg branch of iio.git and pushed out.

Sorry about that!

Jonathan
> 
> 
> Thanks
> Heiko
> 
> 
>>
>> It's nearly 3 weeks anyway!
>>
>> J
>>
>>> ---
>>> changes since v5:
>>> - remove clock-frquency property as described in patch 1/2
>>>
>>>  .../bindings/iio/adc/rockchip-saradc.txt           | 24
>>>  ++++++++++++++++++++++ 1 file changed, 24 insertions(+)
>>>  create mode 100644
>>>  Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt> 
>>> diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
>>> b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt new file
>>> mode 100644
>>> index 0000000..5d3ec1d
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
>>> @@ -0,0 +1,24 @@
>>> +Rockchip Successive Approximation Register (SAR) A/D Converter bindings
>>> +
>>> +Required properties:
>>> +- compatible: Should be "rockchip,saradc"
>>> +- reg: physical base address of the controller and length of memory
>>> mapped
>>> +       region.
>>> +- interrupts: The interrupt number to the cpu. The interrupt specifier
>>> format +              depends on the interrupt controller.
>>> +- clocks: Must contain an entry for each entry in clock-names.
>>> +- clock-names: Shall be "saradc" for the converter-clock, and "apb_pclk"
>>> for +               the peripheral clock.
>>> +- vref-supply: The regulator supply ADC reference voltage.
>>> +- #io-channel-cells: Should be 1, see ../iio-bindings.txt
>>> +
>>> +Example:
>>> +	saradc: saradc at 2006c000 {
>>> +		compatible = "rockchip,saradc";
>>> +		reg = <0x2006c000 0x100>;
>>> +		interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
>>> +		clocks = <&cru SCLK_SARADC>, <&cru PCLK_SARADC>;
>>> +		clock-names = "saradc", "apb_pclk";
>>> +		#io-channel-cells = <1>;
>>> +		vref-supply = <&vcc18>;
>>> +	};
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
