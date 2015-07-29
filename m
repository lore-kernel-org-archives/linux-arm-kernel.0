From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Jul 2015 16:30:21 +0200
Subject: [PATCH] PCI: iproc: Fix BCMA dependency in Kconfig
In-Reply-To: <1438109533-28694-1-git-send-email-rjui@broadcom.com>
References: <1438109533-28694-1-git-send-email-rjui@broadcom.com>
Message-ID: <33449873.RA3z6vhrMA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 28 July 2015 11:52:13 Ray Jui wrote:
>  config PCIE_IPROC_BCMA
>         bool "Broadcom iProc PCIe BCMA bus driver"
> -       depends on ARCH_BCM_IPROC || (ARM && COMPILE_TEST)
> +       depends on ARCH_BCM_IPROC && ARM
>         select PCIE_IPROC
>         select BCMA
>         select PCI_DOMAINS
> 

How about this:

	depends on ARM && (ARCH_BCM_IPROC || COMPILE_TEST)

That would leave the compile test present for non-iproc
ARM platforms while preventing ARM64 and MIPS builds with
ARCH_BCM_IPROC set.

	Arnd
