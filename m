From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 23 Jan 2017 14:59:01 +0800
Subject: [PATCH] ARM: imx: hide unused variable in #ifdef
In-Reply-To: <20170110130154.2994705-1-arnd@arndb.de>
References: <20170110130154.2994705-1-arnd@arndb.de>
Message-ID: <20170123065859.GF5662@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 10, 2017 at 01:19:05PM +0100, Arnd Bergmann wrote:
> A bugfix added a new local variable that is only used inside of an #ifdef
> section, and unused if CONFIG_PERF_EVENTS is disabled:
> 
> arch/arm/mach-imx/mmdc.c:63:25: warning: 'cpuhp_mmdc_state' defined but not used [-Wunused-variable]
> 
> This moves the variable down inside that same ifdef.
> 
> Fixes: a051f220d6b9 ("ARM/imx/mmcd: Fix broken cpu hotplug handling")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks.
