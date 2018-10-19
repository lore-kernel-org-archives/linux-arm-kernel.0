From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 19 Oct 2018 09:12:43 +0200
Subject: [PATCH v1 2/3] i2c: imx: probe dma only only on i.MX50 and later.
In-Reply-To: <20181018112615.29362-3-o.rempel@pengutronix.de>
References: <20181018112615.29362-1-o.rempel@pengutronix.de>
 <20181018112615.29362-3-o.rempel@pengutronix.de>
Message-ID: <20181019071243.t5bwcmnnlqrgtajj@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Oleksij,

On Thu, Oct 18, 2018 at 01:26:14PM +0200, Oleksij Rempel wrote:
> The DMA support for I2C was introduced on i.MX50. So,
> avoid of DMA probing on not supported versions.

What is the obvious downside of trying to use DMA on i.MX21? If the
purpose is just to suppress the message

	can't request DMA tx channel

, that goes away with patch 3, too.

Note that if we agree that i.MX50 (and later) isn't compatible to
i.MX21, all device trees should be fixed accordingly. IMHO the
difference "There is a DMA engine connected only on some
implementations" doesn't give enough incentive to claim that i.MX21 and
i.MX50 must not share the compatible.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
