From: jcm@redhat.com (Jon Masters)
Date: Wed, 06 May 2015 00:10:03 -0400
Subject: [PATCH v8 1/5] arm64: Enable EDAC on ARM64
In-Reply-To: <1430884947-16787-2-git-send-email-lho@apm.com>
References: <1430884947-16787-1-git-send-email-lho@apm.com>
 <1430884947-16787-2-git-send-email-lho@apm.com>
Message-ID: <5549941B.7060400@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Loc,

Great to see v8 of the patches :) A comment below.

On 05/06/2015 12:02 AM, Loc Ho wrote:

> Add an stub atomic_scrub function and enable EDAC for arm64.

> +/*
> + * ECC atomic, DMA, SMP and interrupt safe scrub function.
> + */

nit: I expect you'll still get a little push back on that (similar to
last time) because it doesn't actually implement anything, so while it
is "safe" it's only because it's empty :) Might be better to indicate
that those are the features it is supposed to have when implemented.

> +static inline void atomic_scrub(void *va, u32 size)
> +{
> +	/* Stub function for now until an ARM64 HW has a way to test it. */
> +	WARN_ONCE(1, "not implemented");
> +}

That's great and seems to address the previous comment from v7.

Thanks,

Jon.
