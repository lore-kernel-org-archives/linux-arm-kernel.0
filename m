From: mcuos.com@gmail.com (Wan ZongShun)
Date: Fri, 18 Dec 2009 01:01:29 +0800
Subject: [PATCH] ARM: NUC900: Fix type error
In-Reply-To: <e68bb3470912162315t72f32a30h857778e66e4044c1@mail.gmail.com>
References: <8fb2581d0912162305l782a4fd6qb4641dc11b2d463d@mail.gmail.com>
	<e68bb3470912162315t72f32a30h857778e66e4044c1@mail.gmail.com>
Message-ID: <e68bb3470912170901l6a89a194x8a0a6ad656485f32@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

Would you please sent all your patches to my this mail address as
attached files?
I am going to do the integration.

2009/12/17 Wan ZongShun <mcuos.com@gmail.com>:
> 2009/12/17 Li Jie <eltshanli@gmail.com>:
>> Hi, Wan:
>>
>> When I compiling latest kernel code, I met following error:
>> ?CC ? ? ?arch/arm/mach-w90x900/dev.o
>> arch/arm/mach-w90x900/dev.c:200: error: variable
>> ?nuc900_spiflash_data? has initializer but incomplete type
>>
>
> Really? I think that I submitted it after building.
>
>> We should use nuc900_spi_info instead of w90p910_spi_info, right ?
>
> Okay, wait for me to check this later, if so, I am sorry for this mistake.
>
>> Signed-off-by: lijie <eltshanli@gmail.com>
>> ---
>> ?arch/arm/mach-w90x900/dev.c | ? ?2 +-
>> ?1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-w90x900/dev.c b/arch/arm/mach-w90x900/dev.c
>> index 51f17b7..ec711f4 100644
>> --- a/arch/arm/mach-w90x900/dev.c
>> +++ b/arch/arm/mach-w90x900/dev.c
>> @@ -197,7 +197,7 @@ static struct platform_device nuc900_device_emc = {
>>
>> ?/* SPI device */
>>
>> -static struct w90p910_spi_info nuc900_spiflash_data = {
>> +static struct nuc900_spi_info nuc900_spiflash_data = {
>> ? ? ? ?.num_cs ? ? ? ? = 1,
>> ? ? ? ?.lsb ? ? ? ? ? ?= 0,
>> ? ? ? ?.txneg ? ? ? ? ?= 1,
>> --
>> 1.6.5.4
>>
>
>
>
> --
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



-- 
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
