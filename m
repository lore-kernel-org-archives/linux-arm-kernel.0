From: mturquette@baylibre.com (Michael Turquette)
Date: Tue, 22 Dec 2015 10:22:57 -0800
Subject: [GIT PULL] i.MX clock updates for 4.5
In-Reply-To: <20151222134842.GF26290@tiger>
References: <20151222134842.GF26290@tiger>
Message-ID: <20151222182257.GB6596@quark.deferred.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn,

On 12/22, Shawn Guo wrote:
> Hi Mike, Stephen,
> 
> Here is the i.MX clock updates I queued for 4.5.  Please pull and keep
> it stable, as it's been merged into imx/dt branch to resolve some
> dependency.  Thanks.

Pulled.

Thanks,
Mike

> 
> Shawn
> 
> The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:
> 
>   Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-clk-v4.5
> 
> for you to fetch changes up to c20737a2a7b8666648be3f4b386749339958dace:
> 
>   clk: imx5: ipu_di_sel clocks can set parent rates (2015-12-02 21:02:33 +0800)
> 
> ----------------------------------------------------------------
> The i.MX clock updates for 4.5:
> - Add is_prepared function callback for pllv3 clock driver
> - Use imx_check_clocks() on imx6ul and imx7d clock drivers to save
>   some code
> - Add a core clock for imx7d to support generic cpufreq driver
> - Support imx6q clock routing with OSC to anaclk2/2b
> - To support more precise pixel clocks on imx5, allow ipu_di_sel clock
>   selectors to influence the PLLs that they are derived from
> - A cleanup on imx25 OSC clock
> 
> ----------------------------------------------------------------
> Bai Ping (3):
>       clk: imx: add 'is_prepared' clk_ops callback for pllv3 clk
>       clk: imx: Add a virtual arm clk on i.mx7d
>       clk: imx: Replace clk error check with imx_check_clocks()
> 
> Markus Pargmann (1):
>       clk: imx25: Remove osc clock from driver
> 
> Michael Trimarchi (1):
>       clk: imx: clk-imx6q: Let OSC to be routed to anaclk2/2b
> 
> Patrick Br?nn (1):
>       clk: imx5: ipu_di_sel clocks can set parent rates
> 
>  drivers/clk/imx/clk-imx25.c             | 18 ++----------------
>  drivers/clk/imx/clk-imx51-imx53.c       |  8 ++++----
>  drivers/clk/imx/clk-imx6q.c             |  3 ++-
>  drivers/clk/imx/clk-imx6ul.c            |  4 +---
>  drivers/clk/imx/clk-imx7d.c             | 11 +++++++----
>  drivers/clk/imx/clk-pllv3.c             | 14 ++++++++++++++
>  include/dt-bindings/clock/imx7d-clock.h |  3 ++-
>  7 files changed, 32 insertions(+), 29 deletions(-)
