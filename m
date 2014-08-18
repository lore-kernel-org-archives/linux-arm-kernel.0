From: bhelgaas@google.com (Bjorn Helgaas)
Date: Mon, 18 Aug 2014 12:49:33 -0600
Subject: [PATCH v5] pcie: Add Xilinx PCIe Host Bridge IP driver
In-Reply-To: <CA+mB=1LX=yOqkx1xNoCBQLbYna76qAeRTqiW6SDpb1MYco7ZVQ@mail.gmail.com>
References: <1406131381-25577-1-git-send-email-sthokal@xilinx.com>
 <CA+mB=1JhDF=BBXcyTbgVB8S7qH=Mb1JH78HLL4pA9OBH19hQvA@mail.gmail.com>
 <8258903.Rn4s07GKGV@wuerfel>
 <CA+mB=1LeZn1k2VHNby2TRBcb1xuFFTQio=C845_xe2A=ZciYqg@mail.gmail.com>
 <53E9E052.3070308@monstr.eu>
 <CA+mB=1LX=yOqkx1xNoCBQLbYna76qAeRTqiW6SDpb1MYco7ZVQ@mail.gmail.com>
Message-ID: <20140818184933.GA2028@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 18, 2014 at 02:47:23PM +0530, Srikanth Thokala wrote:
> Hi Michal,
> 
> On Tue, Aug 12, 2014 at 3:07 PM, Michal Simek <monstr@monstr.eu> wrote:
> > Hi Bjorn,
> >
> > On 07/30/2014 01:24 PM, Srikanth Thokala wrote:
> >> Hi Arnd,
> >>
> >> On Mon, Jul 28, 2014 at 6:32 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >>> On Monday 28 July 2014 18:04:34 Srikanth Thokala wrote:
> >>>> Hi Arnd and Rob,
> >>>>
> >>>> I discussed with Bjorn and we believe this patch is in good shape to
> >>>> apply.  And Bjorn requires ACKs to apply this patch.  So, could you
> >>>> guys please review this patch and provided your ACKs to this patch.
> >>>
> >>> Looks great for the most part. I've looked through the whole driver
> >>> again, and I have two small issues remaining:
> >>>
> >>> a) Please clarify in the changeset description why there is no support
> >>>    for PCI I/O space.
> >>
> >> Sure, I will add to my changeset.
> >>
> >>>
> >>> b) I think you should use the 'msi-parent' property, and the
> >>>    of_pci_find_msi_chip_by_node() to find the msi_chip for the
> >>>    PCI controller. This will make it possible to forward MSIs
> >>>    to the main interrupt controller in the system, which is more
> >>>    efficient. See the pcie-mvebu driver for an example of this.
> >>
> >> Ok, I need to look into this and I will plan to implement on top of this patch.
> >>
> >>>
> >>> Other than these:
> >>>
> >>> Acked-by: Arnd Bergmann <arnd@arndb.de>
> >>
> >> Thanks Arnd for the Ack.
> >
> > What's the status on this one?
> 
> It looks like Bjorn is on vacation.  I have sent v6 patch by adding
> Ack from Arnd, which
> I feel is in good shape to be applied.

I actually started applying this last night (see [1]), but got some
errors from the build-bot (attached).  I haven't looked into them,
but my guess is that you're missing a Kconfig dependency or something
equally minor.

Bjorn

[1] http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=pci/host-xilinx&id=a58f3d0c3b1c4a71a2418c3306fba86c26a49781
-------------- next part --------------
An embedded message was scrubbed...
From: kbuild test robot <fengguang.wu@intel.com>
Subject: [pci:pci/host-xilinx] a58f3d0c3b1c4a71a2418c3306fba86c26a49781 BUILD DONE
Date: Mon, 18 Aug 2014 12:40:06 +0800
Size: 9057
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140818/4bd2db8f/attachment-0002.mht>
-------------- next part --------------
An embedded message was scrubbed...
From: kbuild test robot <fengguang.wu@intel.com>
Subject: [pci:pci/host-xilinx 1/1] WARNING: drivers/built-in.o(.text+0x64acc): Section mismatch in reference from the function xilinx_pcie_probe() to the function .init.text:xilinx_pcie_scan_bus()
Date: Mon, 18 Aug 2014 15:16:51 +0800
Size: 2891
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140818/4bd2db8f/attachment-0003.mht>
