From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 09 Jul 2015 15:20:19 +0200
Subject: [PATCH 2/3] ARM: mvebu: update EEPROM description of Armada 388 GP
In-Reply-To: <55913F0E.6080604@free-electrons.com>
References: <1434631121-32014-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1434631121-32014-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <55913F0E.6080604@free-electrons.com>
Message-ID: <559E7513.7080307@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 29/06/2015 14:50, Gregory CLEMENT wrote:
> Hi Thomas,
> 
> On 18/06/2015 14:38, Thomas Petazzoni wrote:
>> Contrary to what the Device Tree indicates, the EEPROM at 0x54 is not
>> populated, so we get rid of this comment.
>>
>> However, there is an EEPROM at 0x57, so we add support for this
>> AT24C64 EEPROM:
>>
>> $ hexdump -C /sys/bus/i2c/devices/0-0057/eeprom
>> 00000000  0c ff f3 ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
>> 00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
>> *
>> 00002000
>>
>> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> 
> Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> 

applied on mvebu/dt

Thanks,

Gregory
> 
> Thanks,
> 
> Gregory
> 
>> ---
>>  arch/arm/boot/dts/armada-388-gp.dts | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/armada-388-gp.dts b/arch/arm/boot/dts/armada-388-gp.dts
>> index 5164b9a..fc1ee3e 100644
>> --- a/arch/arm/boot/dts/armada-388-gp.dts
>> +++ b/arch/arm/boot/dts/armada-388-gp.dts
>> @@ -81,10 +81,6 @@
>>  				pinctrl-0 = <&i2c0_pins>;
>>  				status = "okay";
>>  				clock-frequency = <100000>;
>> -				/*
>> -				 * The EEPROM located at adresse 54 is needed
>> -				 * for the boot - DO NOT ERASE IT -
>> -				 */
>>  
>>  				expander0: pca9555 at 20 {
>>  					compatible = "nxp,pca9555";
>> @@ -111,6 +107,10 @@
>>  					reg = <0x21>;
>>  				};
>>  
>> +				eeprom at 57 {
>> +					compatible = "atmel,24c64";
>> +					reg = <0x57>;
>> +				};
>>  			};
>>  
>>  			serial at 12000 {
>>
> 
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
