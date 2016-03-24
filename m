From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 24 Mar 2016 16:33:10 +0000
Subject: [PATCH] arm64: consistently use p?d_set_huge
In-Reply-To: <1458641505-21499-1-git-send-email-mark.rutland@arm.com>
References: <1458641505-21499-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20160324163310.GF9113@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 22, 2016 at 10:11:45AM +0000, Mark Rutland wrote:
> Commit 324420bf91f60582 ("arm64: add support for ioremap() block
> mappings") added new p?d_set_huge functions which do the hard work to
> generate and set a correct block entry.
> 
> These differ from open-coded huge page creation in the early page table
> code by explicitly setting the P?D_TYPE_SECT bits (which are implicitly
> retained by mv_sect_prot() for any valid prot), but are otherwise
> identical (and cannot fail on arm64).
> 
> For simplicity and consistency, make use of these in the initial page
> table creation code.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Applied. Thanks.

-- 
Catalin
