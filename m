From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 17 Oct 2013 09:12:01 -0400
Subject: [PATCH] PCI: mvebu - The bridge secondary status register
 should be 0
In-Reply-To: <1381868190-8595-1-git-send-email-jgunthorpe@obsidianresearch.com>
References: <1381868190-8595-1-git-send-email-jgunthorpe@obsidianresearch.com>
Message-ID: <20131017131201.GE22434@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 15, 2013 at 02:16:30PM -0600, Jason Gunthorpe wrote:
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

Applied to mvebu/drivers

thx,

Jason.
