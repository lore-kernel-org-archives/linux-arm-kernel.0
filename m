From: chansen3@cisco.com (Christian Hansen (chansen3))
Date: Mon, 14 May 2018 15:09:30 +0000
Subject: [PATCH] arm64: allowing mmap to be traced
In-Reply-To: <1526308362-45443-1-git-send-email-chansen3@cisco.com>
References: <1526308362-45443-1-git-send-email-chansen3@cisco.com>
Message-ID: <370F7C12-ADF7-4365-BA32-35148B7D0280@cisco.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Indeed, you have the quicker draw.  I concede to your patch.

?On 2018-05-14, 10:32 AM, "Christian Hansen (chansen3)" <chansen3@cisco.com> wrote:

    Adding missing macro which is present all other system calls to
    to mmap declaration for ARM.  This allows it to appear as a kernel
    tracing target.
    
    Signed-off-by: Christian Hansen <chansen3@cisco.com>
    ---
     arch/arm64/kernel/sys.c | 6 +++---
     1 file changed, 3 insertions(+), 3 deletions(-)
    
    diff --git a/arch/arm64/kernel/sys.c b/arch/arm64/kernel/sys.c
    index 72981ba..1ccdbfc 100644
    --- a/arch/arm64/kernel/sys.c
    +++ b/arch/arm64/kernel/sys.c
    @@ -27,9 +27,9 @@
     #include <linux/syscalls.h>
     #include <asm/cpufeature.h>
     
    -asmlinkage long sys_mmap(unsigned long addr, unsigned long len,
    -			 unsigned long prot, unsigned long flags,
    -			 unsigned long fd, off_t off)
    +SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
    +		unsigned long, prot, unsigned long, flags,
    +		unsigned long, fd, off_t, off)
     {
     	if (offset_in_page(off) != 0)
     		return -EINVAL;
    -- 
    2.5.0
    
    
