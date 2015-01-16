From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 16 Jan 2015 16:23:35 +0000
Subject: [PATCH] arm64/efi: handle potential failure to remap memory map
In-Reply-To: <20150115164010.GK16217@leverpostej>
References: <1421323266-30973-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150115164010.GK16217@leverpostej>
Message-ID: <20150116162334.GJ13634@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 15, 2015 at 04:40:11PM +0000, Mark Rutland wrote:
> On Thu, Jan 15, 2015 at 12:01:06PM +0000, Ard Biesheuvel wrote:
> > When remapping the UEFI memory map using ioremap_cache(), we
> > have to deal with potential failure. Note that, even if the
> > common case is for ioremap_cache() to return the existing linear
> > mapping of the memory map, we cannot rely on that to be always the
> > case, e.g., in the presence of a mem= kernel parameter.
> > 
> > At the same time, remove a stale comment and move the memmap code
> > together.
> > 
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> This should probably be picked up before my mem= patch, which I will be
> resending shortly. I'll mention that when posting.
> 
> I guess Catalin should pick this up given the other portions are in the
> arm64 tree, and this falls under arch/arm64.

I picked both up. Thanks.

-- 
Catalin
