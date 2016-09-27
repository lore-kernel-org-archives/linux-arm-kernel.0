From: noralf@tronnes.org (=?UTF-8?Q?Noralf_Tr=c3=b8nnes?=)
Date: Tue, 27 Sep 2016 21:23:41 +0200
Subject: [PATCH v2 8/8] ARM: bcm2835: Disable i2c2 in the Device Tree
In-Reply-To: <256118042.194076.147d5d83-f402-4ba4-b7de-4ab57a0e29ad.open-xchange@email.1und1.de>
References: <1474977426-3272-1-git-send-email-noralf@tronnes.org>
 <1474977426-3272-9-git-send-email-noralf@tronnes.org>
 <256118042.194076.147d5d83-f402-4ba4-b7de-4ab57a0e29ad.open-xchange@email.1und1.de>
Message-ID: <72440b3c-526d-e7fb-bae1-69df6ef29a97@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Den 27.09.2016 19:25, skrev Stefan Wahren:
>> Noralf Tr?nnes <noralf@tronnes.org> hat am 27. September 2016 um 13:57
>> geschrieben:
>>
>>
>> i2c2 is connected to the HDMI connector and is controlled by the
>> firmware. Disable it to stay out of harms way.
> Until this point the commit message is okay, the rest is more confusing.
>
> Btw this should avoid a warning about missing clock frequency.
>
>>  From the downstream commit:
>> i2c-bcm2708/BCM270X_DT: Add support for I2C2
>>
>> The third I2C bus (I2C2) is normally reserved for HDMI use. Careless
>> use of this bus can break an attached display - use with caution.
>>
>> It is recommended to disable accesses by VideoCore by setting
>> hdmi_ignore_edid=1 or hdmi_edid_file=1 in config.txt.
>>
>> Signed-off-by: Noralf Tr?nnes <noralf@tronnes.org>
>> ---
>>   arch/arm/boot/dts/bcm2835-rpi.dtsi | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi
>> b/arch/arm/boot/dts/bcm2835-rpi.dtsi
>> index e9b47b2..8bffbee 100644
>> --- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
>> +++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
>> @@ -59,10 +59,6 @@
>>   	clock-frequency = <100000>;
>>   };
>>   
>> -&i2c2 {
>> -	status = "okay";
>> -};
>> -
> I'm not sure if this the right fix. According to bcm283x.dtsi the 3 i2c busses
> have the same compatible string "brcm,bcm2835-i2c", but the changelog suggests
> that this bus is "special".

I just rounded up all the differences from downstream that I knew about
into this patchset. But looking closer I see that the vc4 driver uses
i2c2. So I'll drop this patch.


Noralf.


> Shouldn't we use a different compatible string? Our intention isn't to disable
> i2c2 but avoid any claims of the usual i2c driver.
>
>>   &sdhci {
>>   	status = "okay";
>>   	bus-width = <4>;
>> -- 
>> 2.8.2
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
