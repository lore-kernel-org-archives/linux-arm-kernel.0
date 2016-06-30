From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 30 Jun 2016 21:54:08 +0100
Subject: [PATCH 0/6] clk: sti: Add support for critical clocks
In-Reply-To: <20160630192337.GN1521@codeaurora.org>
References: <20160607111930.10375-1-lee.jones@linaro.org>
 <20160630192337.GN1521@codeaurora.org>
Message-ID: <20160630205408.GG1707@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 30 Jun 2016, Stephen Boyd wrote:
> On 06/07, Lee Jones wrote:
> > Describe the platform's critical clocks in DT, then search for them
> > from the framework.  This set allows us to remove the clk_ignore_unused
> > kernel command line flag which has been required to achieve a successful
> > boot to prompt until this point.
> > 
> > This may not be the definitive list.  There may be other clocks which
> > need to be marked as critical, but we can add those as we go along.
> > 
> 
> I applied the three clk ones to an immutable branch named
> 'clk-st-critical' in the clk tree and merged this into clk-next.
> I'm not comfortable taking the spi patch as I suspect that will
> break something unless the dts patches are applied.
> 
> Please use this branch to base your dts and spi patches on so it
> can be merged through arm-soc without introducing some bisection
> hole.
> 
> The following changes since commit 1a695a905c18548062509178b98bc91e67510864:
> 
>   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-st-critical
> 
> for you to fetch changes up to 6ca59e6e1fc3a8d7ccbf85ff036bd6ff40847c1a:
> 
>   clk: st: clkgen-pll: Detect critical clocks (2016-06-30 12:17:11 -0700)
> 
> ----------------------------------------------------------------
> Lee Jones (3):
>       clk: st: clk-flexgen: Detect critical clocks
>       clk: st: clkgen-fsyn: Detect critical clocks
>       clk: st: clkgen-pll: Detect critical clocks
> 
>  drivers/clk/st/clk-flexgen.c |  4 +++-
>  drivers/clk/st/clkgen-fsyn.c | 10 +++++++---
>  drivers/clk/st/clkgen-pll.c  | 27 +++++++++++++++++----------
>  3 files changed, 27 insertions(+), 14 deletions(-)

Ideal, thanks Stephen.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
