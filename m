From: jic23@kernel.org (Jonathan Cameron)
Date: Sun, 11 Oct 2015 14:34:45 +0100
Subject: [PATCH 2/5] Documentation: add the binding file for Freescale
 imx7d ADC driver
In-Reply-To: <561A64B7.6000006@kernel.org>
References: <1444301948-21721-1-git-send-email-haibo.chen@freescale.com>
 <1444301948-21721-2-git-send-email-haibo.chen@freescale.com>
 <561A64B7.6000006@kernel.org>
Message-ID: <561A6575.5020905@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/10/15 14:31, Jonathan Cameron wrote:
> On 08/10/15 11:59, Haibo Chen wrote:
>> The patch adds the binding file for Freescale imx7d ADC driver.
>>
>> Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
> Couple of trivial typos..  otherwise fine.
>> ---
>>  .../devicetree/bindings/iio/adc/imx7d-adc.txt      | 26 ++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt b/Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt
>> new file mode 100644
>> index 0000000..6b21fd27
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/imx7d-adc.txt
>> @@ -0,0 +1,26 @@
>> +Freescale imx7d ADC bindings
>> +
>> +The devicetree bingdings are for the nwe ADC driver written for
>> +imx7d SoC.
> bindings and new
Actually I'd drop the new.  Makes sense in a patch comment, but
in the docs it'll rapidly stop being new.

>> +
>> +Required properties:
>> +- compatible: Should be "fsl,imx7d-adc"
>> +- reg: Offset and length of the register set for the ADC device
>> +- interrupts: The interrupt number for the ADC device
>> +- clocks: The root clock of the ADC controller
>> +- clock-names: Must contain "adc", matching entry in the clocks property
>> +- vref-supply: The regulator supply ADC reference voltage
>> +
>> +Optional properties:
>> +- num-channels: the number of channels used
>> +
>> +Example:
>> +adc1: adc at 30610000 {
>> +	compatible = "fsl,imx7d-adc";
>> +	reg = <0x30610000 0x10000>;
>> +	interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
>> +	clocks = <&clks IMX7D_ADC_ROOT_CLK>;
>> +	clock-names = "adc";
>> +	num-channels = <4>;
>> +	vref-supply = <&reg_vcc_3v3_mcu>;
>> +};
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
