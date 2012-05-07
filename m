From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 May 2012 08:42:28 +0100
Subject: [PATCHv5 1/3] ARM: tegra: Add Tegra AHB driver
In-Reply-To: <1336373032-16881-1-git-send-email-hdoyu@nvidia.com>
References: <1336373032-16881-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <20120507074228.GK26481@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 07, 2012 at 09:43:45AM +0300, Hiroshi DOYU wrote:
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 5870322..d97e2e2 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -18,7 +18,7 @@ obj-$(CONFIG_SFI)		+= sfi/
>  # PnP must come after ACPI since it will eventually need to check if acpi
>  # was used and do nothing if so
>  obj-$(CONFIG_PNP)		+= pnp/
> -obj-$(CONFIG_ARM_AMBA)		+= amba/
> +obj-$(CONFIG_ARM)		+= amba/

NAK.  This makes amba only buildable for ARM which is not the intention.
Other architectures do have Primecells.
