From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 23 Feb 2018 14:51:29 +0100
Subject: [PATCH v2 3/9] serial: imx: Fix out-of-bounds access through
 serial port index
In-Reply-To: <1519393117-31998-4-git-send-email-geert+renesas@glider.be>
References: <1519393117-31998-1-git-send-email-geert+renesas@glider.be>
 <1519393117-31998-4-git-send-email-geert+renesas@glider.be>
Message-ID: <20180223135129.lvk3rgepyuik7a2y@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 23, 2018 at 02:38:31PM +0100, Geert Uytterhoeven wrote:
> The imx_ports[] array is indexed using a value derived from the
> "serialN" alias in DT, or from platform data, which may lead to an
> out-of-bounds access.
> 
> Fix this by adding a range check.
> 
> Fixes: ff05967a07225ab6 ("serial/imx: add of_alias_get_id() reference back")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Thanks for your time
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
