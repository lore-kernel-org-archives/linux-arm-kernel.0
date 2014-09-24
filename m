From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 24 Sep 2014 18:12:50 +0100
Subject: [PATCH 6/6] pci, thunder: Enable Cavium Thunder PCIe host
 controller
In-Reply-To: <1411573068-12952-7-git-send-email-rric@kernel.org>
References: <1411573068-12952-1-git-send-email-rric@kernel.org>
 <1411573068-12952-7-git-send-email-rric@kernel.org>
Message-ID: <20140924171249.GP15842@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 24, 2014 at 04:37:48PM +0100, Robert Richter wrote:
> From: Robert Richter <rrichter@cavium.com>
> 
> Enable Cavium Thunder PCIe host controller driver.
> 
> IOV is enabled per default if drivers with IOV support are
> enabled. IOV can be disabled.
> 
> Signed-off-by: Robert Richter <rrichter@cavium.com>
> ---
>  arch/arm64/Kconfig | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 97777e1ef5a7..bd9724e5c8a1 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -172,6 +172,14 @@ config PCI
>  config PCI_MSI
>  	def_bool PCI
>  
> +config NO_PCI_IOV
> +	def_bool PCI
> +	depends on !PCI_THUNDER
> +
> +config PCI_IOV
> +	def_bool PCI
> +	depends on !NO_PCI_IOV

Does this work with single image where drivers may have different
PCI_IOV needs?

-- 
Catalin
