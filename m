From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Fri, 22 Aug 2014 10:21:18 +0000
Subject: [PATCHv2 4/6] dt-bindings: arm: add Freescale LS1021A SoC device
 tree binding
In-Reply-To: <53F495F1.60800@freescale.com>
References: <1407145148-29217-1-git-send-email-jingchang.lu@freescale.com>
 <1407145148-29217-5-git-send-email-jingchang.lu@freescale.com>
 <53F495F1.60800@freescale.com>
Message-ID: <1473bddb7bc142d086d529e755c741d8@BL2PR03MB467.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>-----Original Message-----
>From: Diana Craciun [mailto:diana.craciun at freescale.com]
>Sent: Wednesday, August 20, 2014 8:35 PM
>To: Lu Jingchang-B35083
>Cc: Guo Shawn-R65073; mark.rutland at arm.com; devicetree at vger.kernel.org;
>linux-arm-kernel at lists.infradead.org
>Subject: Re: [PATCHv2 4/6] dt-bindings: arm: add Freescale LS1021A SoC
>device tree binding
>
>On 08/04/2014 12:39 PM, Jingchang Lu wrote:
>> Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
>> ---
>>   Documentation/devicetree/bindings/arm/fsl.txt | 37
>+++++++++++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/fsl.txt
>> b/Documentation/devicetree/bindings/arm/fsl.txt
>> index e935d7d..c962124 100644
>> --- a/Documentation/devicetree/bindings/arm/fsl.txt
>> +++ b/Documentation/devicetree/bindings/arm/fsl.txt
>> @@ -74,3 +74,40 @@ Required root node properties:
>>   i.MX6q generic board
>>   Required root node properties:
>>       - compatible = "fsl,imx6q";
>> +
>> +
>> +Freescale LS1021A Platform Device Tree Bindings
>> +------------------------------------------------
>> +
>> +Required root node compatible properties:
>> +  - compatible = "fsl,ls1021a";
>> +
>> +SoC-specific device tree bindings for system configuration
>> +-------------------------------------------
>> +
>> +Required device node compatible properties:
>> +
>> +  - compatible = "fsl,ls1021a-scfg":
>> +	scfg is the supplemental configuration unit, provides SoC specific
>> +	configuration and status registers for the chip. There is no
>dedicate
>> +	driver for it, but for device whose configuration and status
>register
>> +	locates in this space should operate on it. Such as getting PEX port
>> +	status.
>> +
>> +  - compatible = "fsl,ls1021a-dcfg":
>> +	dcfg is the device configuration unit that provides general purpose
>> +	configuration and status for the device, there is no dedicate driver
>> +	for it, but for device whose configuration and status register
>locates
>> +	in this space should operate on it. Such as setting the secondary
>core
>> +	start address and release the secondary core from holdoff and
>startup.
>
>Is it that important to be mentioned in the binding that there is no
>driver for it? It seems to be just an implementation detail, the device
>tree describes the hardware not any particular implementation.
>
>> +
>> +Example:
>> +	scfg: scfg at 1570000 {
>> +		compatible = "fsl,ls1021a-scfg";
>> +		reg = <0x0 0x1570000 0x0 0x10000>;
>
>The reg is not part of the description above. I think that each of these
>nodes should be described separate, maybe something like this:
>
>Freescale SCFG
>
>scfg is the supplemental configuration unit, provides SoC specific
>configuration and status registers for the chip. There is no dedicate
>driver for it, but for device whose configuration and status register
>locates in this space should operate on it. Such as getting PEX port
>status.
Thanks, I will redescribe them.



Best Regards,
Jingchang
