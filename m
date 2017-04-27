From: cyrille.pitchen@wedev4u.fr (Cyrille Pitchen)
Date: Thu, 27 Apr 2017 16:32:20 +0200
Subject: [PATCH] mtd: spi-nor: stm32: remove broken MODULE_ALIAS
In-Reply-To: <dc7d8b5e-0f0e-1593-4c6b-0c93a828818c@st.com>
References: <20170427111001.2587551-1-arnd@arndb.de>
 <dc7d8b5e-0f0e-1593-4c6b-0c93a828818c@st.com>
Message-ID: <48e14a7d-d105-3773-626f-04446a19254d@wedev4u.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 27/04/2017 ? 14:17, Ludovic BARRE a ?crit :
> thanks a lot Arnd
>

Indeed, thanks Arnd!

Since commit ("mtd: spi-nor: add driver for STM32 quad spi flash
controller") was included with the spi-nor PR for 4.12 I've sent
yesterday to Brian, I will check with him to know how he wants us to
proceed:

- If Brian has not started yet to review the PR and if he agrees on
that, I can rework a little bit the history in github/spi-nor to squash
Arnd's patch into Ludovic's one.
Ludovic's patch is already in linux-next but not yet in any release
candiate.

- or I can send an new PR keeping the fixup patch aside.

Best regards,

Cyrille


> Oops, I've not tested in Module :-(.
> Just tested in built-in, and used bind/unbind and device tree overlays.
> 
> BR
> Ludo
> On 04/27/2017 01:09 PM, Arnd Bergmann wrote:
>> The MODULE_ALIAS statement refers to a macro that has never been defined
>> in this driver, causing a build error:
>>
>> drivers/mtd/spi-nor/stm32-quadspi.c:694:150: error: expected ',' or
>> ';' before 'DRIVER_NAME'
>>
>> Unless there is a specific alias we need other then the driver name,
>> we don't need an alias here and can simply remove the line to fix the
>> build.
>>
>> Fixes: dc5e400611c5 ("mtd: spi-nor: add driver for STM32 quad spi
>> flash controller")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>   drivers/mtd/spi-nor/stm32-quadspi.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/mtd/spi-nor/stm32-quadspi.c
>> b/drivers/mtd/spi-nor/stm32-quadspi.c
>> index 90d9152ddf98..1056e7408d2a 100644
>> --- a/drivers/mtd/spi-nor/stm32-quadspi.c
>> +++ b/drivers/mtd/spi-nor/stm32-quadspi.c
>> @@ -691,7 +691,6 @@ static struct platform_driver stm32_qspi_driver = {
>>   };
>>   module_platform_driver(stm32_qspi_driver);
>>   -MODULE_ALIAS("platform:" DRIVER_NAME);
>>   MODULE_AUTHOR("Ludovic Barre <ludovic.barre@st.com>");
>>   MODULE_DESCRIPTION("STMicroelectronics STM32 quad spi driver");
>>   MODULE_LICENSE("GPL v2");
> 
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
> 
