From: helgaas@kernel.org (Bjorn Helgaas)
Date: Fri, 22 Jul 2016 10:51:33 -0500
Subject: Why does BIOS assign memory to 16 byte BAR
In-Reply-To: <20160722151546.GA20646@localhost>
References: <8520D5D51A55D047800579B094147198258BB59B@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20160722151546.GA20646@localhost>
Message-ID: <20160722155133.GB20646@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 22, 2016 at 10:15:46AM -0500, Bjorn Helgaas wrote:
> Hi Bharat,
> 
> On Fri, Jul 22, 2016 at 09:24:22AM +0000, Bharat Kumar Gogada wrote:
> > Hi,
> > 
> > I'm observing that on x86 BIOS successfully assigns memory if an End point requests
> > BAR of size 16byte.
> > 
> > But as per Spec:
> > The minimum memory address range requested by a BAR is 128 bytes.
> 
> Can you provide the spec reference for this?  I don't see it in PCI
> r3.0.
>
> PCI r3.0, sec 6.2.5.1, shows bits 4-31 of a memory BAR as writable,
> which would correspond to a minimum size of 16 bytes.

The reference above is to the conventional PCI spec.  I happened to
trip over a note in PCIe r3.0, sec 1.3.2.2, that for a PCI Express
endpoint, "the minimum memory address range requested by a BAR is 128
bytes."

I don't think linux currently enforces this minimum.

Bjorn
