From: dyoung@redhat.com (Dave Young)
Date: Mon, 12 Mar 2018 11:18:55 +0800
Subject: [PATCH v2 0/7] kexec_file, x86, powerpc: refactoring for other
 architecutres
In-Reply-To: <20180309093346.GF25863@linaro.org>
References: <20180306102303.9063-1-takahiro.akashi@linaro.org>
 <20180308010502.GA2600@dhcp-128-65.nay.redhat.com>
 <20180309060254.GA9728@dhcp-128-65.nay.redhat.com>
 <20180309064412.GA5327@dhcp-128-65.nay.redhat.com>
 <20180309071813.GE25863@linaro.org>
 <20180309074613.GA6331@dhcp-128-65.nay.redhat.com>
 <20180309075547.GA6718@dhcp-128-65.nay.redhat.com>
 <20180309093346.GF25863@linaro.org>
Message-ID: <20180312031855.GA2136@dhcp-128-65.nay.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/09/18 at 06:33pm, AKASHI Takahiro wrote:

[snip]

> Oops, please apply the fix below to my first patch ("kexec_file: make
> an use of purgatory optional"). My screw-up is trivial here :)

Wow, human eyes sometimes can not catch such issue, thanks for the fix.
It works for me.

> 
> Please let me know if you think that I should repost my patch set.
> 

Because akpm takes kexec patches,  this question should be passing to
Andrew.  Andrew, do you need a repost?

> Thanks,
> -Takahiro AKASHI
> 
> ===8<===
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 6dbbb89cbbac..ab1dced677fd 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -532,7 +532,7 @@ static int kexec_calculate_store_digests(struct kimage *image)
>  	struct kexec_sha_region *sha_regions;
>  	struct purgatory_info *pi = &image->purgatory_info;
>  
> -	if (!IS_ENABLED(ARCH_HAS_KEXEC_PURGATORY))
> +	if (!IS_ENABLED(CONFIG_ARCH_HAS_KEXEC_PURGATORY))
>  		return 0;
>  
>  	zero_buf = __va(page_to_pfn(ZERO_PAGE(0)) << PAGE_SHIFT);
> ===>8===
> 

Thanks
Dave
