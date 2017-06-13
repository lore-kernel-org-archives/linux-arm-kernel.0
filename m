From: tanxiaojun@huawei.com (Tan Xiaojun)
Date: Tue, 13 Jun 2017 10:00:01 +0800
Subject: [PATCH 0/2] arm64: fix crash when reading /proc/kcore
In-Reply-To: <20170608194139.9250-1-ard.biesheuvel@linaro.org>
References: <20170608194139.9250-1-ard.biesheuvel@linaro.org>
Message-ID: <593F4721.7000501@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/6/9 3:41, Ard Biesheuvel wrote:
> This is a follow-up to patches from zhonjiang [0] and myself [1] that aim
> to solve a problem in the kcore code, which gets confused by the presence
> of block mappings in the vmalloc region.
> 
> While fixing the crash is quite straight forward [2], we need to tweak
> the kcore code itself to ensure that it operates correctly on arm64.
> Fortunately, we can achieve this with two very simple changes:
> 
> - replace a call to is_vmalloc_or_module_addr() in read_kcore() with a
>   comparison of the kclist type field (#1)
> - enable CONFIG_ARCH_PROC_KCORE_TEXT for arm64 (#2)
> 
> [0] http://marc.info/?l=linux-mm&m=149632393629295&w=2
> [1] http://marc.info/?l=linux-mm&m=149685966530180&w=2
> [2] http://marc.info/?l=linux-mm&m=149694975123959&w=2
> 
> Ard Biesheuvel (2):
>   fs/proc: kcore: use kcore_list type to check for vmalloc/module
>     address
>   arm64: mm: select CONFIG_ARCH_PROC_KCORE_TEXT
> 
>  arch/arm64/Kconfig | 3 +++
>  fs/proc/kcore.c    | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 

Reported-by: Tan Xiaojun <tanxiaojun@huawei.com>
Tested-by: Tan Xiaojun <tanxiaojun@huawei.com>

Thank you for working on this problem which I reported two months ago.

https://patchwork.kernel.org/patch/9687319/

I tested, and it really solved the problem in Hisilicon D02/D03/D05.

Thanks.
Xiaojun.
