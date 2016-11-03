From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Thu, 03 Nov 2016 17:42:30 +0900
Subject: [PATCH 09/13] mmc: dw_mmc: remove the "clock-freq-min-max"
 property
In-Reply-To: <20823767.hqlyMd1aKN@diego>
References: <20161103062135.10697-1-jh80.chung@samsung.com>
 <20161103062135.10697-10-jh80.chung@samsung.com>
 <CGME20161103082058epcas4p130e9419cefd2a5bb5626781d94acaa07@epcas4p1.samsung.com>
 <20823767.hqlyMd1aKN@diego>
Message-ID: <5e85773f-0af1-fcd9-1430-0a36c8f868b5@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko.

On 11/03/2016 05:20 PM, Heiko St?bner wrote:
> Hi Jaehoon,
> 
> Am Donnerstag, 3. November 2016, 15:21:31 schrieb Jaehoon Chung:
>> Remove the "clock-freq-min-max" property.
>> There is "max-frequency" property in drivers/mmc/core/host.c
>> It can be used for getting maximum frequency.
>>
>> And minimum clock value is assigned to 100K by default.
>> Because MMC core should check the initial clock value from
>> 400K to 100K until finding correct value.
>> It's why Minimum value puts 100K by default.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> ---
>>  Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt |  3 ---
>>  drivers/mmc/host/dw_mmc.c                                  | 13
>> ++++--------- 2 files changed, 4 insertions(+), 12 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
>> b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt index
>> 4e00e85..21c8251 100644
>> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
>> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
>> @@ -56,9 +56,6 @@ Optional properties:
>>    is specified and the ciu clock is specified then we'll try to set the ciu
>> clock to this at probe time.
>>
>> -* clock-freq-min-max: Minimum and Maximum clock frequency for card output
>> -  clock(cclk_out). If it's not specified, max is 200MHZ and min is 400KHz
>> by default. -
> 
> I'd think devicetree people will protest about simply removing this property 
> without deprecating it first - to be backwards compatible with old devicetrees.
> 
> Especially as this property was added already back in 2013, so has been in use 
> for quite some time.

Thanks for pointing out. I will resend the patchset with changing this.
And maintain the backwards compatible.

Best Regards,
Jaehoon Chung

> 
> 
> Heiko
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
