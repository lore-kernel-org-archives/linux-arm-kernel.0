From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 25 Nov 2013 18:09:35 +0100
Subject: [PATCH 1/2] PCI: mvebu - The bridge should obey the MEM and IO
 command bits
In-Reply-To: <1383262380-6984-1-git-send-email-jgunthorpe@obsidianresearch.com>
References: <1383262380-6984-1-git-send-email-jgunthorpe@obsidianresearch.com>
Message-ID: <20131125180935.37ee3222@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Gunthorpe,

On Thu, 31 Oct 2013 17:32:59 -0600, Jason Gunthorpe wrote:
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

Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
