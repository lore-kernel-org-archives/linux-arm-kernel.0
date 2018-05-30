From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 30 May 2018 06:31:03 +0200
Subject: [PATCH] PCI: Add pci=safemode option
In-Reply-To: <1527650389-31575-1-git-send-email-okaya@codeaurora.org>
References: <1527650389-31575-1-git-send-email-okaya@codeaurora.org>
Message-ID: <20180530043103.GA19734@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2018 at 11:19:41PM -0400, Sinan Kaya wrote:
> Adding pci=safemode kernel command line parameter to turn off all PCI
> Express service driver as well as all optional PCIe features such as LTR,
> Extended tags, Relaxed Ordering etc.
> 
> Also setting MPS configuration to PCIE_BUS_SAFE so that MPS and MRRS can be
> reconfigured with by the kernel in case BIOS hands off a broken
> configuration.

Why not fix the BIOS?  That's what sane platforms do :)

> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 2 ++
>  drivers/pci/pci.c                               | 7 +++++++
>  drivers/pci/pci.h                               | 2 ++
>  drivers/pci/pcie/portdrv_core.c                 | 2 +-
>  drivers/pci/probe.c                             | 6 ++++++
>  5 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 641ec9c..247adbb 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3153,6 +3153,8 @@
>  		noari		do not use PCIe ARI.
>  		noats		[PCIE, Intel-IOMMU, AMD-IOMMU]
>  				do not use PCIe ATS (and IOMMU device IOTLB).
> +		safemode	turns of all optinal PCI features. Useful
> +				for bringup/troubleshooting.

s/optinal/optional/ ?

And you should explain what exactly in PCI is "optional".  Who defines
this and where is that list and what can go wrong if those options are
not enabled?

In looking at your patch, I can't determine that at all, so there's no
way that someone just looking at this sentence will be able to
understand.

thanks,

greg k-h
