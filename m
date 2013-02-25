From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 25 Feb 2013 16:31:28 +0000
Subject: [PATCH 1/2] ARM: tlb: add branch predictor maintenance operations
In-Reply-To: <1361805688-8886-1-git-send-email-will.deacon@arm.com>
References: <1361805688-8886-1-git-send-email-will.deacon@arm.com>
Message-ID: <20130225163128.GD612@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 25, 2013 at 03:21:27PM +0000, Will Deacon wrote:
> The ARM architecture requires explicit branch predictor maintenance
> when updating an instruction stream for a given virtual address. In
> reality, this isn't so much of a burden because the branch predictor
> is flushed during the cache maintenance required to make the new
> instructions visible to the I-side of the processor.
> 
> However, there are still some cases where explicit flushing is required,
> so add a local_bp_flush_all operation to deal with this.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
