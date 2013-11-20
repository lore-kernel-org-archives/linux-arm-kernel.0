From: b.brezillon@overkiz.com (boris brezillon)
Date: Wed, 20 Nov 2013 17:17:06 +0100
Subject: [PATCH 7/9] ARM: at91/dt: add i2c devices connected to
 at91rm9200ek board
In-Reply-To: <20131120150132.GG14627@ns203013.ovh.net>
References: <1377687640-10529-1-git-send-email-b.brezillon@overkiz.com>
 <1377688107-10830-1-git-send-email-b.brezillon@overkiz.com>
 <20131120150132.GG14627@ns203013.ovh.net>
Message-ID: <528CE082.2000400@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/11/2013 16:01, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 13:08 Wed 28 Aug     , Boris BREZILLON wrote:
>> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
>> ---
>>   arch/arm/boot/dts/at91rm9200ek.dts |   12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/at91rm9200ek.dts b/arch/arm/boot/dts/at91rm9200ek.dts
>> index b3e7425..fd2601a 100644
>> --- a/arch/arm/boot/dts/at91rm9200ek.dts
>> +++ b/arch/arm/boot/dts/at91rm9200ek.dts
>> @@ -147,6 +147,18 @@
>>   		};
>>   	};
>>   
>> +	i2c at 0 {
>> +		status = "okay";
>> +
>> +		ics1523 at 26 {
>> +			reg = <0x26>;
>> +		};
>> +
>> +		dac3550 at 4d {
>> +			reg = <0x4d>;
> missing compatible

I can't find any matching compatible for these devices.
Do you know what should be used ?

>> +		};
>> +	};
>> +
>>   	leds {
>>   		compatible = "gpio-leds";
>>   
>> -- 
>> 1.7.9.5
>>
