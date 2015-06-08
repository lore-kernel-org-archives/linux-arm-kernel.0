From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 8 Jun 2015 08:30:52 +0200
Subject: [PATCH v0] gpio_keys: fix gpio key driver to proper support GIC
 interrupt
In-Reply-To: <1433402712-21399-1-git-send-email-yvo@apm.com>
References: <1433402712-21399-1-git-send-email-yvo@apm.com>
Message-ID: <20150608063052.GW18985@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Jun 04, 2015 at 02:25:12PM +0700, Y Vo wrote:
> GIC is designed to support two of trigger mechanisms - active level
> high or edge rising. But in the gpio_keys driver, it tries to use both
> edge rising and edge falling trigger. This patch fixes the gpio_keys
> driver to request only the edge rising event when failed to configure the
> interrupt.
Is it possible to fix that in the GIC driver? I.e. let it switch the
trigger direction to falling when it fired for raising?

This would require to read out the current level, not sure this is
possible?!

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
