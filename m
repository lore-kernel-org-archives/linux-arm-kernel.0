From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 15 Jun 2017 18:33:14 +0100
Subject: [PATCH 4/5] arm64: signal: factor out signal frame record
 allocation
In-Reply-To: <1497535442-11586-5-git-send-email-Dave.Martin@arm.com>
References: <1497535442-11586-1-git-send-email-Dave.Martin@arm.com>
 <1497535442-11586-5-git-send-email-Dave.Martin@arm.com>
Message-ID: <20170615173313.GD17424@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 15, 2017 at 03:03:41PM +0100, Dave P Martin wrote:
> This patch factors out the allocator for signal frame optional
> records into a separate function, to ensure consistency and
> facilitate later expansion.
> 
> No overrun checking is currently done, because the allocation is in
> user memory and anyway the kernel never tries to allocate enough
> space in the signal frame yet for an overrun to occur.  This
> behaviour will be refined in future patches.
> 
> The approach taken in this patch to allocation of the terminator
> record is not very clean: this will also be replaced in subsequent
> patches.
> 
> For future extension, a comment is added in sigcontext.h
> documenting the current static allocations in __reserved[].  This
> will be important for determining under what circumstances
> userspace may or may not see an expanded signal frame.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
