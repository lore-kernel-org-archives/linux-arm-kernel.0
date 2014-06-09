From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 9 Jun 2014 10:27:26 +0100
Subject: [PATCHv2] arm64: Add atomic pool for non-coherent and CMA
 allocaitons.
In-Reply-To: <539262FA.8010301@codeaurora.org>
References: <1401739432-5358-1-git-send-email-lauraa@codeaurora.org>
 <20140605170500.GC27946@arm.com> <539262FA.8010301@codeaurora.org>
Message-ID: <20140609092725.GB25590@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 07, 2014 at 01:55:22AM +0100, Laura Abbott wrote:
> On 6/5/2014 10:05 AM, Catalin Marinas wrote:
> > On Mon, Jun 02, 2014 at 09:03:52PM +0100, Laura Abbott wrote:
> >> Neither CMA nor noncoherent allocations support atomic allocations.
> >> Add a dedicated atomic pool to support this.
> > 
> > CMA indeed doesn't support atomic allocations but swiotlb does, the only
> > problem being the vmap() to create a non-cacheable mapping. Could we not
> > use the atomic pool only for non-coherent allocations?
> 
> CMA needs the atomic pool for both non-coherent and coherent allocations.
> Perhaps I should update the code so we only create the coherent atomic
> pool if CMA is used.

It's also needed with non-coherent swiotlb because of vmap (but coherent
is fine).

-- 
Catalin
