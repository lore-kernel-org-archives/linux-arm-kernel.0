From: rric@kernel.org (Robert Richter)
Date: Mon, 29 Feb 2016 18:29:56 +0100
Subject: [PATCH v12 3/5] dt, numa: Add NUMA dt binding implementation.
In-Reply-To: <1456192703-2274-4-git-send-email-ddaney.cavm@gmail.com>
References: <1456192703-2274-1-git-send-email-ddaney.cavm@gmail.com>
 <1456192703-2274-4-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <20160229172956.GF31343@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22.02.16 17:58:21, David Daney wrote:
> From: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
> 
> ADD device tree node parsing for NUMA topology using device
> "numa-node-id" property distance-map.
> 
> Reviewed-by: Robert Richter <rrichter@cavium.com>
> Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  drivers/of/Kconfig   |   3 +
>  drivers/of/Makefile  |   1 +
>  drivers/of/of_numa.c | 211 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/of.h   |   9 +++
>  4 files changed, 224 insertions(+)
>  create mode 100644 drivers/of/of_numa.c
> 
> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> index e2a4841..b3bec3a 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -112,4 +112,7 @@ config OF_OVERLAY
>  	  While this option is selected automatically when needed, you can
>  	  enable it manually to improve device tree unit test coverage.
>  
> +config OF_NUMA

In arch/arm64/Kconfig you now need to:

	select OF_NUMA if NUMA && OF

This should depend here on OF and NUMA and enabled in that case. Why
moving that to arch code? This duplicates code as the same needs to be
implemented for every arch.

-Robert

> +	bool
> +
>  endif # OF
