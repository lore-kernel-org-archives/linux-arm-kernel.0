From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 31 Jan 2018 11:12:20 +0200
Subject: [alsa-devel] [PATCH] sound/tlv320dac33: Add device tree support
In-Reply-To: <20180129232031.GA7695@lenoch>
References: <20180129230539.GA18280@amd> <20180129232031.GA7695@lenoch>
Message-ID: <f3f23e16-2045-78bd-b77e-f236cab3b85d@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2018-01-30 01:20, Ladislav Michl wrote:
> On Tue, Jan 30, 2018 at 12:05:39AM +0100, Pavel Machek wrote:
>>
>> This adds device tree support to tlv320dac33.c.
>>
>> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>>
>> diff --git a/Documentation/devicetree/bindings/sound/tlv320dac33.txt b/Documentation/devicetree/bindings/sound/tlv320dac33.txt
>> new file mode 100644
>> index 0000000..6cbd311
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/tlv320dac33.txt
>> @@ -0,0 +1,32 @@
>> +Texas Instruments - tlv320dac33 Codec module
>> +
>> +The tlv320dac33 serial control bus communicates through I2C protocols.
>> +
>> +Required properties:
>> +
>> +- compatible - "ti,tlv320dac33"
>> +- reg - I2C slave address
>> +
>> +Optional properties:
>> +
>> +- power-gpios - gpio pin to power the device, active high
> 
> While driver used gpio in platform data, isn't it more likely
> regulator which powers device?

It is GPIO, and according to the non public TRM it is connected to the
reset pin of the codec.

So the correct name should be reset-gpios

- P?ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
