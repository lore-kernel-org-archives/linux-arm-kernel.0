From: will.deacon@arm.com (Will Deacon)
Date: Tue, 5 May 2015 11:53:29 +0100
Subject: [PATCH 4/4] arm64: gicv3: its: Increase FORCE_MAX_ZONEORDER for
 Cavium ThunderX
In-Reply-To: <1430686172-18222-5-git-send-email-rric@kernel.org>
References: <1430686172-18222-1-git-send-email-rric@kernel.org>
 <1430686172-18222-5-git-send-email-rric@kernel.org>
Message-ID: <20150505105329.GC1550@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 03, 2015 at 09:49:32PM +0100, Robert Richter wrote:
> From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
> 
> In case of ARCH_THUNDER, there is a need to allocate the GICv3 ITS table
> which is bigger than the allowed max order. So we are forcing it only in
> case of 4KB page size.

Does this problem disappear if the ITS driver uses dma_alloc_coherent
instead? That would also allow us to remove the __flush_dcache_area abuse
from the driver.

Will
