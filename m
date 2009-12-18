From: mcuos.com@gmail.com (Wan ZongShun)
Date: Sat, 19 Dec 2009 00:28:22 +0800
Subject: [PATCH] ARM: NUC900: Fix type error
In-Reply-To: <8fb2581d0912162305l782a4fd6qb4641dc11b2d463d@mail.gmail.com>
References: <8fb2581d0912162305l782a4fd6qb4641dc11b2d463d@mail.gmail.com>
Message-ID: <e68bb3470912180828s50c5a0f5t6f199231385c8719@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/12/17 Li Jie <eltshanli@gmail.com>:
> Hi, Wan:
>
> When I compiling latest kernel code, I met following error:
> ?CC ? ? ?arch/arm/mach-w90x900/dev.o
> arch/arm/mach-w90x900/dev.c:200: error: variable
> ?nuc900_spiflash_data? has initializer but incomplete type

Okay, tested by me, error occurs!

Russell, could you apply this patch to v2.6.33?

> We should use nuc900_spi_info instead of w90p910_spi_info, right ?
>
> Signed-off-by: lijie <eltshanli@gmail.com>
> ---
> ?arch/arm/mach-w90x900/dev.c | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-w90x900/dev.c b/arch/arm/mach-w90x900/dev.c
> index 51f17b7..ec711f4 100644
> --- a/arch/arm/mach-w90x900/dev.c
> +++ b/arch/arm/mach-w90x900/dev.c
> @@ -197,7 +197,7 @@ static struct platform_device nuc900_device_emc = {
>
> ?/* SPI device */
>
> -static struct w90p910_spi_info nuc900_spiflash_data = {
> +static struct nuc900_spi_info nuc900_spiflash_data = {
> ? ? ? ?.num_cs ? ? ? ? = 1,
> ? ? ? ?.lsb ? ? ? ? ? ?= 0,
> ? ? ? ?.txneg ? ? ? ? ?= 1,
> --
> 1.6.5.4
>



-- 
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
