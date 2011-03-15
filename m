From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 15 Mar 2011 10:49:46 +0100
Subject: [PATCH 2/2] ARM: mx5/mx53_evk: Remove unneeded gpio_set_value call
In-Reply-To: <Pine.LNX.4.64.1103151039030.11859@ask.diku.dk>
References: <1300126869-14587-1-git-send-email-fabio.estevam@freescale.com>
	<1300126869-14587-2-git-send-email-fabio.estevam@freescale.com>
	<20110315090656.GC13316@pengutronix.de>
	<Pine.LNX.4.64.1103151039030.11859@ask.diku.dk>
Message-ID: <20110315094946.GD13316@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 15, 2011 at 10:41:37AM +0100, Julia Lawall wrote:
> I tried the following
> 
> @@
> expression E1,E2;
> @@
> 
>       gpio_direction_output(E1,E2);
>       ...
> -     gpio_set_value(E1,E2);
> 
> and found occurrences in 15 files.  In some cases there seems to be some 
> delay before the call to gpio_set_value.  Does that have any impacton 
> whether it is needed?
gpio_direction_output(E1,E2) implies gpio_set_value(E1,E2), so unless
there is a gpio_set_value(E1,!E2) before gpio_set_value(E1,E2) is a
noop.

I still don't know how to work with coccinelle, so if you point me to a
concrete location I can be more specific.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
