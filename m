From: ralf@linux-mips.org (Ralf Baechle)
Date: Tue, 2 Aug 2011 10:56:04 +0100
Subject: [PATCH] arm: fix compile failure in orion5x/dns323-setup.c
In-Reply-To: <1312216934-29710-1-git-send-email-paul.gortmaker@windriver.com>
References: <1312216934-29710-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <20110802095604.GA22637@linux-mips.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 01, 2011 at 12:42:14PM -0400, Paul Gortmaker wrote:

> index a6eddae..c105556 100644
> --- a/arch/arm/mach-orion5x/dns323-setup.c
> +++ b/arch/arm/mach-orion5x/dns323-setup.c
> @@ -77,7 +77,7 @@ static int __init dns323_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
>  	/*
>  	 * Check for devices with hard-wired IRQs.
>  	 */
> -	irq = orion5x_pci_map_irq(const dev, slot, pin);
> +	irq = orion5x_pci_map_irq(dev, slot, pin);

Very obviously correct ...

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
