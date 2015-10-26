From: laura@labbott.name (Laura Abbott)
Date: Mon, 26 Oct 2015 13:07:48 -0700
Subject: [PATCH] arm64/mm: use PAGE_ALIGNED instead of IS_ALIGNED
In-Reply-To: <1445858817-7056-1-git-send-email-kuleshovmail@gmail.com>
References: <1445858817-7056-1-git-send-email-kuleshovmail@gmail.com>
Message-ID: <562E8814.7080608@labbott.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/26/15 4:26 AM, Alexander Kuleshov wrote:
> The <linux/mm.h> already provides the PAGE_ALIGNED macro. Let's
> use this macro instead of IS_ALIGNED and passing PAGE_SIZE directly.
>
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>

Acked-by: Laura Abbott <laura@labbott.name>

> ---
>   arch/arm64/mm/pageattr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index e47ed1c..3571c73 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -45,7 +45,7 @@ static int change_memory_common(unsigned long addr, int numpages,
>   	int ret;
>   	struct page_change_data data;
>
> -	if (!IS_ALIGNED(addr, PAGE_SIZE)) {
> +	if (!PAGE_ALIGNED(addr)) {
>   		start &= PAGE_MASK;
>   		end = start + size;
>   		WARN_ON_ONCE(1);
>
