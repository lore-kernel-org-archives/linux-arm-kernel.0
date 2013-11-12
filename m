From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 12 Nov 2013 13:04:16 -0700
Subject: [PATCH] ARM: tegra: init fuse before setting reset handler
In-Reply-To: <1384238186-8473-1-git-send-email-acourbot@nvidia.com>
References: <1384238186-8473-1-git-send-email-acourbot@nvidia.com>
Message-ID: <528289C0.3040202@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/11/2013 11:36 PM, Alexandre Courbot wrote:
> CPU reset handler was set before fuse is initialized, but
> tegra_cpu_reset_handler_enable() uses tegra_chip_id, which is set by
> tegra_init_fuse(). This patch reorders the calls so the CPU reset
> handler code does not read an uninitialized variable.

Thanks. I forwarded this to the arm-soc maintainers as a patch for 3.13.
