From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 9 May 2014 11:39:37 +0100
Subject: [PATCH] arm64: Make atomic64_t() return "long", not "long long"
In-Reply-To: <20140508211347.18358.8154.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140508211347.18358.8154.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <20140509103937.GC7950@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 08, 2014 at 10:13:47PM +0100, Bjorn Helgaas wrote:
> arm64 sets CONFIG_64BIT=y and hence uses the "long counter" atomic64_t
> definition from include/linux/types.h.  Make atomic64_read() return "long",
> not "long long".
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/arm64/include/asm/atomic.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/atomic.h b/arch/arm64/include/asm/atomic.h
> index 0237f0867e37..9c48d74652cb 100644
> --- a/arch/arm64/include/asm/atomic.h
> +++ b/arch/arm64/include/asm/atomic.h
> @@ -162,7 +162,7 @@ static inline int __atomic_add_unless(atomic_t *v, int a, int u)
>   */
>  #define ATOMIC64_INIT(i) { (i) }
>  
> -#define atomic64_read(v)	(*(volatile long long *)&(v)->counter)
> +#define atomic64_read(v)	(*(volatile long *)&(v)->counter)
>  #define atomic64_set(v,i)	(((v)->counter) = (i))

Applied, thanks.

-- 
Catalin
