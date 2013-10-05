From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 5 Oct 2013 22:24:30 +0200
Subject: [PATCH] clk: provide public clk_is_enabled function
In-Reply-To: <1380881310-24345-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1380881310-24345-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20131005202430.GI10079@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 04, 2013 at 12:08:30PM +0200, Sebastian Hesselbarth wrote:
> To determine if a clk has been previously enabled, provide a public
> clk_is_enabled function. This is especially helpful to check the state
> of clk-gate without actually changing the state of the gate.
I wonder what you want to do with the return value.

When doing

	if (clk_is_enabled(someclk))
		do_something();

you cannot in general know if the clock is still on when you start to
do_something.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
