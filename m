From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 30 Jan 2013 14:03:32 +0800
Subject: [PATCH] ARM: imx: fix imx31-dt.c time-related warning
In-Reply-To: <1359518177-21245-1-git-send-email-swarren@wwwdotorg.org>
References: <1359518177-21245-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130130060329.GB24450@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 08:56:17PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Commit 6bb27d7 "ARM: delete struct sys_timer" caused the following:
> 
> arch/arm/mach-imx/imx31-dt.c:56:2: warning: initialization from incompatible pointer type [enabled by default]
> arch/arm/mach-imx/imx31-dt.c:56:2: warning: (near initialization for ?__mach_desc_IMX31_DT.init_time?) [enabled by default]
> 
> This is because mx31_clocks_init_dt() returns int, whereas the .init_time
> field prototype expects a function returning void. Implement a wrapper so
> that the prototypes match.
> 
> Reported-by: Fengguang Wu <fengguang.wu@intel.com>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> ---
> This patch is based on arm-soc's timer/cleanup branch, which contains
> the commit mentioned above.

I suppose that it should just be applied by arm-soc folks on that
branch, right?

Shawn
