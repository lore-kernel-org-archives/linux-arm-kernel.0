From: peter.senna@collabora.com (Peter Senna Tschudin)
Date: Wed, 10 May 2017 15:17:22 +0200
Subject: Regression: 442ec4c04d1: PCI: dwc: all: Split struct pcie_port
 into host-only and core structures
In-Reply-To: <CAOMZO5CXjb7LVT5ByP1RqgBPkkfRn7PcRPmW3hos=UNXGnok=A@mail.gmail.com>
References: <20170508150224.GA7458@collabora.com>
 <CAOMZO5DjFxAus3B03Om0xoqxKuY2TkbcjCY1YEUK9s_R8C_DNA@mail.gmail.com>
 <20170509063439.GC9791@collabora.com>
 <CAOMZO5CXjb7LVT5ByP1RqgBPkkfRn7PcRPmW3hos=UNXGnok=A@mail.gmail.com>
Message-ID: <20170510131722.GA29556@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 09, 2017 at 07:21:24AM -0300, Fabio Estevam wrote:
> Hi Peter,
> 
> On Tue, May 9, 2017 at 3:34 AM, Peter Senna Tschudin
> <peter.senna@collabora.com> wrote:
> 
> > Something that ocurred to me is that u-boot is initializing the PCI, and
> > the PCI networkd cards.  Ideally this should not affect anything, but
> > can this be related to the issue?
> 
> Yes, in order to narrow things down: please boot 4.11 without PCI
> support in U-Boot.

Yes, removing the PCI code from u-boot makes 4.11 to boot. But latest
next still hangs.

> 
> The problem is that mx6q does not have a way to properly reset the PCI block.
> 
> On the board I tested there is no PCI support in U-Boot.
> 
> Maybe we need the following approach in U-Boot as Lucas did for Barebox:
> https://git.pengutronix.de/cgit/barebox/commit/?id=f1da98da2760c21487bbba8f7fb957c843a22896

Maybe we do need, but the kernel is working on v4.10 for our use case,
and it is not working any longer on v4.11. What is the way to continue
from here?

> 
> According to this patch that went into 4.11 the bootloader must put
> PCI back in a safe state:
> https://patchwork.kernel.org/patch/9528911
