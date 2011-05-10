From: maxim.osipov@gmail.com (Maxim Osipov)
Date: Tue, 10 May 2011 11:04:00 +0100
Subject: [PATCH] AT91: Add external RTC for Flexibity board
In-Reply-To: <4DC53134.8070706@gmail.com>
References: <4DC53134.8070706@gmail.com>
Message-ID: <BANLkTi=DV4nrX2TBaXGCDHB5z2Z4=Q+pqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, May 7, 2011 at 12:47 PM, Maxim Osipov <maxim.osipov@gmail.com> wrote:
>
> This patch enables external RTC support on AT91 Flexibity board.
>
> Signed-off-by: Maxim Osipov <maxim.osipov@gmail.com>
> ---
> ?arch/arm/mach-at91/board-flexibity.c | ? 12 +++++++++++-
> ?1 files changed, 11 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-at91/board-flexibity.c b/arch/arm/mach-at91/board-flexibity.c
> index c8a62dc..4fdc96c 100644
> --- a/arch/arm/mach-at91/board-flexibity.c
> +++ b/arch/arm/mach-at91/board-flexibity.c
> @@ -1,7 +1,7 @@
> ?/*
> ?* linux/arch/arm/mach-at91/board-flexibity.c
> ?*
> - * ?Copyright (C) 2010 Flexibity
> + * ?Copyright (C) 2010-2011 Flexibity
> ?* ?Copyright (C) 2005 SAN People
> ?* ?Copyright (C) 2006 Atmel
> ?*
> @@ -65,6 +65,13 @@ static struct at91_udc_data __initdata flexibity_udc_data = {
> ? ? ? ?.pullup_pin ? ? = 0, ? ? ? ? ? ?/* pull-up driven by UDC */
> ?};
>
> +/* I2C devices */
> +static struct i2c_board_info __initdata flexibity_i2c_devices[] = {
> + ? ? ? {
> + ? ? ? ? ? ? ? I2C_BOARD_INFO("ds1307", 0x68),
> + ? ? ? },
> +};
> +
> ?/* SPI devices */
> ?static struct spi_board_info flexibity_spi_devices[] = {
> ? ? ? ?{ ? ? ? /* DataFlash chip */
> @@ -143,6 +150,9 @@ static void __init flexibity_board_init(void)
> ? ? ? ?at91_add_device_usbh(&flexibity_usbh_data);
> ? ? ? ?/* USB Device */
> ? ? ? ?at91_add_device_udc(&flexibity_udc_data);
> + ? ? ? /* I2C */
> + ? ? ? at91_add_device_i2c(flexibity_i2c_devices,
> + ? ? ? ? ? ? ? ARRAY_SIZE(flexibity_i2c_devices));
> ? ? ? ?/* SPI */
> ? ? ? ?at91_add_device_spi(flexibity_spi_devices,
> ? ? ? ? ? ? ? ?ARRAY_SIZE(flexibity_spi_devices));
> --
> 1.7.4.1
>
>

If no comments on the patch - could someone commit it please? Or
should I submit it to the Russell's patch tracking system?

Kind regards,
Maxim
