From: dwalker@codeaurora.org (Daniel Walker)
Date: Fri, 11 Feb 2011 12:38:49 -0800
Subject: [PATCH 1/3] msm: iommu: Create a Kconfig item for the IOMMU driver
In-Reply-To: <1297456098-3241-1-git-send-email-stepanm@codeaurora.org>
References: <1297456098-3241-1-git-send-email-stepanm@codeaurora.org>
Message-ID: <1297456729.4852.9.camel@m0nster>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-02-11 at 12:28 -0800, Stepan Moskovchenko wrote:
> +config MSM_IOMMU
> +       bool "MSM IOMMU Support"
> +       depends on ARCH_MSM8X60
> +       select IOMMU_API
> +       default n
> +       help
> +         Support for the IOMMUs found on certain Qualcomm SOCs.
> +         These IOMMUs allow virtualization of the address space used by most
> +         cores within the multimedia subsystem.
> +
> +         If unsure, say N here. 

I think you should just make this a hidden option, unless there is a
good reason why any given users might want to turn this off.

Daniel

-- 
Sent by an consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum.
