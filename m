From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 8 Sep 2014 19:48:05 +0200
Subject: [PATCH] clk: efm32: fix build warning
In-Reply-To: <3456522.oqa7pbstSD@wuerfel>
References: <3456522.oqa7pbstSD@wuerfel>
Message-ID: <20140908174805.GL23009@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 08, 2014 at 05:19:40PM +0200, Arnd Bergmann wrote:
> The normal prototype for of clk init functions is to return void,
> while efm32gg_cmu_init return an int, resulting in this harmless
> build warning:
> 
> drivers/clk/clk-efm32gg.c:81:189: warning: comparison of distinct pointer types lacks a cast [enabled by default]
>  CLK_OF_DECLARE(efm32ggcmu, "efm32gg,cmu", efm32gg_cmu_init);
> 
> This changes the return type to avoid the warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
I already sent the exact same patch some time ago, even the sha1 sums in
the diff match.

	Subject: [PATCH] clk/efm32gg: fix dt init prototype
	Message-Id: <1406558301-17866-1-git-send-email-u.kleine-koenig@pengutronix.de>
	Date: Mon, 28 Jul 2014 16:38:21 +0200

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
