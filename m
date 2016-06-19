From: olof@lixom.net (Olof Johansson)
Date: Sat, 18 Jun 2016 22:58:48 -0700
Subject: [GIT PULL] omap fixes for v4.7-rc cycle
In-Reply-To: <20160614081101.GV22406@atomide.com>
References: <20160614081101.GV22406@atomide.com>
Message-ID: <20160619055848.GA16376@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 14, 2016 at 01:11:02AM -0700, Tony Lindgren wrote:
> The following changes since commit af8c34ce6ae32addda3788d54a7e340cad22516b:
> 
>   Linux 4.7-rc2 (2016-06-05 14:31:26 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.7/fixes-powedomain
> 
> for you to fetch changes up to 6b41d44862e8f3a4b95102c6ff6cad3fccc7994b:
> 
>   ARM: OMAP: DRA7: powerdomain data: Remove unused pwrsts_mem_ret (2016-06-13 01:04:01 -0700)
> 
> ----------------------------------------------------------------
> Fixes for omaps for v4.7-rc cycle:
> 
> - Fix dra7 for hardware issues limiting L4Per and L3init power domains
>   to on state. Without this the devices may not work correctly after
>   some time of use because of asymmetric aging. And related to this,
>   let's also remove the unusable states.
> 
> - Always select omap interconnect for am43x as otherwise the am43x
>   only configurations will not boot properly. This can happen easily
>   for any product kernels that leave out other SoCs to save memory.
> 
> - Fix DSS PLL2 addresses that have gone unused for now
> 
> - Select erratum 430973 for omap3, this is now safe to do and can
>   save quite a bit of debugging time for people who may have left
>   it out.

Grmbl, our fixes branch was only at -rc1, but I merged this anyway.


-Olof
