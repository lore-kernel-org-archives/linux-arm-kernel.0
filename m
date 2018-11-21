From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 21 Nov 2018 13:01:28 +0100
Subject: [PATCH] clk: zynq: do not allow kmalloc failure
In-Reply-To: <1542795390-16221-1-git-send-email-hofrat@osadl.org>
References: <1542795390-16221-1-git-send-email-hofrat@osadl.org>
Message-ID: <e5e7b0be-8d45-ec7a-618d-8248a41e2361@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21. 11. 18 11:16, Nicholas Mc Guire wrote:
>  The kmalloc here is small (< 16 bytes) and occurs during initialization

no reason for space in front of "The"

> during system startup here (can not be built as module) thus if this
> kmalloc failed it is an indication of something more serious going on
> and it is fine to hang the system here rather than cause some harder
> to understand error by dereferencing NULL.
> 
>  Explicitly checking would not make that much sense here as the only

ditto.

> possible reaction would be would BUG() here anyway.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> 
> Problem located with experimental coccinelle script
> 
> Patch was compile tested with: multi_v7_defconfig (implies
> CONFIG_ARCH_ZYNQ=y)
> 
> Patch is against 4.20-rc3 (localversion-next is next-20181121)

I have no problem with the patch but things below your SoB shouldn't
land in the git history.

When this is fixed feel free to add my
Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
