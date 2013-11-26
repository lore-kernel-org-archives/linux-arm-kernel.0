From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 26 Nov 2013 13:23:28 -0500
Subject: [PATCH] PCI: mvebu - The bridge secondary status register
 should be 0
In-Reply-To: <1385488975-27694-1-git-send-email-jgunthorpe@obsidianresearch.com>
References: <1385488975-27694-1-git-send-email-jgunthorpe@obsidianresearch.com>
Message-ID: <20131126182328.GP2879@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 26, 2013 at 11:02:52AM -0700, Jason Gunthorpe wrote:
> There are no writable bits in the secondary status register, only
> write 1 to clear bits. The driver never sets any of the write 1 to
> clear bits so the status register should always be 0, just remove
> the set from the write path.
> 
> Someday the write 1 to clear bits should be copied/cleared directly
> from registers in the HW.
> 
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> ---
>  drivers/pci/host/pci-mvebu.c | 1 -
>  1 file changed, 1 deletion(-)

Whole series

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
