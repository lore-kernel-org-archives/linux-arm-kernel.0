From: rubini@gnudd.com (Alessandro Rubini)
Date: Mon, 28 May 2012 10:34:43 +0200
Subject: amba, tegra-ahb and pci (Kconfig question)
In-Reply-To: <20120528082452.GH24149@n2100.arm.linux.org.uk>
References: <20120528082452.GH24149@n2100.arm.linux.org.uk>
 <20120528081737.GA8031@mail.gnudd.com>
Message-ID: <20120528083443.GA8599@mail.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Normally, ARM_AMBA is selected when required, so this would be:
> 
> config PCI_AMBA
> 	bool "PCI-to-AMBA bridge"
> 	depends on PCI
> 	select ARM_AMBA

But this would open the new question in a zillion boards that are
not interested in it. It's the board that selects arm-amba, in my opinion.
 
> I guess I should look at moving ARM_AMBA to drivers/amba/Kconfig too...

If you want I can submit a patch for this (btw, the rename to primecell
is dead, isn't it?)

thanks
/alessandro
