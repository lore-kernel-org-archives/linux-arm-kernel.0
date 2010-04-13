From: daniel@caiaq.de (Daniel Mack)
Date: Tue, 13 Apr 2010 18:48:05 +0200
Subject: [PATCH 2.6.34-rc4 2/8] mxc: Update GPIO for USB support on
	Freescale MX51 Babbage HW
In-Reply-To: <1271175030-3635-2-git-send-email-Dinh.Nguyen@freescale.com>
References: <1271175030-3635-1-git-send-email-Dinh.Nguyen@freescale.com>
	<1271175030-3635-2-git-send-email-Dinh.Nguyen@freescale.com>
Message-ID: <20100413164805.GN30801@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 13, 2010 at 11:10:25AM -0500, Dinh.Nguyen at freescale.com wrote:
> This patch is part of enabling USB for Freescale MX51 Babbage HW. This
> patch updates the iomux pins for USB, and gpio line for reset the
> USB hub on the MX51 Babbage HW.
> 
> This patch applies to 2.6.34-rc4.
> 
> Signed-off-by: Dinh Nguyen <Dinh.Nguyen@freescale.com>
> ---
>  arch/arm/plat-mxc/ehci.c                    |    4 +++
>  arch/arm/plat-mxc/include/mach/iomux-mx51.h |   33 ++++++++++++++++----------
>  2 files changed, 24 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/ehci.c b/arch/arm/plat-mxc/ehci.c
> index cb0b638..20eaddc 100644
> --- a/arch/arm/plat-mxc/ehci.c
> +++ b/arch/arm/plat-mxc/ehci.c
> @@ -186,6 +186,10 @@ int mxc_set_usbcontrol(int port, unsigned int flags)
>  		return 0;
>  	}
>  #endif /* CONFIG_MACH_MX27 */
> +#ifdef CONFIG_ARCH_MX5
> +	/* Nothing needs to be done for MX5 here */
> +	return 0;
> +#endif

This needs a cpu_is_mx5() condition. For now that's just nit-picking,
but once another platform is added, the statement will return where it
shouldn't.

Daniel
