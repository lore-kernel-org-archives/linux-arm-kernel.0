From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 13 Nov 2014 17:02:17 +0000
Subject: [PATCH] ARM: mm: try to re-use old ASID assignments following a
 rollover
In-Reply-To: <1414688158-12741-1-git-send-email-will.deacon@arm.com>
References: <1414688158-12741-1-git-send-email-will.deacon@arm.com>
Message-ID: <20141113170216.GC22361@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 30, 2014 at 04:55:58PM +0000, Will Deacon wrote:
> Rather than unconditionally allocating a fresh ASID to an mm from an
> older generation, attempt to re-use the old assignment where possible.
> 
> This can bring performance benefits on systems where the ASID is used to
> tag things other than the TLB (e.g. branch prediction resources).
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Just curious, have you seen any improvements with this patch?

Anyway, it makes sense. Unless you sent it already to Russell:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
