From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 29 Oct 2012 08:00:57 +0000
Subject: [PATCH v4 5/5] zynq: move static peripheral mappings
In-Reply-To: <7a663040dc05b79262d7bd8bf8224ca49eb00162.1351466765.git.josh.cartwright@ni.com>
References: <cover.1351466765.git.josh.cartwright@ni.com>
 <7a663040dc05b79262d7bd8bf8224ca49eb00162.1351466765.git.josh.cartwright@ni.com>
Message-ID: <736cec0d-a996-4cc9-95af-7912b372fb8c@CH1EHSMHS010.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Josh Cartwright [mailto:josh.cartwright at ni.com]
> Sent: Monday, October 22, 2012 4:16 AM
> To: arm at kernel.org; Arnd Bergmann
> Cc: linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; John
> Linn; Nick Bowler; Michal Simek
> Subject: [PATCH v4 5/5] zynq: move static peripheral mappings
>
> Shifting them up into the vmalloc region prevents the following warning, when
> booting a zynq qemu target with more than 512mb of RAM:
>
>   BUG: mapping for 0xe0000000 at 0xe0000000 out of vmalloc space
>
> In addition, it allows for reuse of these mappings when the proper drivers issue
> requests via ioremap().
>
> There are currently unknown issues with the early uart mapping.  For now, the
> uart will be mapped to a known working address.
>
> Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
> Cc: John Linn <john.linn@xilinx.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-zynq/common.c                |  6 +++---
>  arch/arm/mach-zynq/include/mach/zynq_soc.h | 25 +++++++++++++++----------
>  2 files changed, 18 insertions(+), 13 deletions(-)
>

Tested and applied to http://git.xilinx.com/?p=linux-xlnx.git;a=shortlog;h=refs/heads/arm-next

Thanks,
Michal




This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
