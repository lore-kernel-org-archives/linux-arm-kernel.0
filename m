From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 19 Mar 2013 11:54:13 -0600
Subject: [PATCH v2] ARM: tegra114: add speedo-based process identification
In-Reply-To: <1363605454-24176-1-git-send-email-dahuang@nvidia.com>
References: <1363605454-24176-1-git-send-email-dahuang@nvidia.com>
Message-ID: <5148A645.9020009@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/18/2013 05:17 AM, Danny Huang wrote:
> Add speedo-based process identifictaion for Tegra114.

I have applied this to Tegra's for-3.10/soc branch, with one addition below:

> diff --git a/arch/arm/mach-tegra/tegra114_speedo.c b/arch/arm/mach-tegra/tegra114_speedo.c

> +#include <linux/kernel.h>

Here, I also added:

#include <linux/bug.h>

That's not needed in the Tegra for-next branch (which is based on
3.9-rc1), but is needed when merged into linux-next, and hence will
presumably be needed once this is submitted into 3.10.
