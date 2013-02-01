From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 1 Feb 2013 11:43:11 +0530
Subject: [PATCH v3 13/15] ARM: CCI: ensure powerdown-time data is flushed
 from cache
In-Reply-To: <1359445870-18925-14-git-send-email-nicolas.pitre@linaro.org>
References: <1359445870-18925-1-git-send-email-nicolas.pitre@linaro.org>
 <1359445870-18925-14-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <510B5CF7.5080902@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 January 2013 01:21 PM, Nicolas Pitre wrote:
> From: Dave Martin <dave.martin@linaro.org>
>
> Non-local variables used by the CCI management function called after
> disabling the cache must be flushed out to main memory in advance,
> otherwise incoherency of those values may occur if they are sitting
> in the cache of some other CPU when cci_disable() executes.
>
Any CPU calling cci_disable() would have already cleaned its local
cache and the snoop unit should take care of syncing the shared data
before hand from other CPU local caches for shared accesses.
May be I am unable to visualize the issue here or missing some key
point.

> This patch adds the appropriate flushing to the CCI driver to ensure
> that the relevant data is available in RAM ahead of time.
>
> Because this creates a dependency on arch-specific cacheflushing
> functions, this patch also makes ARM_CCI depend on ARM.
>
You should do that otherwise to avoid other arch building this
driver for random builds and breaking their builds.


> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> ---
Patch is fine apart from the question.

Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
