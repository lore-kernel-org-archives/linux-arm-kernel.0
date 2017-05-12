From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 12 May 2017 11:51:39 +0800
Subject: [PATCH] soc: imx: add PM dependency for IMX7_PM_DOMAINS
In-Reply-To: <20170511113806.2647189-1-arnd@arndb.de>
References: <20170511113806.2647189-1-arnd@arndb.de>
Message-ID: <20170512035137.GG8471@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 11, 2017 at 01:37:47PM +0200, Arnd Bergmann wrote:
> The new pm domain driver causes a build failure when CONFIG_PM
> is not set:
> 
> warning: (IMX7_PM_DOMAINS) selects PM_GENERIC_DOMAINS which has unmet direct dependencies (PM)
> drivers/base/power/domain_governor.c: In function 'default_suspend_ok':
> drivers/base/power/domain_governor.c:75:17: error: 'struct dev_pm_info' has no member named 'ignore_children'
> 
> This adds a dependency to ensure that we don't attempt to build the
> driver without CONFIG_PM.
> 
> Fixes: 03aa12629fc4 ("soc: imx: Add GPCv2 power gating driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks.
