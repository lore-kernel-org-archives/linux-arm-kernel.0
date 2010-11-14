From: dwalker@codeaurora.org (Daniel Walker)
Date: Sun, 14 Nov 2010 12:17:38 -0800
Subject: [PATCH 09/14] msm: iommu: Kconfig option for cacheable page tables
In-Reply-To: <1289619000-13167-10-git-send-email-stepanm@codeaurora.org>
References: <1289619000-13167-1-git-send-email-stepanm@codeaurora.org>
	<1289619000-13167-10-git-send-email-stepanm@codeaurora.org>
Message-ID: <1289765858.24270.240.camel@m0nster>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-11-12 at 19:29 -0800, Stepan Moskovchenko wrote:
>  
> +config IOMMU_PGTABLES_L2
> +	depends on ARCH_MSM8X60
> +	depends on MMU
> +	depends on CPU_DCACHE_DISABLE=n
> +	depends on SMP
> +	bool "Cacheable IOMMU page tables"
> +	default y
> +	help
> +	  Allows the IOMMU page tables to be brought into the L2 cache. This
> +	  improves the TLB miss latency at the expense of potential pollution
> +	  of the L2 cache. This option has been shown to improve multimedia
> +	  performance in some cases.
> +
> +	  If unsure, say Y here.

Why would someone want this off?

The other thing is that you usually want this included with the code
that uses the option.

Daniel

-- 
Sent by an consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum.
