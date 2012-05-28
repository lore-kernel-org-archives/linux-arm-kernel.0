From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 May 2012 09:24:52 +0100
Subject: amba, tegra-ahb and pci (Kconfig question)
In-Reply-To: <20120528081737.GA8031@mail.gnudd.com>
References: <20120528081737.GA8031@mail.gnudd.com>
Message-ID: <20120528082452.GH24149@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 28, 2012 at 10:17:37AM +0200, Alessandro Rubini wrote:
> If the former (CONFIG_PCI_AMBA), where should the symbol be defined?
> My personal preference is doing it like this, plus help message:
> 
>    config PCI_AMBA
>           bool "PCI-to-AMBA bridge"
>           depends on ARM_AMBA && PCI
> 
> In this case, shall I name CONFIG_STA2X11 in the depends, or in the
> help message, or I'd better be generic, knowing someone else will soon
> have similar things?

Normally, ARM_AMBA is selected when required, so this would be:

config PCI_AMBA
	bool "PCI-to-AMBA bridge"
	depends on PCI
	select ARM_AMBA

I guess I should look at moving ARM_AMBA to drivers/amba/Kconfig too...
