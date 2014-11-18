From: will.deacon@arm.com (Will Deacon)
Date: Tue, 18 Nov 2014 11:41:20 +0000
Subject: [PATCH] arm64/mm: Remove hack in mmap randomize layout
In-Reply-To: <1416265339-8138-1-git-send-email-ydroneaud@opteya.com>
References: <1416265339-8138-1-git-send-email-ydroneaud@opteya.com>
Message-ID: <20141118114120.GJ18842@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 17, 2014 at 11:02:19PM +0000, Yann Droneaud wrote:
> Since commit 8a0a9bd4db63 ('random: make get_random_int() more
> random'), get_random_int() returns a random value for each call,
> so comment and hack introduced in mmap_rnd() as part of commit
> 1d18c47c735e ('arm64: MMU fault handling and page table management')
> are incorrects.
> 
> Commit 1d18c47c735e seems to use the same hack introduced by
> commit a5adc91a4b44 ('powerpc: Ensure random space between stack
> and mmaps'), latter copied in commit 5a0efea09f42 ('sparc64: Sharpen
> address space randomization calculations.').
> 
> But both architectures were cleaned up as part of commit
> fa8cbaaf5a68 ('powerpc+sparc64/mm: Remove hack in mmap randomize
> layout') as hack is no more needed since commit 8a0a9bd4db63.
> 
> So the present patch removes the comment and the hack around
> get_random_int() on AArch64's mmap_rnd().
> 
> Cc: Dan McGee <dpmcgee@gmail.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Anton Blanchard <anton@samba.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Fixes: 1d18c47c735e ('arm64: MMU fault handling and page table management')
> Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
> ---
>  arch/arm64/mm/mmap.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)

Thanks, this looks sensible:

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
