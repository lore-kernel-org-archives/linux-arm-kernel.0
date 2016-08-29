From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 29 Aug 2016 22:41:18 +0800
Subject: [PATCH V2] ARM: imx: add cpuidle support for i.mx6ul
In-Reply-To: <1472485272-17036-1-git-send-email-Anson.Huang@nxp.com>
References: <1472485272-17036-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20160829144118.GW30790@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2016 at 11:41:12PM +0800, Anson Huang wrote:
> This patch enables cpuidle driver for i.MX6UL, it
> reuses i.MX6SX's cpuidle driver, 3 levels of cpuidle
> supported:
> 
> 1. ARM WFI;
> 2. SOC in WAIT mode;
> 3. SOC in WAIT mode + ARM power off.
> 
> As i.MX6UL has cortex-A7 CORE with an internal L2
> cache, so flushing it before powering down ARM platform
> is necessary, flush_cache_all() in last step of cpu_suspend
> has very small overhead, just call it to avoid cache
> type check for different platforms.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
