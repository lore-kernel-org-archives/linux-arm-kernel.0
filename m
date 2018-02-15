From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 15 Feb 2018 18:59:55 +0000
Subject: [PATCH] arm64: mm: Use READ_ONCE/WRITE_ONCE when accessing page
 tables
In-Reply-To: <1518693296-7339-1-git-send-email-will.deacon@arm.com>
References: <1518693296-7339-1-git-send-email-will.deacon@arm.com>
Message-ID: <01defb0c-5cb5-83b3-8094-04fcc24ab75a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/02/18 11:14, Will Deacon wrote:
> In many cases, page tables can be accessed concurrently by either another
> CPU (due to things like fast gup) or by the hardware page table walker
> itself, which may set access/dirty bits. In such cases, it is important
> to use READ_ONCE/WRITE_ONCE when accessing page table entries so that
> entries cannot be torn, merged or subject to apparent loss of coherence
> due to compiler transformations.
> 
> Whilst there are some scenarios where this cannot happen (e.g. pinned
> kernel mappings for the linear region), the overhead of using READ_ONCE
> /WRITE_ONCE everywhere is minimal and makes the code an awful lot easier
> to reason about. This patch consistently uses these macros in the arch
> code, as well as explicitly namespacing pointers to page table entries
> from the entries themselves by using adopting a 'p' suffix for the former
> (as is sometimes used elsewhere in the kernel source).
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Tested-by: Yury Norov <ynorov@caviumnetworks.com>
> Tested-by: Richard Ruigrok <rruigrok@codeaurora.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
