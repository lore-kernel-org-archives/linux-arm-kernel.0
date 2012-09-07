From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 7 Sep 2012 09:49:38 +0100
Subject: [PATCH 2/2] ARM: kexec: Check segment memory addresses
In-Reply-To: <1347007260-13271-3-git-send-email-matthew.leach@arm.com>
References: <1347007260-13271-1-git-send-email-matthew.leach@arm.com>
 <1347007260-13271-3-git-send-email-matthew.leach@arm.com>
Message-ID: <20120907084937.GC13739@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 07, 2012 at 09:41:00AM +0100, Matthew Leach wrote:
> Ensure that the memory regions that are set within the segments
> correspond to physical contiguous memory regions.
> 
> Reviewed-by: Simon Horman <horms@verge.net.au>
> Reviewed-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Matthew Leach <matthew.leach@arm.com>

What about platforms which pull out bits of physical RAM from memblock
via arm_memblock_steal() ?  Doesn't this mean such platforms will reduce
their available memory on each subsequent kexec?
