From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Fri, 06 May 2016 12:51:00 +0100
Subject: [PATCH] arm64: Make arch_randomize_brk avoid stack area
In-Reply-To: <20160506111937.GK20671@e104818-lin.cambridge.arm.com>
References: <1461848638.2848.19.camel@linaro.org>
 <1462370994.2895.11.camel@linaro.org>
 <20160506111937.GK20671@e104818-lin.cambridge.arm.com>
Message-ID: <1462535460.4575.3.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-05-06 at 12:19 +0100, Catalin Marinas wrote:
> Hi Tixy,
> 
> On Wed, May 04, 2016 at 03:09:54PM +0100, Jon Medhurst (Tixy) wrote:
> > Note, in practice, since commit d1fd836dcf00 ("mm: split ET_DYN ASLR
> > from mmap ASLR") this problem shouldn't occur because the address chosen
> > for loading binaries is well clear of the stack, however, prior to that
> > the problem does occur because of the following...
> 
> [...]
> 
> > These changes have been tested on Linux v4.6-rc4 using 100000
> > invocations of a program [1] that can display the offset of a process's
> > brk...
> 
> [...]
> 
> > Signed-off-by: Jon Medhurst <tixy@linaro.org>
> > Cc: <stable@vger.kernel.org> # 4.0 and earlier
> 
> I don't fully understand what we are supposed to do with this patch.
> Should it only be applied to stable kernels prior to 4.0? Do we need it
> in mainline? As you stated above, this problem does not exist in recent
> kernels.

Well, if you think it's worthwhile defensive programming against future
changes to elf loader, then it could go into latest kernels. Otherwise,
then yes, it's for Linux 4.0 and earlier. What's the process for that,
email it to stable at vger.kernel.org direct? Is that OK without an Ack
from an arm64 maintainer?

-- 
Tixy
