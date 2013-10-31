From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 31 Oct 2013 09:54:46 +0100
Subject: [PATCH] PCI: mvebu - The bridge secondary status register
 should be 0
In-Reply-To: <1381868190-8595-1-git-send-email-jgunthorpe@obsidianresearch.com>
References: <1381868190-8595-1-git-send-email-jgunthorpe@obsidianresearch.com>
Message-ID: <20131031095446.3c95fbb5@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Gunthorpe,

On Tue, 15 Oct 2013 14:16:30 -0600, Jason Gunthorpe wrote:
> There are no writable bits in the secondary status register, only
> write 1 to clear bits. The driver never sets any of the write 1 to
> clear bits so the status register should always be 0, just remove
> the set from the write path.
> 
> Someday the write 1 to clear bits should be copied/cleared directly
> from registers in the HW.
> 
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
