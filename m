From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 18 Oct 2016 16:09:04 +0100
Subject: [PATCH] coresight: reset "enable_sink" flag when need be
In-Reply-To: <1475874643-9464-1-git-send-email-mathieu.poirier@linaro.org>
References: <1475874643-9464-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <5129dc7c-7d62-1d7e-9535-0fd5baa6bd48@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10/16 22:10, Mathieu Poirier wrote:
> When using coresight from the perf interface sinks are specified
> as part of the perf command line.  As such the sink needs to be
> disabled once it has been acknowledged by the coresight framework.
> Otherwise the sink stays enabled, which may interfere with other
> sessions.
>

I personally think the descriptions needs to be a bit more clearer
from here on.

> This patch removes the sink selection check from the build path
> process and make it a function on it's own.  The function is
> then used when operating from sysFS or perf to determine what
> sink has been selected.

I think you should mention that the helper function provides an
option to "de-activate" the enabled sink, once it has been "found"
by a lookup. Perf uses this option to de-activate the sink, while
sysfs leaves it to the user to do the same.

We don't have a mechanism to ensure that the "enabled" sink is
the one perf really enabled for us. But there is nothing much we
could do and should rely on the user to do it right for us.

So, with the changes to description :

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
