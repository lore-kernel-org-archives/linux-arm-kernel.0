From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 24 Sep 2014 18:14:11 +0200
Subject: [PATCH 5/6] arm64, defconfig: Enable PCI
In-Reply-To: <1411573068-12952-6-git-send-email-rric@kernel.org>
References: <1411573068-12952-1-git-send-email-rric@kernel.org>
 <1411573068-12952-6-git-send-email-rric@kernel.org>
Message-ID: <7901403.qjKNmO519a@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 September 2014 17:37:47 Robert Richter wrote:
>  config PCI
>         bool "PCI support"
> +       default y
>         help
>           This feature enables support for PCIe bus system. If you say Y
>           here, the kernel will include drivers and infrastructure code
>           to support PCIe bus devices.
>  
> +config PCI_MSI
> +       def_bool PCI
> +
>  config PCI_DOMAINS
>         def_bool PCI

There is already a PCI_MSI symbol in drivers/pci/Kconfig. Just select that
from the PCI symbol above rather than defining a second one.

	Arnd
