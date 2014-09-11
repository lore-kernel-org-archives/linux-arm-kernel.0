From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Thu, 11 Sep 2014 08:58:40 +0000
Subject: [PATCHv3 1/6] ARM: dts: Add SoC level device tree support for
 LS1021A
In-Reply-To: <fa256d13e4304175b14369b9d3b55729@BL2PR03MB579.namprd03.prod.outlook.com>
References: <1410253952-15631-1-git-send-email-jingchang.lu@freescale.com>
 <1410253952-15631-2-git-send-email-jingchang.lu@freescale.com>
 <fa256d13e4304175b14369b9d3b55729@BL2PR03MB579.namprd03.prod.outlook.com>
Message-ID: <39a86eecae314626a8a2af76849171ea@BL2PR03MB467.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>-----Original Message-----
>From: Gupta Suresh-B42813
>Sent: Thursday, September 11, 2014 4:42 PM
>To: Lu Jingchang-B35083; Guo Shawn-R65073
>Cc: linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org; Lu
>Jingchang-B35083; Badola Nikhil-B46172; Zhao Chenhui-B35336; Leekha
>Shaveta-B20052; Gupta Ruchika-R66431; Sharma Bhupesh-B45370; Fu Chao-
>B44548; Xiubo Li-B47053; Lu Jingchang-B35083
>Subject: RE: [PATCHv3 1/6] ARM: dts: Add SoC level device tree support for
>LS1021A
>
>
>
>> -----Original Message-----
>> From: Jingchang Lu [mailto:jingchang.lu at freescale.com]
>> Sent: Tuesday, September 09, 2014 2:42 PM
>> To: Guo Shawn-R65073
>> Cc: linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org;
>> Lu Jingchang-B35083; Badola Nikhil-B46172; Zhao Chenhui-B35336; Gupta
>> Suresh- B42813; Leekha Shaveta-B20052; Gupta Ruchika-R66431; Sharma
>> Bhupesh- B45370; Fu Chao-B44548; Xiubo Li-B47053; Lu Jingchang-B35083
>> Subject: [PATCHv3 1/6] ARM: dts: Add SoC level device tree support for
>> LS1021A
>>
>> From: Jingchang Lu <b35083@freescale.com>
>>
>> Add Freescale LS1021A SoC device tree support
>>
>> +
>> +		usb at 3100000 {
>> +			compatible = "fsl,fsl-dwc3";
>> +			#address-cells = <2>;
>> +			#size-cells = <2>;
>> +			ranges;
>> +
>> +			dwc3 {
>> +				compatible = "snps,dwc3";
>> +				reg = <0x0 0x3100000 0x0 0x10000>;
>> +				interrupts = <GIC_SPI 93
>> IRQ_TYPE_LEVEL_HIGH>;
>> +				dr_mode = "host";
>> +				maximum-speed = "high-speed";
>> +			};
>> +		};
>> +	};
>> +
>> +
>[SuresH]  Can you please pick this node form ls1-linux -> ls1-dev branch
>This node should look like
>
>
>	usb3 at 3100000 {
>                        compatible = "snps,dwc3";
>                        reg = <0x0 0x3100000 0x0 0x10000>;
>                        interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
>                        dr_mode = "host";
>                };

Ok, I will update it in the next version.

Best Regards,
Jingchang
