From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 05 Feb 2014 08:01:31 -0800
Subject: [GIT PULLv3] clk: socfpga: Clean-ups for 3.14
In-Reply-To: <1389788321-11260-1-git-send-email-dinguyen@altera.com>
References: <1389788321-11260-1-git-send-email-dinguyen@altera.com>
Message-ID: <20140205160131.22158.85285@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting dinguyen at altera.com (2014-01-15 04:18:41)
> Hi Mike,
> 
> Please pull in these patches that cleans up the SOCFPGA clock driver. This is
> v3 of the pull request that includes 3 patches from Steffen Trumtrar. I have
> squashed the compiler error fix patch into the patch that introduced the error.
> Bisectability should now be fix.

Thanks for the rework. Can you rebase this onto 3.14-rc1 and send it
again?

Regards,
Mike

> 
> Thanks,
> Dinh
> 
> The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:
> 
>   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)
> 
> are available in the git repository at:
> 
>   git://git.rocketboards.org/linux-socfpga-next.git tags/socfpga-clk-for-3.14_v3
> 
> for you to fetch changes up to 5710d11ab5230dce43e5edc09d9d5506d3d49663:
> 
>   clk: socfpga: split clk code (2014-01-15 05:56:07 -0600)
> 
> ----------------------------------------------------------------
> v3: SOCFPGA clk cleanups for 3.14
> 
> ----------------------------------------------------------------
> Dinh Nguyen (3):
>       clk: socfpga: Map the clk manager base address in the clock driver
>       clk: socfpga: Look for the GPIO_DB_CLK by its offset
>       clk: socfpga: Remove socfpga_init_clocks
> 
> Steffen Trumtrar (3):
>       clk: socfpga: remove unused field
>       clk: socfpga: fix define typo
>       clk: socfpga: split clk code
> 
>  arch/arm/mach-socfpga/socfpga.c  |    5 -
>  drivers/clk/socfpga/Makefile     |    3 +
>  drivers/clk/socfpga/clk-gate.c   |  195 ++++++++++++++++++++++
>  drivers/clk/socfpga/clk-periph.c |   94 +++++++++++
>  drivers/clk/socfpga/clk-pll.c    |  111 +++++++++++++
>  drivers/clk/socfpga/clk.c        |  328 ++------------------------------------
>  drivers/clk/socfpga/clk.h        |   57 +++++++
>  7 files changed, 472 insertions(+), 321 deletions(-)
>  create mode 100644 drivers/clk/socfpga/clk-gate.c
>  create mode 100644 drivers/clk/socfpga/clk-periph.c
>  create mode 100644 drivers/clk/socfpga/clk-pll.c
>  create mode 100644 drivers/clk/socfpga/clk.h
> 
