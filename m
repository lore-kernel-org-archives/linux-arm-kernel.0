From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 12 May 2012 10:40:03 +0100
Subject: [PATCH] ARM: integrator: fix typo in PCI swizzle function
In-Reply-To: <1336813546-25766-1-git-send-email-linus.walleij@linaro.org>
References: <1336813546-25766-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20120512094003.GA10453@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 12, 2012 at 11:05:46AM +0200, Linus Walleij wrote:
> The next tree didn't compile due to a typo in commit
> cfb32a689949d09f112493de4a1e3e5900db2053
> "ARM: PCI: integrator: use common PCI swizzle"
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Do you want me to merge this into the original commit?

> ---
>  arch/arm/mach-integrator/pci.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-integrator/pci.c b/arch/arm/mach-integrator/pci.c
> index 40f4b4f..6c1667e 100644
> --- a/arch/arm/mach-integrator/pci.c
> +++ b/arch/arm/mach-integrator/pci.c
> @@ -73,7 +73,7 @@ static u8 __init integrator_swizzle(struct pci_dev *dev, u8 *pinp)
>  	if (*pinp == 0)
>  		*pinp = 1;
>  
> -	return pci_std_swizzle(dev, pinp);
> +	return pci_common_swizzle(dev, pinp);
>  }
>  
>  static int irq_tab[4] __initdata = {
> -- 
> 1.7.7.6
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
