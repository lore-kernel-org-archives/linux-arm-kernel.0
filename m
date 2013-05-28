From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 28 May 2013 18:38:17 -0400
Subject: [PATCH] arm: kirkwood: convert NETGEAR ReadyNAS Duo v2 to use
 DT for the PCIe interface
In-Reply-To: <20130529002053.4b8ceb86@skate>
References: <8738t6ycnm.fsf@natisbad.org>
 <20130529002053.4b8ceb86@skate>
Message-ID: <20130528223817.GL31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 29, 2013 at 12:20:53AM +0200, Thomas Petazzoni wrote:
> On Wed, 29 May 2013 00:15:09 +0200, Arnaud Ebalard wrote:
> > Jason, I gave your associated branch (jcooper/mvebu-next/pcie) a try
> > with following patch applied and can confirm USB 3.0 host controller
> > (connected to PCIe bus) is usable on Netgear ReadyNAS *Duo v2*
> > (88f6282-based brother of the 102).
> > 
> > Note that I had to s/of_pci_range_parser()/of_pci_range_parser_init()/
> > in drivers/pci/host/pci-mvebu.c to compile the kernel (this may already
> > have been fixed already):
> > 
> > CHK     kernel/config_data.h
> > drivers/pci/host/pci-mvebu.c: In function ?mvebu_pcie_probe?:
> > drivers/pci/host/pci-mvebu.c:742:2: error: implicit declaration of function ?of_pci_range_parser? [-Werror=implicit-function-declaration]
> > cc1: some warnings being treated as errors
> 
> You're probably not using the latest mvebu/pcie branch from jcooper. In
> his branch, I see:
> 
> +       if (of_pci_range_parser_init(&parser, np))
> +               return -EINVAL;
> 
> Which should do the right thing.
> 
> Could you check that you're running on top of the latest
> jcooper/mvebu/pcie branch? Thanks!

Actually, you want jcooper/mvebu/pcie_kirkwood.  I split out the
kirkwood driver so that if it causes a build breakage and gets dropped,
mvebu/pcie can still go in.

> > Can one of you take the patch below into account? Or 
> 
> You should probably resend your patch with a proper description. Your
> description now includes a lot information about unrelated things (the
> Armada 370 board you're working on, the build failure you had, etc.).

That stuff can go below the '---' in the future.  Don't stress about it,
though.  I'll clean it up when I apply it if needed.

thx,

Jason.
