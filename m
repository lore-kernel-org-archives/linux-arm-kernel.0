From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 16 Sep 2016 16:34:03 +0100
Subject: [PATCH] pcie: qcom: add support to msm8996 PCIE controller
In-Reply-To: <20160916141708.GA21504@rob-hp-laptop>
References: <1473246412-24616-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20160916141708.GA21504@rob-hp-laptop>
Message-ID: <73a5a49c-3adb-ffca-52b0-1de22aabe088@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the Review,

On 16/09/16 15:17, Rob Herring wrote:
> On Wed, Sep 07, 2016 at 12:06:52PM +0100, Srinivas Kandagatla wrote:
>

...

>>
>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>> index 4059a6f..1ddfcb4 100644
>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
>> @@ -92,6 +92,18 @@
...
>>  	Definition: A phandle and power domain specifier pair to the
>>  		    power domain which is responsible for collapsing
>> @@ -137,6 +156,11 @@
>>  	Definition: A phandle to the analog power supply for IC which generates
>>  		    reference clock
>>
>> +- vdda_1p8-supply:
>
> Don't use '_' in property names.

Will fix it and example to match these properties in next version.

>
>> +	Usage: required for msm8996/apq8096
>> +	Value type: <phandle>
>> +	Definition: A phandle to the analog power supply for PCIE_1P8
>> +
>>  - phys:
>>  	Usage: required for apq8084
>>  	Value type: <phandle>
>> @@ -231,3 +255,65 @@
>>  		pinctrl-0 = <&pcie0_pins_default>;
>>  		pinctrl-names = "default";
>>  	};
>> +
>> +* Example for apq8096:
>> +	pcie1: qcom,pcie at 00608000 {
>
> pcie at ...
Yep, will fix it in next version.
>
>> +		compatible = "qcom,pcie-msm8996", "snps,dw-pcie";
>> +		power-domains = <&gcc PCIE1_GDSC>;
>> +		bus-range = <0x00 0xff>;
>> +		num-lanes = <1>;
>> +
>> +		status  = "disabled";
>> +
>> +		reg = <0x00608000 0x2000>,
>> +		      <0x0d000000 0xf1d>,
>> +		      <0x0d000f20 0xa8>,
>> +		      <0x0d100000 0x100000>;
>> +
