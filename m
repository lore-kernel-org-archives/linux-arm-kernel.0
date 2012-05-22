From: ludovic.desroches@atmel.com (ludovic.desroches)
Date: Tue, 22 May 2012 16:41:35 +0200
Subject: [PATCH v3 3/3] ARM: dts: add nodes for atmel hsmci controllers
 for atmel platforms
In-Reply-To: <20120522141348.GC3377@game.jcrosoft.org>
References: <1337681352-18521-1-git-send-email-ludovic.desroches@atmel.com>
 <1337681352-18521-4-git-send-email-ludovic.desroches@atmel.com>
 <20120522141348.GC3377@game.jcrosoft.org>
Message-ID: <4FBBA59F.3000804@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 05/22/2012 04:13 PM, Jean-Christophe PLAGNIOL-VILLARD a ?crit :
> On 12:09 Tue 22 May     , ludovic.desroches at atmel.com wrote:
>> From: Ludovic Desroches<ludovic.desroches@atmel.com>
>>
>> Add nodes for mci controllers.
>>
>> Signed-off-by: Ludovic Desroches<ludovic.desroches@atmel.com>
>> ---
>>   arch/arm/boot/dts/at91sam9g20.dtsi     |   12 ++++++++++++
>>   arch/arm/boot/dts/at91sam9g25ek.dts    |   16 ++++++++++++++++
>>   arch/arm/boot/dts/at91sam9g45.dtsi     |   24 ++++++++++++++++++++++++
>>   arch/arm/boot/dts/at91sam9m10g45ek.dts |   17 +++++++++++++++++
>>   arch/arm/boot/dts/at91sam9x5.dtsi      |   24 ++++++++++++++++++++++++
>>   5 files changed, 93 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
>> index 773ef48..6a28bfe 100644
>> --- a/arch/arm/boot/dts/at91sam9g20.dtsi
>> +++ b/arch/arm/boot/dts/at91sam9g20.dtsi
>> @@ -197,6 +197,18 @@
>>   				interrupts =<10 4>;
>>   				status = "disabled";
>>   			};
>> +
>> +			mmc0: mmc at fffa800 {
>> +				compatible = "atmel,hsmci";
>> +				reg =<0xfffa800 0x600>;
>> +				interrupts =<9 4>;
>> +				status = "disabled";
>> +				#address-cells =<1>;
>> +				#size-cells =<0>;
>> +				slot at 0 {
>> +					reg =<0>;
>> +				};
>> +			};
> this need to be in 9260.dtsi
>
> if you add the board too plese add all of them
> or seperate the commits
>

I based it on 3.4 so 9260.dtsi was not present. Nicolas gave me a new 
branch with it so I will add mmc node to 9260.

Regards

Ludovic
