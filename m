From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 9 Dec 2016 19:54:21 +0100
Subject: [PATCH v7 1/2] provide lock-less versions of clk_{enable|disable}
In-Reply-To: <1481302773-14181-1-git-send-email-abailon@baylibre.com>
References: <1481302773-14181-1-git-send-email-abailon@baylibre.com>
Message-ID: <20161209185421.fybpk4bdq6b7yglf@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Dec 09, 2016 at 05:59:32PM +0100, Alexandre Bailon wrote:
> Rename __clk_{enable|disble} in davinci_clk_{enable|disable}.
> davinci_clk_{enable|disable} is a lock-less version of
> clk_{enable|disable}.
> This is useful to recursively enable clock without doing recursive call
> to clk_enable(), which would cause a recursive locking issue.
> The lock-less version could be used by example by the usb20 phy clock,
> that need to enable the usb20 clock before to start.

I wouldn't call that lock-less. The difference is that the newly exposed
funcion requires the caller to already hold the lock. So maybe a better
name would be clk_enable_locked.

Would it be more sensible to convert davinci to common-clk?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
