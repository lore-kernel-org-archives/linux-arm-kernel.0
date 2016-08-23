From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue, 23 Aug 2016 04:47:08 +0300
Subject: [PATCH 2/2] ARM: sa1100: register clocks early
In-Reply-To: <E1baiKh-0004yg-OF@rmk-PC.armlinux.org.uk>
References: <E1baiKh-0004yg-OF@rmk-PC.armlinux.org.uk>
Message-ID: <CALT56yPLMiQZaeSxmo3xz_+6c11BO-hWSEN2ex-ziJGZdZDY6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-08-19 14:51 GMT+03:00 Russell King <rmk+kernel@armlinux.org.uk>:
> Since we switched to use pxa_timer, we need to provide the OSTIMER0
> clock.  However, as the clock is initialised early, we need to provide
> the clock early as well, so that pxa_timer can find it.  Adding the
> clock to the clkdev table at core_initcall() time is way too late.

This worked for me before, so maybe the init order of other kernel parts
has changed. Anyway:

Acked-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>




-- 
With best wishes
Dmitry
