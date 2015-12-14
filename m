From: manabian@gmail.com (Joachim Eastwood)
Date: Mon, 14 Dec 2015 23:52:21 +0100
Subject: [PATCH 1/3] ARM: dts: lpc4337-ciaa: enable EEPROM memory
In-Reply-To: <5655A950.3000003@vanguardiasur.com.ar>
References: <1448282225-2635-1-git-send-email-ariel@vanguardiasur.com.ar>
 <1448282225-2635-2-git-send-email-ariel@vanguardiasur.com.ar>
 <5655A950.3000003@vanguardiasur.com.ar>
Message-ID: <CAGhQ9VzdWSoPbXv-pJUuz7GkM7PuYSz8+Np7Gz1h4MkXVzDeEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ariel,

On 25 November 2015 at 13:28, Ariel D'Alessandro
<ariel@vanguardiasur.com.ar> wrote:
> (+To: Joachim)
>
> El 23/11/15 a las 09:37, Ariel D'Alessandro escribi?:
>> The CIAA-NXP board has a NXP LPC4337 SoC that includes a 16 KiB
>> EEPROM memory.
>>
>> Signed-off-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
>> ---
>>  arch/arm/boot/dts/lpc4337-ciaa.dts | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/lpc4337-ciaa.dts b/arch/arm/boot/dts/lpc4337-ciaa.dts
>> index 5f500c1..03bdf77 100644
>> --- a/arch/arm/boot/dts/lpc4337-ciaa.dts
>> +++ b/arch/arm/boot/dts/lpc4337-ciaa.dts
>> @@ -155,6 +155,10 @@
>>       };
>>  };
>>
>> +&eeprom {
>> +     status = "okay";
>> +};
>> +

I already had a patch that enabled the eeprom for all boards that
included the lpc4357.dtsi from when I tested your driver. So opted to
use that patch instead of this one. This is really a SoC device
feature that doesn't require any board resources so I think it is
better to have this entry in lpc4357.dtsi.


regards,
Joachim Eastwood
