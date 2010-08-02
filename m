From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 2 Aug 2010 07:26:54 +0200
Subject: [PATCH 01/11] ARM: cam60: move cam60_spi_devices to .init.data
In-Reply-To: <AANLkTi=hPg-12w9ihz-RsvD0d6Zawus14qF9hamA6nES@mail.gmail.com>
References: <1279915120-4373-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<AANLkTi=hPg-12w9ihz-RsvD0d6Zawus14qF9hamA6nES@mail.gmail.com>
Message-ID: <20100802052653.GA8538@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Sun, Aug 01, 2010 at 11:23:35PM +0200, avictor.za at gmail.com wrote:
> > cam60_spi_devices is passed to at91_add_device_spi which calls
> > spi_register_board_info. ?The latter makes a copy of it, so living in
> > .init.data is OK.
> 
> The  copy still maintains a pointers to
> "cam60_spi_flash_platform_data", so I'm wondering if that and
> "cam60_spi_partitions" should maybe not be marked as __initdata.
I think that's right, these need to be fixed up.  Thanks for noticing, I
will prepare a patch later today.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
