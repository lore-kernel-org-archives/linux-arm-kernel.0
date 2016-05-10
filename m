From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 10 May 2016 16:55:58 +0100
Subject: [PATCH] arm64: Make arch_randomize_brk avoid stack area
In-Reply-To: <1462535460.4575.3.camel@linaro.org>
References: <1461848638.2848.19.camel@linaro.org>
 <1462370994.2895.11.camel@linaro.org>
 <20160506111937.GK20671@e104818-lin.cambridge.arm.com>
 <1462535460.4575.3.camel@linaro.org>
Message-ID: <20160510155557.GD3214@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 06, 2016 at 12:51:00PM +0100, Jon Medhurst (Tixy) wrote:
> On Fri, 2016-05-06 at 12:19 +0100, Catalin Marinas wrote:
> > On Wed, May 04, 2016 at 03:09:54PM +0100, Jon Medhurst (Tixy) wrote:
> > > Note, in practice, since commit d1fd836dcf00 ("mm: split ET_DYN ASLR
> > > from mmap ASLR") this problem shouldn't occur because the address chosen
> > > for loading binaries is well clear of the stack, however, prior to that
> > > the problem does occur because of the following...
> > 
> > [...]
> > 
> > > These changes have been tested on Linux v4.6-rc4 using 100000
> > > invocations of a program [1] that can display the offset of a process's
> > > brk...
> > 
> > [...]
> > 
> > > Signed-off-by: Jon Medhurst <tixy@linaro.org>
> > > Cc: <stable@vger.kernel.org> # 4.0 and earlier
> > 
> > I don't fully understand what we are supposed to do with this patch.
> > Should it only be applied to stable kernels prior to 4.0? Do we need it
> > in mainline? As you stated above, this problem does not exist in recent
> > kernels.
> 
> Well, if you think it's worthwhile defensive programming against future
> changes to elf loader, then it could go into latest kernels.

I don't think we should bother with latest upstream. AFAICT, with
splitting ET_DYN ASLR from the mmap one, we shouldn't hit this issue.
And I wouldn't expect the two regions to be unified again in the future.

> Otherwise, then yes, it's for Linux 4.0 and earlier. What's the
> process for that, email it to stable at vger.kernel.org direct?

Usually emailing stable at vger.kernel.org with an explanation of why it is
not needed in mainline since it is not a back-port.

> Is that OK without an Ack from an arm64 maintainer?

I guess it's up to the stable maintainers but in any case:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
