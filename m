From: will.deacon@arm.com (Will Deacon)
Date: Mon, 27 Jun 2016 17:24:23 +0100
Subject: [PATCH] arm64: mm: simplify memblock numa node extraction
In-Reply-To: <1466594025-27682-1-git-send-email-mark.rutland@arm.com>
References: <1466594025-27682-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20160627162423.GB22894@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2016 at 12:13:45PM +0100, Mark Rutland wrote:
> We currently open-code extracting the NUMA node of a memblock region,
> which requires an ifdef to cater for !CONFIG_NUMA builds where the
> memblock_region::nid field does not exist.
> 
> The generic memblock_get_region_node helper is intended to cater for
> this. For CONFIG_HAVE_MEMBLOCK_NODE_MAP, builds this returns reg->nid,
> and for for !CONFIG_HAVE_MEMBLOCK_NODE_MAP builds this is a static
> inline that returns 0. Note that for arm64,
> CONFIG_HAVE_MEMBLOCK_NODE_MAP is selected iff CONFIG_NUMA is.
> 
> This patch makes use of memblock_get_region_node to simplify the arm64
> code. At the same time, we can move the nid variable definition into the
> loop, as this is the only place it is used.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Steve Capper <steve.capper@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/mm/init.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Looks like a straightforward cleanup to me:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
