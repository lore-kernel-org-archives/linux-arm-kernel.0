From: Guangyu.Chen@freescale.com (Nicolin Chen)
Date: Tue, 22 Apr 2014 10:54:11 +0800
Subject: [PATCH 0/4] ARM: imx: shared gate support for i.MX clk_gate2 clock
In-Reply-To: <1397883693-26101-1-git-send-email-shawn.guo@freescale.com>
References: <1397883693-26101-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <20140422025408.GA31659@MrMyself>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On Sat, Apr 19, 2014 at 01:01:29PM +0800, Shawn Guo wrote:
> We're constantly running into the situation on i.MX that multiple clocks
> share the single gate.  Since we already have i.MX specific gate clock
> implementation due to 2-bits gate, the series takes Gerhard's approach
> to add shared gate support for i.MX clk_gate2 clock.
> 
> Shawn Guo (4):
>   ARM: imx: define struct clk_gate2 on our own
>   ARM: imx: lock is always valid for clk_gate2
>   ARM: imx: add shared gate clock support
>   ARM: imx6q: add the missing esai_ahb clock

I've simply tested these patches on both for-next and 3.10.y baseline
and it works fine. Hope we can apply them soon.

Thank you,
Nicolin

> 
>  .../devicetree/bindings/clock/imx6q-clock.txt      |  1 +
>  arch/arm/mach-imx/clk-gate2.c                      | 47 ++++++++++++++--------
>  arch/arm/mach-imx/clk-imx6q.c                      |  7 +++-
>  arch/arm/mach-imx/clk.h                            | 13 +++++-
>  4 files changed, 48 insertions(+), 20 deletions(-)
> 
> -- 
> 1.8.3.2
> 
> 
