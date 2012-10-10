From: vipin.kumar@st.com (Vipin Kumar)
Date: Wed, 10 Oct 2012 16:03:05 +0530
Subject: [PATCH 10/11] fsmc/nand: Add sw bch support for ecc
 calculation/correction
In-Reply-To: <20121009115023.GK12801@game.jcrosoft.org>
References: <cover.1349778820.git.vipin.kumar@st.com>
 <3968b65e9aa0a81eca16ce0f20e45504da7ad7fe.1349778821.git.vipin.kumar@st.com>
 <20121009115023.GK12801@game.jcrosoft.org>
Message-ID: <50754EE1.7080905@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/9/2012 5:20 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 16:14 Tue 09 Oct     , Vipin Kumar wrote:
>> Signed-off-by: Vipin Kumar<vipin.kumar@st.com>
>> ---
>>   .../devicetree/bindings/mtd/fsmc-nand.txt          |   2 +
>>   drivers/mtd/nand/fsmc_nand.c                       | 156 +++++++++++++--------
>>   include/linux/mtd/fsmc.h                           |   3 +
>>   3 files changed, 106 insertions(+), 55 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/fsmc-nand.txt b/Documentation/devicetree/bindings/mtd/fsmc-nand.txt
>> index 598bca2..dcf513b 100644
>> --- a/Documentation/devicetree/bindings/mtd/fsmc-nand.txt
>> +++ b/Documentation/devicetree/bindings/mtd/fsmc-nand.txt
>> @@ -30,6 +30,8 @@ Optional properties:
>>   - st,rb-gpios: When the st,ready-busy is defined as "rb-gpio", a gpio
>>     pin number is defined in this property
>>
>> +- nand-sw-ecc: boolean indicating whether s/w ecc is supported
>> +
> please use the generic binding
>   - nand-ecc-mode = xx

Thanks for pointing. I will do the needful

>>   Example:
>>
>>   	fsmc: flash at d1800000 {
>> diff --git a/drivers/mtd/nand/fsmc_nand.c b/drivers/mtd/nand/fsmc_nand.c
>> index 762cf83..ff84468 100644
>> --- a/drivers/mtd/nand/fsmc_nand.c
>> +++ b/drivers/mtd/nand/fsmc_nand.c
>> @@ -946,6 +946,9 @@ static int __devinit fsmc_nand_probe_config_dt(struct platform_device *pdev,
>>   	} else
>>   		pdata->rbpin.use_pin = FSMC_RB_WAIT;
>>
>> +	if (of_property_read_bool(np, "nand-sw-ecc"))
>> +		pdata->sw_ecc = true;
>> +
> of_get_nand_ecc_mode
>

Sure

-Vipin
