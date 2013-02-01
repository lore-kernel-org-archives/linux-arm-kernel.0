From: olof@lixom.net (Olof Johansson)
Date: Thu, 31 Jan 2013 19:55:55 -0800
Subject: [PATCH] ARM: imx: fix imx31-dt.c time-related warning
In-Reply-To: <1359518177-21245-1-git-send-email-swarren@wwwdotorg.org>
References: <1359518177-21245-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130201035555.GA5844@quad.lixom.net>
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
> ---
> This patch is based on arm-soc's timer/cleanup branch, which contains
> the commit mentioned above.


Applied.

-Olof
