From: mturquette@baylibre.com (Michael Turquette)
Date: Tue, 11 Aug 2015 10:46:57 -0700
Subject: [GIT PULL] i.MX clock updates for 4.2
In-Reply-To: <20150811085921.GB10035@tiger>
References: <20150811085921.GB10035@tiger>
Message-ID: <20150811174657.2416.1270@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Quoting Shawn Guo (2015-08-11 01:59:21)
> Hi Michael, Stephen,
> 
> The i.MX clock drivers were moved into drivers/clk/imx folder since
> v4.2-rc1, so I would like to send i.MX clock changes through clock tree
> from this cycle.  Here is my first pull request to you guys.  I'm using
> signed tags, same as how I work with arm-soc folks.  Let me know if
> there is any problem with it.

Everything looks good. Pulled.

> 
> Also, please keep it stable, because I need to pull it into other
> branch as dependency which I will send via arm-soc tree.

Will do.

Also, the clock driver was not Cc'd to linux-clk mailing list nor did it
Cc myself or Stephen. I've taken a quick look at it and it seems fine,
but please post clk patches to the linux-clk mailing list in the future.

Thanks,
Mike

> 
> Thanks,
> Shawn
> 
> The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:
> 
>   Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-clk-4.3
> 
> for you to fetch changes up to 3713e3f5e9274bbe52e94716bde303071364c1ed:
> 
>   clk: imx35: define two clocks for rtc (2015-08-05 20:01:21 +0800)
> 
> ----------------------------------------------------------------
> The i.MX clock updates for 4.3:
>  - Provide a better IPU clock initial settings on imx6dl for getting
>    HDMI and LVDS at the same time.
>  - Add clock driver support for i.MX6UL SoC
>  - Add a second clock for RTC device on i.MX31 and i.MX35
> 
> ----------------------------------------------------------------
> Fabio Estevam (1):
>       clk: imx: clk-imx6q: Provide initial IPU clock settings for mx6dl
> 
> Frank Li (1):
>       clk: imx: add imx6ul clk tree support
> 
> Philippe Reynes (2):
>       clk: imx31: add a second rtc clock
>       clk: imx35: define two clocks for rtc
> 
>  drivers/clk/imx/Makefile                 |   1 +
>  drivers/clk/imx/clk-imx31.c              |   3 +-
>  drivers/clk/imx/clk-imx35.c              |   6 +-
>  drivers/clk/imx/clk-imx6q.c              |   4 +
>  drivers/clk/imx/clk-imx6ul.c             | 432 +++++++++++++++++++++++++++++++
>  include/dt-bindings/clock/imx6ul-clock.h | 240 +++++++++++++++++
>  6 files changed, 684 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/clk/imx/clk-imx6ul.c
>  create mode 100644 include/dt-bindings/clock/imx6ul-clock.h
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
