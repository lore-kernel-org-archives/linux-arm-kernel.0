From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 14 Jan 2013 15:06:29 -0800
Subject: [PATCH 0/3] clk fixes for 3.8
In-Reply-To: <1356567272-3420-1-git-send-email-linux@prisktech.co.nz>
References: <1356567272-3420-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <20130114230629.23734.22509@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Tony Prisk (2012-12-26 16:14:28)
> Mike,
> 
> Three bugfixes for 3.8.
> 

Tony,

I've taken these into clk-next.

Thanks,
Mike

> #1 was a boo-boo on my part, function returned the wrong variables.
> #2 is a truncation problem which results in a higher-than-requested clock rate.
> #3 became apparent when the MMC driver started requesting rate=0 during init.
> 
> Tony Prisk (3):
>   clk: vt8500: Fix error in PLL calculations on non-exact match.
>   clk: vt8500: Fix device clock divisor calculations
>   clk: vt8500: Fix division-by-0 when requested rate=0
> 
>  drivers/clk/clk-vt8500.c |   28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
> 
> -- 
> 1.7.9.5
