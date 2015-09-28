From: david.vrabel@citrix.com (David Vrabel)
Date: Mon, 28 Sep 2015 14:52:00 +0100
Subject: [Xen-devel] [PATCH] xen/pci: Don't build Xen pci code for ARM
 and ARM64
In-Reply-To: <1443447044-24985-1-git-send-email-julien.grall@citrix.com>
References: <1443447044-24985-1-git-send-email-julien.grall@citrix.com>
Message-ID: <56094600.7050508@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/09/15 14:30, Julien Grall wrote:
> The PCI support for Xen doesn't compile on ARM/ARM64 when
> CONFIG_PCI_MMCONFIG=y:
> 
> drivers/xen/pci.c:31:25: fatal error: asm/pci_x86.h: No such file or
> directory
>  #include <asm/pci_x86.h>
> 
> Although, Xen is not currently involved in PCI management for ARM/ARM64.
> There is plan to support it, but it would require some changes in Linux
> side.
> 
> For now, introduce a new config options XEN_PCI which will be turned off
> for ARM platform.

Since PCI_MMCONFIG isn't x86 specific and its use in drivers/xen/pci.c
is, can you fix this by changing to #ifdef CONFIG_X86?

David
