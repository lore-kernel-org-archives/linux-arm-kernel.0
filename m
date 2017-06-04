From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 4 Jun 2017 11:42:11 +0800
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Explicitly restore
 CONFIG_DEBUG_FS
In-Reply-To: <49b2579b9ad2e5ce0a7c4b163dffb5a885ac7dae.1495797565.git.leonard.crestez@nxp.com>
References: <49b2579b9ad2e5ce0a7c4b163dffb5a885ac7dae.1495797565.git.leonard.crestez@nxp.com>
Message-ID: <20170604034210.GB4094@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 26, 2017 at 02:26:06PM +0300, Leonard Crestez wrote:
> This option was removed by "make savedefconfig" in
> commit c5054a98bce4 ("ARM: imx_v6_v7_defconfig: Select SMSC_PHY")
> 
> This happened because CONFIG_DEBUG_FS was implicitly selected by
> CONFIG_TREE_RCU_TRACE which defaulted to true because CONFIG_RCU_TRACE
> was enabled by default by commit 961518259b3b ("rcu: Enable RCU
> tracepoints by default to aid in debugging")
> 
> Recently however CONFIG_RCU_TRACE was completely removed by
> commit 6e74c237c410 ("rcu: Remove debugfs tracing")
> 
> The result is that imx_v6_v7_defconfig no longer includes DEBUG_FS on
> linux-next since next-20170517. This is bad, DEBUG_FS is extremely
> useful for kernel introspection and testing.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Applied, thanks.
