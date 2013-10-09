From: will.deacon@arm.com (Will Deacon)
Date: Wed, 9 Oct 2013 11:48:59 +0100
Subject: [PATCH v2 2/2] ARM: include: asm: use 'int' instead of 'unsigned
 long' for 'oldval' in atomic_cmpxchg().
In-Reply-To: <5253E583.5020805@asianux.com>
References: <524E8FBC.2080200@asianux.com>
 <20131004153742.GR24303@mudshark.cambridge.arm.com>
 <20131004154208.GS24303@mudshark.cambridge.arm.com>
 <524F5566.4010204@asianux.com> <524F594B.1070106@asianux.com>
 <525385A4.5050200@asianux.com>
 <20131008103455.GF17148@mudshark.cambridge.arm.com>
 <5253E4F3.4090205@asianux.com> <5253E533.4070803@asianux.com>
 <5253E583.5020805@asianux.com>
Message-ID: <20131009104858.GB6564@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 08, 2013 at 11:59:15AM +0100, Chen Gang wrote:
> For atomic_cmpxchg(), the type of 'oldval' need be 'int' to match the
> type of "*ptr" (used by 'ldrex' instruction) and 'old' (used by 'teq'
> instruction).
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/arm/include/asm/atomic.h |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
> index a715ac0..9ee7e01 100644
> --- a/arch/arm/include/asm/atomic.h
> +++ b/arch/arm/include/asm/atomic.h
> @@ -114,7 +114,8 @@ static inline int atomic_sub_return(int i, atomic_t *v)
>  
>  static inline int atomic_cmpxchg(atomic_t *ptr, int old, int new)
>  {
> -	unsigned long oldval, res;
> +	int oldval;
> +	unsigned long res;
>  
>  	smp_mb();

As discussed, this is completely cosmetic, but does at least keep the file
consistent.

  Reviewed-by: Will Deacon <will.deacon@arm.com>

Will
