From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 22 Apr 2014 16:11:39 +0200
Subject: [RFC PATCH 2/2] PCI: exynos: Add PCIe support for Samsung GH7 SoC
In-Reply-To: <000a01cf592e$67e592e0$37b0b8a0$%han@samsung.com>
References: <000801cf592e$30b7bff0$92273fd0$%han@samsung.com>
 <000a01cf592e$67e592e0$37b0b8a0$%han@samsung.com>
Message-ID: <201404221611.40087.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 April 2014, Jingoo Han wrote:
> Samsung GH7 has four PCIe controllers which can be used as root
> complex for PCIe interface.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/pci/host/Kconfig      |    2 +-
>  drivers/pci/host/pci-exynos.c |  135 ++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 126 insertions(+), 11 deletions(-)

Can you explain how much the GH7 and Exynos front-ends actually have in
common? Would it make sense to have a separate driver for gh7?

Also, if gh7 is expected to run a full firmware, I think you should
do all the setup in the firmware before booting Linux, and just
do the required run-time operations in the driver itself.

	Arnd
