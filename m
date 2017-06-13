From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 13 Jun 2017 12:10:29 +0200
Subject: [PATCH 3/4] arm64: dts: marvell: Enable second SDHCI controller
 in Armada 37xx
In-Reply-To: <20170608211702.27a7b560@free-electrons.com> (Thomas Petazzoni's
 message of "Thu, 8 Jun 2017 21:17:02 +0200")
References: <20170608165125.27630-1-gregory.clement@free-electrons.com>
 <20170608165125.27630-4-gregory.clement@free-electrons.com>
 <20170608211702.27a7b560@free-electrons.com>
Message-ID: <87tw3k8aga.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On jeu., juin 08 2017, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> Hello,
>
> On Thu,  8 Jun 2017 18:51:24 +0200, Gregory CLEMENT wrote:
>
>> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
>> index 4d495ec39202..01a9c30be38d 100644
>> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
>> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
>> @@ -292,6 +292,17 @@
>>  				};
>>  			};
>>  
>> +			sdhci1: sdhci at d0000 {
>> +				compatible = "marvell,armada-3700-sdhci",
>> +				"marvell,sdhci-xenon";
>
> One more tab on this second line would be nice.

I agree but and I will aligned all the other entries too in a separate patch.

>
>> +				reg = <0xd0000 0x300
>> +				       0x1e808 0x4>;
>
> I'd prefer:
>
> 				reg = <0xd0000 0x300>, <0x1e808 0x4>;

For this one I think it is a matter of taste. I had a look on the other
files and it seems more common to put them on multi lines that on one
single line. And personally I prefer it, for me it seems more visible
that we use 2 set of registers.

So I will keep it.

Thanks,

Gregory

>
> Best regards,
>
> Thomas
> -- 
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
