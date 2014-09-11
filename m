From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Thu, 11 Sep 2014 08:21:37 +0000
Subject: [PATCHv3 1/6] ARM: dts: Add SoC level device tree support for
 LS1021A
In-Reply-To: <4286278.g3iXMFknkK@wuerfel>
References: <1410253952-15631-1-git-send-email-jingchang.lu@freescale.com>
 <1410253952-15631-2-git-send-email-jingchang.lu@freescale.com>
 <4286278.g3iXMFknkK@wuerfel>
Message-ID: <e7cb3a48c52e4ef6a31119a9371c2bc4@BL2PR03MB467.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>-----Original Message-----
>From: Arnd Bergmann [mailto:arnd at arndb.de]
>Sent: Tuesday, September 09, 2014 7:50 PM
>To: linux-arm-kernel at lists.infradead.org
>Cc: Lu Jingchang-B35083; Guo Shawn-R65073; devicetree at vger.kernel.org;
>Zhao Chenhui-B35336; Fu Chao-B44548; Leekha Shaveta-B20052; Gupta Suresh-
>B42813; Sharma Bhupesh-B45370; Xiubo Li-B47053; Gupta Ruchika-R66431; Lu
>Jingchang-B35083; Badola Nikhil-B46172
>Subject: Re: [PATCHv3 1/6] ARM: dts: Add SoC level device tree support for
>LS1021A
>
>On Tuesday 09 September 2014 17:12:27 Jingchang Lu wrote:
>
>> +		dcfg: dcfg at 1ee0000 {
>> +			compatible = "fsl,ls1021a-dcfg";
>> +			reg = <0x0 0x1ee0000 0x0 0x10000>;
>> +		};
>> +		scfg: scfg at 1570000 {
>> +			compatible = "fsl,ls1021a-scfg";
>> +			reg = <0x0 0x1570000 0x0 0x10000>;
>> +		};
>
>Should these be marked as 'compatible = "syscon"' as well?
Yes, some driver may reference them by the syscon driver, 
I will add the "syscon" compatible for driver has another reference way, thanks.

>
>> +	dcsr {
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		compatible = "fsl,dcsr", "simple-bus";
>> +
>> +		ranges = <0x0 0x0 0x20000000 0x1000000>;
>> +
>> +		dcsr-epu at 0 {
>> +			compatible = "fsl,ls1021a-dcsr-epu";
>> +			reg = <0x0 0x10000>;
>> +		};
>
>The binding document only specifies a generic "fsl,dcsr-epu", not
>"fsl,ls1021a-dcsr-epu". It also mandates that "interrupts"
>must be present and contain three interrupt lines.
>
>Please fix either the DT or the binding, so they match.
>
>> +		dcsr-gdi at 100000 {
>> +			compatible = "fsl,ls1021a-dcsr-gdi";
>> +			reg = <0x100000 0x10000>;
>> +		};
>> +
>> +		dcsr-dddi at 120000 {
>> +			compatible = "fsl,ls1021a-dcsr-dddi";
>> +			reg = <0x120000 0x10000>;
>> +		};
>> +
>> +		dcsr-dcfg at 220000 {
>> +			compatible = "fsl,ls1021a-dcsr-dcfg";
>> +			reg = <0x220000 0x1000>;
>> +		};
>> +
>> +		dcsr-clock at 221000 {
>> +			compatible = "fsl,ls1021a-dcsr-clock";
>> +			reg = <0x221000 0x1000>;
>> +		};
>
>None of these are part of the dcsr.txt binding.
>
>> +		dcsr-rcpm at 222000 {
>> +			compatible = "fsl,ls1021a-dcsr-rcpm";
>> +			reg = <0x222000 0x1000 0x223000 0x1000>;
>> +		};
>
>Missing generic fsl,dcsr-rcpm compatible value again.
>
>> +		dcsr-ccp at 225000 {
>> +			compatible = "fsl,ls1021a-dcsr-ccp";
>> +			reg = <0x225000 0x1000>;
>> +		};
>
>I'm not checking any devices below this one, I assume they are mostly
>incomplete, so please go through the whole list and make sure they all
>match the documentation.
>I can't really find any code using the dcsr in Linux. Is there an out of
>tree driver that you plan to submit?
>
>	Arnd

I will remove these dcsr related nodes and leave them to be added later when
All ok. Thanks.


Best Regards,
Jingchang
