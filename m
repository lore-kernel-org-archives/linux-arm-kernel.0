From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 13 Sep 2012 11:48:24 -0600
Subject: [PATCH] ARM: Tegra: Add smp_twd clock for Tegra20
In-Reply-To: <1347528873-3799-1-git-send-email-pgaikwad@nvidia.com>
References: <1347528873-3799-1-git-send-email-pgaikwad@nvidia.com>
Message-ID: <50521C68.3000704@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/2012 03:34 AM, Prashant Gaikwad wrote:
> Clockevent's frequency is changed upon cpufreq change
> notification. It fetches local timer's rate to update the
> clockevent frequency. This patch adds local timer clock
> for Tegra20.

Applied to Tegra's for-3.7/common-clk branch. I re-tested that branch,
and the final re-merge of Tegra's for-next.

A nice side-effect of this, is that you can disable CONFIG_CPU_FREQ, and
still boot (since the CPU clock isn't turned off, since smp_twd is
clk_get()d which takes a reference to the CPU clock).
