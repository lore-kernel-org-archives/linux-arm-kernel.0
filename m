From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 23 Nov 2013 23:00:26 -0500
Subject: [PATCH 1/2] PCI: mvebu - The bridge should obey the MEM and IO
 command bits
In-Reply-To: <20131124030033.GR29241@titan.lakedaemon.net>
References: <1383262380-6984-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <20131124030033.GR29241@titan.lakedaemon.net>
Message-ID: <20131124040026.GA29241@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 23, 2013 at 10:00:33PM -0500, Jason Cooper wrote:
> On Thu, Oct 31, 2013 at 05:32:59PM -0600, Jason Gunthorpe wrote:
> > When PCI_COMMAND_MEMORY/PCI_COMMAND_IO are cleared the bridge should not
> > allocate windows or even look at the window limit/base registers.
> > 
> > Otherwise it can attempt to setup bogus windows that the PCI core code
> > creates during discovery. The core will leave PCI_COMMAND_IO cleared if
> > it doesn't need an IO window.
> > 
> > Have mvebu_pcie_handle_*_change respect the bits, and call the change
> > function whenever the bits changes.
> > 
> > Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> > ---
> >  drivers/pci/host/pci-mvebu.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> And a small addendum: I currently have the following in mvebu/drivers

Strike that, they are now in mvebu/pci.

>   572bd682145f PCI: mvebu - The bridge secondary status register should be 0
>   9503c7fe4d9d PCI: mvebu - Support a bridge with no IO port window
>   058100a08be8 PCI: mvebu: return NULL instead of ERR_PTR(ret)
> 
> which means they didn't make it in for v3.13-rc1.  I'll hold them there
> for reference until you resend.

thx,

Jason.
