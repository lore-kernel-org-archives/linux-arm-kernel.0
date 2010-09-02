From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Thu, 2 Sep 2010 21:18:53 +0200
Subject: [PATCH 31/74] ST SPEAr: Adding support for SSP PL022
In-Reply-To: <447e0086df5d9eac78a2fc4ccf7ad51ecbed0232.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<447e0086df5d9eac78a2fc4ccf7ad51ecbed0232.1283161023.git.viresh.kumar@st.com>
Message-ID: <AANLkTi=Fiv2i4qMcrnOeECkMKtNathO9P906=T1gcFPB@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/8/30 Viresh KUMAR <viresh.kumar@st.com>:

> (...)
> diff --git a/arch/arm/mach-spear13xx/spear1300_evb.c b/arch/arm/mach-spear13xx/spear1300_evb.c
> (...)
> +/* Currently no gpios are free on eval board so it is kept commented */
> +#if 0

Argh!

> +/* spi board information */
> +/* spi0 flash Chip Select Control function, controlled by gpio pin mentioned */
> +DECLARE_SPI_CS_CONTROL(0, flash, /* mention gpio number here */);
> +/* spi0 flash Chip Info structure */
> +DECLARE_SPI_CHIP_INFO(0, flash, spi0_flash_cs_control);
> +
> +/* spi0 spidev Chip Select Control function, controlled by gpio pin mentioned */
> +DECLARE_SPI_CS_CONTROL(0, dev, /* mention gpio number here */);
> +/* spi0 spidev Chip Info structure */
> +DECLARE_SPI_CHIP_INFO(0, dev, spi0_dev_cs_control);
> +#endif
> +
> +static struct spi_board_info __initdata spi_board_info[] = {
> +#if 0

And again!

> + ? ? ? /* spi0 board info */
> + ? ? ? {
> + ? ? ? ? ? ? ? .modalias = "spidev",
> + ? ? ? ? ? ? ? .controller_data = &spi0_dev_chip_info,
> + ? ? ? ? ? ? ? .max_speed_hz = 10000000,
> + ? ? ? ? ? ? ? .bus_num = 0,
> + ? ? ? ? ? ? ? .chip_select = 0,
> + ? ? ? ? ? ? ? .mode = 0,
> + ? ? ? }, {
> + ? ? ? ? ? ? ? .modalias = "m25p80",
> + ? ? ? ? ? ? ? .controller_data = &spi0_flash_chip_info,
> + ? ? ? ? ? ? ? .max_speed_hz = 1000000,
> + ? ? ? ? ? ? ? .bus_num = 0,
> + ? ? ? ? ? ? ? .chip_select = 1,
> + ? ? ? ? ? ? ? .mode = 0,
> + ? ? ? }
> +#endif

Don't commit commented-out code.

> (...)
> diff --git a/arch/arm/mach-spear3xx/spear300_evb.c b/arch/arm/mach-spear3xx/spear300_evb.c
> (...)
> +/*
> + * Chip select of spidev, currently no gpio is free on eval board so it is kept
> + * commented
> + */
> +#if 0

Again!

> (...)
> +static struct spi_board_info __initdata spi_board_info[] = {
> + ? ? ? /* spi0 board info */
> + ? ? ? {
> +#if 0

And again!

> + ? ? ? ? ? ? ? .modalias = "spidev",
> + ? ? ? ? ? ? ? .controller_data = &spi0_dev_chip_info,
> + ? ? ? ? ? ? ? .max_speed_hz = 10000000,
> + ? ? ? ? ? ? ? .bus_num = 0,
> + ? ? ? ? ? ? ? .chip_select = 0,
> + ? ? ? ? ? ? ? .mode = 0,
> + ? ? ? }, {
> +#endif

Please grep your code for all #if 0 and remove it.

Yours,
Linus Walleij
