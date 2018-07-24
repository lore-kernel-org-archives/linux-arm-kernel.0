From: icenowy@aosc.io (Icenowy Zheng)
Date: Tue, 24 Jul 2018 16:57:25 +0800
Subject: [PATCH 2/3] arm64: allwinner: dts: h6: add pinmux for MMC1
In-Reply-To: <20180724085639.2cebno52qfxrzmdw@flea>
References: <20180724011551.49603-1-icenowy@aosc.io>
 <20180724011551.49603-3-icenowy@aosc.io>
 <20180724085639.2cebno52qfxrzmdw@flea>
Message-ID: <6F2D0379-C4D1-49AA-B089-7FFE27258E79@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018?7?24? GMT+08:00 ??4:56:39, Maxime Ripard <maxime.ripard@bootlin.com> ??:
>On Tue, Jul 24, 2018 at 09:15:50AM +0800, Icenowy Zheng wrote:
>> The MMC1 controller on H6, in the reference design and most third
>party
>> design, is used to connect SDIO Wi-Fi.
>> 
>> Add pinmux for it.
>> 
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>> 
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>> index cfa5fffcf62b..ba1a3a3e2149 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
>> @@ -134,6 +134,14 @@
>>  				bias-pull-up;
>>  			};
>>  
>> +			mmc1_pins: mmc1-pins {
>> +				pins = "PG0", "PG1", "PG2", "PG3",
>> +				       "PG4", "PG5";
>> +				function = "mmc1";
>> +				drive-strength = <30>;
>> +				bias-pull-up;
>> +			};
>> +
>
>Is that the sole muxing option for MMC1? If so, it should be added to
>the mmc1 node.

Oh... yes, it is.

Will do in v2.

>
>Maxime
