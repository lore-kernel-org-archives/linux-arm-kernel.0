From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 1 Feb 2013 11:04:55 +0530
Subject: [PATCH v3 05/15] ARM: mcpm_head.S: vlock-based first man election
In-Reply-To: <1359445870-18925-6-git-send-email-nicolas.pitre@linaro.org>
References: <1359445870-18925-1-git-send-email-nicolas.pitre@linaro.org>
 <1359445870-18925-6-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <510B53FF.2020603@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 January 2013 01:21 PM, Nicolas Pitre wrote:
> From: Dave Martin <dave.martin@linaro.org>
>
> Instead of requiring the first man to be elected in advance (which
> can be suboptimal in some situations), this patch uses a per-
> cluster mutex to co-ordinate selection of the first man.
>
> This should also make it more feasible to reuse this code path for
> asynchronous cluster resume (as in CPUidle scenarios).
>
> We must ensure that the vlock data doesn't share a cacheline with
> anything else, or dirty cache eviction could corrupt it.
>
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> ---
Reviewed-by: Santosh Shilimkar<santosh.shilimkar@ti.com>

Regards,
Santosh
