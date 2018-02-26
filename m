From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 26 Feb 2018 09:22:06 +0200
Subject: [PATCH] ARM: ds: keystone-k2g: add watchdog support
In-Reply-To: <1e1b645d-2829-8809-61b5-3906fd24c02a@oracle.com>
References: <1518623703-24529-1-git-send-email-t-kristo@ti.com>
 <1e1b645d-2829-8809-61b5-3906fd24c02a@oracle.com>
Message-ID: <643467a8-5158-e178-0b45-2fe6ba866499@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/02/18 01:40, Santosh Shilimkar wrote:
> s/ds/dts

Oops, sorry about the typo. Do you want new patch posted or do you fix 
it locally?

-Tero

> 
> On 2/14/2018 7:55 AM, Tero Kristo wrote:
>> Add a watchdog node for keystone-k2g, with the corresponding clock and
>> power domain handles.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> ---
>> ? arch/arm/boot/dts/keystone-k2g.dtsi | 7 +++++++
>> ? 1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi 
>> b/arch/arm/boot/dts/keystone-k2g.dtsi
>> index fd06171..ca94221 100644
>> --- a/arch/arm/boot/dts/keystone-k2g.dtsi
>> +++ b/arch/arm/boot/dts/keystone-k2g.dtsi
>> @@ -583,5 +583,12 @@
>> ????????????? power-domains = <&k2g_pds 0x0013>;
>> ????????????? clocks = <&k2g_clks 0x0013 0>;
>> ????????? };
>> +
>> +??????? wdt: wdt at 02250000 {
>> +??????????? compatible = "ti,keystone-wdt", "ti,davinci-wdt";
>> +??????????? reg = <0x02250000 0x80>;
>> +??????????? power-domains = <&k2g_pds 0x22>;
>> +??????????? clocks = <&k2g_clks 0x22 0>;
>> +??????? };
>> ????? };
>> ? };
>>

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
