From: gang.chen@asianux.com (Chen Gang)
Date: Mon, 20 May 2013 15:15:08 +0800
Subject: [PATCH] arm64: kernel: compiling issue,
 need 'EXPORT_SYMBOL(clear_page)'
In-Reply-To: <5199CCF9.4030305@asianux.com>
References: <5199CCF9.4030305@asianux.com>
Message-ID: <5199CD7C.4080304@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


After this patch, can pass building arm64 with allmodconfig under
next-20130517 tree. :-)

On 05/20/2013 03:12 PM, Chen Gang wrote:
> 
> Need 'EXPORT_SYMBOL(clear_page)' if building with allmodconfig.
> 
> The related errors:
>   ERROR: "clear_page" [fs/ocfs2/dlm/ocfs2_dlm.ko] undefined!
>   ERROR: "clear_page" [fs/ntfs/ntfs.ko] undefined!
>   ERROR: "clear_page" [fs/gfs2/gfs2.ko] undefined!
>   ERROR: "clear_page" [fs/fuse/fuse.ko] undefined!
>   ERROR: "clear_page" [fs/ext3/ext3.ko] undefined!
>   ERROR: "clear_page" [fs/ext2/ext2.ko] undefined!
>   ERROR: "clear_page" [fs/exofs/libore.ko] undefined!
>   ERROR: "clear_page" [fs/exofs/exofs.ko] undefined!
>   ERROR: "clear_page" [drivers/block/brd.ko] undefined!
> 
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/arm64/kernel/arm64ksyms.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm64/kernel/arm64ksyms.c b/arch/arm64/kernel/arm64ksyms.c
> index 7df1aad..41b4f62 100644
> --- a/arch/arm64/kernel/arm64ksyms.c
> +++ b/arch/arm64/kernel/arm64ksyms.c
> @@ -34,6 +34,7 @@ EXPORT_SYMBOL(__strnlen_user);
>  EXPORT_SYMBOL(__strncpy_from_user);
>  
>  EXPORT_SYMBOL(copy_page);
> +EXPORT_SYMBOL(clear_page);
>  
>  EXPORT_SYMBOL(__copy_from_user);
>  EXPORT_SYMBOL(__copy_to_user);
> 


-- 
Chen Gang

Asianux Corporation
