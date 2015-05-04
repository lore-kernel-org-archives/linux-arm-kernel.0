From: g.portay@overkiz.com (=?UTF-8?B?R2HDq2wgUE9SVEFZ?=)
Date: Mon, 04 May 2015 18:08:28 +0200
Subject: [PATCH] ARM: at91/dt: drop deprecated mainck node from pmc
In-Reply-To: <20150416144553.1eed24dc@bbrezillon>
References: <1429187145-10741-1-git-send-email-g.portay@overkiz.com>
 <20150416144553.1eed24dc@bbrezillon>
Message-ID: <5547997C.3090501@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/04/2015 14:45, Boris Brezillon wrote:
> On Thu, 16 Apr 2015 14:25:44 +0200
> Ga?l PORTAY <g.portay@overkiz.com> wrote:
>
>> The clock-frequency property became obsolete since the rework of the main
>> clock driver in 3.16 (see commit 27cb1c2083373a44130d50d4d2fb64cf7eff2d90).
>>
>> It now get and uses the clock-frequency from the main_xtal node.
>>
>> Signed-off-by: Ga?l PORTAY <g.portay@overkiz.com>
> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
>
>> ---
>>   arch/arm/boot/dts/at91-sama5d3_xplained.dts | 6 ------
>>   arch/arm/boot/dts/at91sam9rlek.dts          | 6 ------
>>   arch/arm/boot/dts/sama5d3xcm.dtsi           | 6 ------
>>   3 files changed, 18 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
>> index fec1fca..1721e9b 100644
>> --- a/arch/arm/boot/dts/at91-sama5d3_xplained.dts
>> +++ b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
>> @@ -204,12 +204,6 @@
>>   					};
>>   				};
>>   			};
>> -
>> -			pmc: pmc at fffffc00 {
>> -				main: mainck {
>> -					clock-frequency = <12000000>;
>> -				};
>> -			};
>>   		};
>>   
>>   		nand0: nand at 60000000 {
>> diff --git a/arch/arm/boot/dts/at91sam9rlek.dts b/arch/arm/boot/dts/at91sam9rlek.dts
>> index 9be5b54..d9299be3 100644
>> --- a/arch/arm/boot/dts/at91sam9rlek.dts
>> +++ b/arch/arm/boot/dts/at91sam9rlek.dts
>> @@ -181,12 +181,6 @@
>>   				};
>>   			};
>>   
>> -			pmc: pmc at fffffc00 {
>> -				main: mainck {
>> -					clock-frequency = <12000000>;
>> -				};
>> -			};
>> -
>>   			watchdog at fffffd40 {
>>   				status = "okay";
>>   			};
>> diff --git a/arch/arm/boot/dts/sama5d3xcm.dtsi b/arch/arm/boot/dts/sama5d3xcm.dtsi
>> index 7d6babd..ef404e9 100644
>> --- a/arch/arm/boot/dts/sama5d3xcm.dtsi
>> +++ b/arch/arm/boot/dts/sama5d3xcm.dtsi
>> @@ -67,12 +67,6 @@
>>   					rxd3-skew-ps = <400>;
>>   				};
>>   			};
>> -
>> -			pmc: pmc at fffffc00 {
>> -				main: mainck {
>> -					clock-frequency = <12000000>;
>> -				};
>> -			};
>>   		};
>>   
>>   		nand0: nand at 60000000 {
>>

Hi everyone,

Any news about this patch ?

Best regards,
Ga?l PORTAY

PS: I hope this mail does not sound insistent :)
