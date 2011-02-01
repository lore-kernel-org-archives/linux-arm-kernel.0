From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 1 Feb 2011 22:05:56 +0900
Subject: Locking in the clk API, part 2: clk_prepare/clk_unprepare
In-Reply-To: <20110201105449.GY1147@pengutronix.de>
References: <201102011711.31258.jeremy.kerr@canonical.com>
	<20110201105449.GY1147@pengutronix.de>
Message-ID: <AANLkTimayMAfr+zA6uO_yUmZqsOLmJ3fiiS696mL_evn@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/2/1 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:

.....

> Do you plan to handle the case that clk_enable is called while prepare
> isn't completed (considering the special case "not called at all")?
> Maybe BUG_ON(clk->ops->prepare && !clk->prepare_count)?
Sounds better than the second option.

> Alternatively don't force the sleep in clk_prepare (e.g. by protecting
> prepare_count by a spinlock (probably enable_lock)) and call clk_prepare
> before calling clk->ops->enable?
That might result in a driver working on some platforms(those have
atomic clk_prepare)
and not on others(those have sleeping).


Njoi!
