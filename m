From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 03 Jan 2014 19:51:51 +0300
Subject: [PATCH 3/3] ARM: shmobile: Koelsch: Add QSPI support
In-Reply-To: <1388763256-25851-4-git-send-email-geert@linux-m68k.org>
References: <1388763256-25851-1-git-send-email-geert@linux-m68k.org>
 <1388763256-25851-4-git-send-email-geert@linux-m68k.org>
Message-ID: <52C6EAA7.7050200@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01/03/2014 06:34 PM, Geert Uytterhoeven wrote:

> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

> Enable support for the Spansion s25fl512s SPI FLASH on the Koelsch board:
>    - Add QSPI platform device, resources, platform data, and pinmux,
>    - Add FLASH data and MTD partitions.

> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> ---
>   arch/arm/mach-shmobile/board-koelsch.c |   61 ++++++++++++++++++++++++++++++++
>   1 file changed, 61 insertions(+)

> diff --git a/arch/arm/mach-shmobile/board-koelsch.c b/arch/arm/mach-shmobile/board-koelsch.c
> index de7cc64b1f37..723ed54b38be 100644
> --- a/arch/arm/mach-shmobile/board-koelsch.c
> +++ b/arch/arm/mach-shmobile/board-koelsch.c
[...]
> @@ -190,6 +246,11 @@ static void __init koelsch_add_standard_devices(void)
>   	platform_device_register_data(&platform_bus, "gpio-keys", -1,
>   				      &koelsch_keys_pdata,
>   				      sizeof(koelsch_keys_pdata));
> +	platform_device_register_resndata(&platform_bus, "qspi", 0,

    As I understood, there's single QSPI controller, so why you pass 0, and 
not -1 here?

> +					  qspi_resources,
> +					  ARRAY_SIZE(qspi_resources),
> +					  &qspi_pdata, sizeof(qspi_pdata));
> +	spi_register_board_info(spi_info, ARRAY_SIZE(spi_info));

WBR, Sergei
