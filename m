From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 14 May 2018 10:01:55 +0200
Subject: [PATCH] ARM: dts: exynos: Use dedicated DT bindings for Odroid
 X/X2, U3
In-Reply-To: <20180513122412.shxdxtxt2phb46l5@kozik-lap>
References: <CGME20180511081032epcas2p30f381cf699cb7524d9a143390e9c74b5@epcas2p3.samsung.com>
 <20180511080947.3057-1-s.nawrocki@samsung.com>
 <20180513122412.shxdxtxt2phb46l5@kozik-lap>
Message-ID: <1ac92405-897a-d16b-13a2-e968c687b07d@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/2018 02:24 PM, Krzysztof Kozlowski wrote:
> On Fri, May 11, 2018 at 10:09:47AM +0200, Sylwester Nawrocki wrote:
>> Use dedicated Odroid audio subsystem DT bindings instead of the simple-card.
>> This adds support for audio on the HDMI interface.

> How about changing the subject to "Add suppor for audio over HDMI for
> Odroid X/X2/U3"?

Sure, I don't mind.

>> diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
>> index bdcd4523cc1c..7a94a423097d 100644
>> --- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
>> +++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
>> @@ -113,11 +113,12 @@
>>  };
>>  
>>  &sound {
>> -	simple-audio-card,name = "Odroid-U3";
>> -	simple-audio-card,widgets =
>> +	compatible = "hardkernel,odroid-xu4-audio";

> The compatible is the same for all users using DTSI so it could be moved
> to the exynos4412-odroid-common.dtsi itself.

Corrected.

-- 
Regards,
Sylwester
