From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 1 Oct 2013 11:22:59 -0600
Subject: [PATCH v2] bus: mvebu-mbus: Fix optional pcie-mem/io-aperture
 properties
In-Reply-To: <20131001170918.GF31178@titan.lakedaemon.net>
References: <20130917201104.GA5209@obsidianresearch.com>
 <20131001164409.GC31178@titan.lakedaemon.net>
 <20131001165045.GB23874@obsidianresearch.com>
 <20131001170918.GF31178@titan.lakedaemon.net>
Message-ID: <20131001172259.GA19668@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 01:09:18PM -0400, Jason Cooper wrote:
> Ok, I've moved it over the mvebu/fixes and amended the commit as
> follows:
> 
> """
>     bus: mvebu-mbus: Fix optional pcie-mem/io-aperture properties
>     
>     If the property was not specified then the returned resource had a
>     resource_size(..) == 1, rather than 0. The PCI-E driver checks for 0 so it
>     blindly continues on with a corrupted resource.
>     
>     The regression was introduced into v3.12 by:
>     
>       11be654 PCI: mvebu: Adapt to the new device tree layout
>     
> """

Reads fine to me, thanks
 
> > This patch is a necessary precondition to applying:
> > 
> > https://github.com/jgunthorpe/linux/commit/ef90b0bf7d8552dc7dfaad82d964446f6a9b6a3b
> > PCI: mvebu - Support a bridge with no IO port window
> 
> I don't see this one in my stack, have you submitted it yet?  When you
> do, please add a note mentioning the dependency on this commit in
> mvebu/fixes.

Yes, I posted it along with the other PCI patches:

http://permalink.gmane.org/gmane.linux.kernel.pci/25498

Just so we are on the same page, these are the Kirkwood/mvebu patches
I was hoping to progress for 3.13:

https://github.com/jgunthorpe/linux/commit/9f20eec4696627afe87bf0f6a204909004062e8e
PCI: mvebu: Dynamically detect if the PEX link is up to enable hot plug
(Thomas soft ack'd this @ http://www.spinics.net/lists/linux-pci/msg25323.html)

https://github.com/jgunthorpe/linux/commit/ef90b0bf7d8552dc7dfaad82d964446f6a9b6a3b
PCI: mvebu - Support a bridge with no IO port window
(no comments)

And these which I think you have already taken:

ARM: kirkwood - Remove kirkwood_setup_wins and rely on the DT binding
ARM: kirkwood: Move the crypto node under the mbus node 
ARM: kirkwood: Move the nand node under the mbus node 
bus: mvebu-mbus: Fix optional pcie-mem/io-aperture properties

Thanks,
Jason
