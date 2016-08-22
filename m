From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 22 Aug 2016 11:21:27 +0100
Subject: [RFC PATCH v2 2/2] arm64 Kconfig: Select gigantic page
In-Reply-To: <1471834603-27053-3-git-send-email-xieyisheng1@huawei.com>
References: <1471834603-27053-1-git-send-email-xieyisheng1@huawei.com>
 <1471834603-27053-3-git-send-email-xieyisheng1@huawei.com>
Message-ID: <20160822102127.GB26494@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2016 at 10:56:43AM +0800, Xie Yisheng wrote:
> Arm64 supports gigantic page after
> commit 084bd29810a5 ("ARM64: mm: HugeTLB support.")
> however, it got broken by 
> commit 944d9fec8d7a ("hugetlb: add support for gigantic page
> allocation at runtime")
> 
> This patch selects ARCH_HAS_GIGANTIC_PAGE to make this
> function can be used again.
> 
> Signed-off-by: Xie Yisheng <xieyisheng1@huawei.com>
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

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
