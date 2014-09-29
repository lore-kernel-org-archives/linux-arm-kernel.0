From: grinberg@compulab.co.il (Igor Grinberg)
Date: Mon, 29 Sep 2014 13:21:04 +0300
Subject: [PATCH v3] ARM: DT: apq8064: add CM-QS600 board
In-Reply-To: <542927DA.9010507@compulab.co.il>
References: <1411749127-12746-1-git-send-email-mike.rapoport@gmail.com>
 <542927DA.9010507@compulab.co.il>
Message-ID: <54293290.3040507@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/29/14 12:35, Igor Grinberg wrote:
> Hi Mike,
> 
> On 09/26/14 19:32, Mike Rapoport wrote:
>> CM-QS600 is a APQ8064 based computer on module.
>> The details are available at
>> http://compulab.co.il/products/computer-on-modules/cm-qs600/
>>
>> Signed-off-by: Mike Rapoport <mike.rapoport@gmail.com>
> 
> Thanks for working on this!
> Some minor notes...
> 
> Can we have the subject aligned with other submissions, e.g.
> ARM: dts: qcom: ...
> ?
> 
>> ---
>> v2 changes: duplicate the settings for the cm-qs600 board in its .dts file as Kumar suggested
>> v3 changes: add board details and keep dts Makefile sorted alphabetically
> 
> [...]
> 
>> new file mode 100644
>> index 0000000..db7cf03
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
>> @@ -0,0 +1,59 @@
> 
> [...]
> 
>> +				eeprom: eeprom at 52 {
>> +					compatible = "atmel,24c128";
> 
> I believe the above should be 24c02.
> And the address is 0x50.

Also, atmel is not the only vendor for the eeprom chips we use,
so I think at24 instead of atmel will do better here.

> 
>> +					reg = <0x52>;
>> +					pagesize = <32>;
> 
> pagesize is 16.
> 
> [...]
> 
> Apart from the eeprom stuff above:
> 
> Acked-by: Igor Grinberg <grinberg@compulab.co.il>
> 

-- 
Regards,
Igor.
