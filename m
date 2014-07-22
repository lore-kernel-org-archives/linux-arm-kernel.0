From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 22 Jul 2014 11:16:15 -0600
Subject: [PATCH 1/6] clk: tegra: don't abort clk init on error
In-Reply-To: <1405437890-6468-2-git-send-email-pdeschrijver@nvidia.com>
References: <1405437890-6468-1-git-send-email-pdeschrijver@nvidia.com>
 <1405437890-6468-2-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <53CE9C5F.1030005@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/15/2014 09:24 AM, Peter De Schrijver wrote:
> Just continue initializing clocks if there's an error on one of them. This
> is useful if there's a mistake in the inittable, because the system could
> hang if clk_disable_unused() disables some of the critical clocks in this
> table.

If there's a problem in the init table, we should simply fix it instead
of working around it.

At the very least, we need to WARN on this rather than just ignoring
problems.
