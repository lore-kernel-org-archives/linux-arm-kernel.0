From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 18 Dec 2013 14:56:45 -0800
Subject: [PATCH V2 0/4] socfpga: clk: trivial fixes and cleanup
In-Reply-To: <1387386182-30923-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1387386182-30923-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <20131218225645.23538.32552@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Steffen Trumtrar (2013-12-18 09:02:58)
> Hi!
> 
> This series includes two trivial fixes to the code (1/4 and 2/4),
> and a fixes a compile error in 3/4 introduced by the patch
> 
>         clk: socfpga: Look for the GPIO_DB_CLK by its offset
> 
> from
> 
>         [GIT PULL] clk: socfpga: Clean-ups for 3.14
> 
> The series is rebased onto
> 
>         git://git.rocketboards.org/linux-socfpga-next.git socfpga-clk-for-3.14
> 
> and the patch
> 
>         clk: socfpga: Add a clk-phase property to the "altr, socfpga-gate-clk"
> 
> from the series
> 
>         socfpga: Enable SD/MMC support

Stephen & Dinh,

I've gone through the socfpga patches on the list (this series, the 3
patches in socfpga-clk-for-3.14 and the clock patch from "[RESEND LIST
PATCHv7 0/4] socfpga: Enable SD/MMC support"). Everything looks pretty
good.

When the issue with the clock-phase property is resolved can you
coordinate a pull request with all of the socfpga patches in it based on
the latest clk-next?

Thanks,
Mike

> 
> Regards,
> Steffen
> 
> Steffen Trumtrar (4):
>   ARM: socfpga: clk: remove unused field
>   ARM: socfpga: clk: fix define typo
>   ARM: socfpga: clk: fix compile error
>   ARM: socfpga: clk: split clk code
> 
>  drivers/clk/socfpga/Makefile     |   3 +
>  drivers/clk/socfpga/clk-gate.c   | 223 +++++++++++++++++++++++++
>  drivers/clk/socfpga/clk-periph.c |  94 +++++++++++
>  drivers/clk/socfpga/clk-pll.c    | 111 +++++++++++++
>  drivers/clk/socfpga/clk.c        | 347 +--------------------------------------
>  drivers/clk/socfpga/clk.h        |  57 +++++++
>  6 files changed, 490 insertions(+), 345 deletions(-)
>  create mode 100644 drivers/clk/socfpga/clk-gate.c
>  create mode 100644 drivers/clk/socfpga/clk-periph.c
>  create mode 100644 drivers/clk/socfpga/clk-pll.c
>  create mode 100644 drivers/clk/socfpga/clk.h
> 
> -- 
> 1.8.5.1
> 
