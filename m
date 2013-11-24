From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 23 Nov 2013 21:58:08 -0500
Subject: [PATCH 1/2] PCI: mvebu - The bridge should obey the MEM and IO
 command bits
In-Reply-To: <1383262380-6984-1-git-send-email-jgunthorpe@obsidianresearch.com>
References: <1383262380-6984-1-git-send-email-jgunthorpe@obsidianresearch.com>
Message-ID: <20131124025808.GQ29241@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

On Thu, Oct 31, 2013 at 05:32:59PM -0600, Jason Gunthorpe wrote:
> When PCI_COMMAND_MEMORY/PCI_COMMAND_IO are cleared the bridge should not
> allocate windows or even look at the window limit/base registers.
> 
> Otherwise it can attempt to setup bogus windows that the PCI core code
> creates during discovery. The core will leave PCI_COMMAND_IO cleared if
> it doesn't need an IO window.
> 
> Have mvebu_pcie_handle_*_change respect the bits, and call the change
> function whenever the bits changes.
> 
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> ---
>  drivers/pci/host/pci-mvebu.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

I'd like to get back on track with these small patches being Acked by
mvebu maintainers and then going through Bjorn.  Could you please resend
an updated patchset for this and 2/2?

thx,

Jason.
