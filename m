From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 15 Aug 2016 10:13:59 +0100
Subject: [PATCH v4 1/3] arm64: vdso: add __init section marker to
 alloc_vectors_page
In-Reply-To: <1471243546-3090-2-git-send-email-jszhang@marvell.com>
References: <1471243546-3090-1-git-send-email-jszhang@marvell.com>
 <1471243546-3090-2-git-send-email-jszhang@marvell.com>
Message-ID: <20160815091359.GB1426@svinekod>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 15, 2016 at 02:45:44PM +0800, Jisheng Zhang wrote:
> It is not needed after booting, this patch moves the alloc_vectors_page
> function to the __init section.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark

> ---
>  arch/arm64/kernel/vdso.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> index 076312b..e320e8f 100644
> --- a/arch/arm64/kernel/vdso.c
> +++ b/arch/arm64/kernel/vdso.c
> @@ -55,7 +55,7 @@ struct vdso_data *vdso_data = &vdso_data_store.data;
>   */
>  static struct page *vectors_page[1];
>  
> -static int alloc_vectors_page(void)
> +static int __init alloc_vectors_page(void)
>  {
>  	extern char __kuser_helper_start[], __kuser_helper_end[];
>  	extern char __aarch32_sigret_code_start[], __aarch32_sigret_code_end[];
> -- 
> 2.8.1
> 
