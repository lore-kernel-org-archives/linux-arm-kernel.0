From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 19 Mar 2014 16:32:39 -0700
Subject: [PATCH v3 0/4] clk: at91: better support for the PCKs
In-Reply-To: <1394528435-23734-1-git-send-email-b.brezillon.dev@gmail.com>
References: <1394528435-23734-1-git-send-email-b.brezillon.dev@gmail.com>
Message-ID: <20140319233239.21989.44031@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Boris BREZILLON (2014-03-11 02:00:31)
> From: Boris BREZILLON <b.brezillon@overkiz.com>
> 
> This serie implements a better support for the Programmable Clocks.
> The first two patch are related to changing the rate of the PCKs.
> The 3rd patch is a fix to handle properly the PCKRDY interrupt.
> The last patch is a small optimzation/simplification of the determine_rate
> algorithm for the PCK.

Taken into clk-next.

Regards,
Mike

> 
> Changes since v2:
> - remove unnecessary CLK_SET_RATE_GATE flag from system clk setting
> 
> Boris BREZILLON (2):
>   clk: at91: replace prog clk round_rate with determine_rate
>   clk: at91: propagate rate change on system clks
> 
> Jean-Jacques Hiblot (2):
>   clk: at91: fix programmable clk irq handling
>   clk: at91: optimization of the set_rate callback
> 
>  drivers/clk/at91/clk-programmable.c |  202 +++++++++++------------------------
>  drivers/clk/at91/clk-system.c       |   76 +++++++++++--
>  2 files changed, 126 insertions(+), 152 deletions(-)
> 
> -- 
> 1.7.9.5
> 
