From: mhocko@kernel.org (Michal Hocko)
Date: Mon, 22 Aug 2016 10:03:58 +0200
Subject: [RFC PATCH v2 2/2] arm64 Kconfig: Select gigantic page
In-Reply-To: <1471834603-27053-3-git-send-email-xieyisheng1@huawei.com>
References: <1471834603-27053-1-git-send-email-xieyisheng1@huawei.com>
 <1471834603-27053-3-git-send-email-xieyisheng1@huawei.com>
Message-ID: <20160822080358.GF13596@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 22-08-16 10:56:43, Xie Yisheng wrote:
> Arm64 supports gigantic page after
> commit 084bd29810a5 ("ARM64: mm: HugeTLB support.")
> however, it got broken by 
> commit 944d9fec8d7a ("hugetlb: add support for gigantic page
> allocation at runtime")
> 
> This patch selects ARCH_HAS_GIGANTIC_PAGE to make this
> function can be used again.

I haven't double checked that the above commit really broke it but if
that is the case then
 
Fixes: 944d9fec8d7a ("hugetlb: add support for gigantic page allocation at runtime")

would be nice as well I guess. I do not think that marking it for stable
is really necessary considering how long it's been broken and nobody has
noticed...

> Signed-off-by: Xie Yisheng <xieyisheng1@huawei.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  arch/arm64/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index bc3f00f..92217f6 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -9,6 +9,7 @@ config ARM64
>  	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>  	select ARCH_HAS_ELF_RANDOMIZE
>  	select ARCH_HAS_GCOV_PROFILE_ALL
> +	select ARCH_HAS_GIGANTIC_PAGE
>  	select ARCH_HAS_KCOV
>  	select ARCH_HAS_SG_CHAIN
>  	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
> -- 
> 1.7.12.4
> 

-- 
Michal Hocko
SUSE Labs
