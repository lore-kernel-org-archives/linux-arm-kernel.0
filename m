From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 29 May 2013 00:20:53 +0200
Subject: [PATCH] arm: kirkwood: convert NETGEAR ReadyNAS Duo v2 to use
 DT for the PCIe interface
In-Reply-To: <8738t6ycnm.fsf@natisbad.org>
References: <8738t6ycnm.fsf@natisbad.org>
Message-ID: <20130529002053.4b8ceb86@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnaud Ebalard,

On Wed, 29 May 2013 00:15:09 +0200, Arnaud Ebalard wrote:

> Thomas, I am following your work on PCIe support for a .dts file I am
> working on for (Armada 370-based) Netgear ReadyNAS 102 and noticed your
> set of patches to convert kirkwood-based boards to use it in order to
> simplify/remove board specific code.

Nice!

> Jason, I gave your associated branch (jcooper/mvebu-next/pcie) a try
> with following patch applied and can confirm USB 3.0 host controller
> (connected to PCIe bus) is usable on Netgear ReadyNAS *Duo v2*
> (88f6282-based brother of the 102).
> 
> Note that I had to s/of_pci_range_parser()/of_pci_range_parser_init()/
> in drivers/pci/host/pci-mvebu.c to compile the kernel (this may already
> have been fixed already):
> 
> CHK     kernel/config_data.h
> drivers/pci/host/pci-mvebu.c: In function ?mvebu_pcie_probe?:
> drivers/pci/host/pci-mvebu.c:742:2: error: implicit declaration of function ?of_pci_range_parser? [-Werror=implicit-function-declaration]
> cc1: some warnings being treated as errors

You're probably not using the latest mvebu/pcie branch from jcooper. In
his branch, I see:

+       if (of_pci_range_parser_init(&parser, np))
+               return -EINVAL;

Which should do the right thing.

Could you check that you're running on top of the latest
jcooper/mvebu/pcie branch? Thanks!

> Can one of you take the patch below into account? Or 

You should probably resend your patch with a proper description. Your
description now includes a lot information about unrelated things (the
Armada 370 board you're working on, the build failure you had, etc.).

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
