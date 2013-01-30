From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 30 Jan 2013 16:36:59 +0100
Subject: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
In-Reply-To: <20130130151934.GK23505@n2100.arm.linux.org.uk>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130130113245.GH23505@n2100.arm.linux.org.uk>
 <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de>
 <20130130150856.GJ23505@n2100.arm.linux.org.uk>
 <20130130151934.GK23505@n2100.arm.linux.org.uk>
Message-ID: <20130130163659.75360dba@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Russell King - ARM Linux,

On Wed, 30 Jan 2013 15:19:34 +0000, Russell King - ARM Linux wrote:
> diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
> index db9fedb..bba0cf3 100644
> --- a/arch/arm/include/asm/mach/pci.h
> +++ b/arch/arm/include/asm/mach/pci.h
> @@ -29,6 +29,7 @@ struct hw_pci {
>  	void		(*postinit)(void);
>  	u8		(*swizzle)(struct pci_dev *dev, u8 *pin);
>  	int		(*map_irq)(const struct pci_dev *dev, u8 slot, u8 pin);
> +	resource_size_t	(*window_align)(struct pci_bus *, unsigned long);
>  };

Didn't you say just yesterday that you would prefer a numerical value
rather than a hook that could do random things? :-)

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
