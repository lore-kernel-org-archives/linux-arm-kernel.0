From: labbott@redhat.com (Laura Abbott)
Date: Mon, 5 Nov 2018 09:01:04 -0800
Subject: [PATCH] ARM: mm: dump: Change to use DEFINE_SHOW_ATTRIBUTE macro
In-Reply-To: <20181105143234.6015-1-tiny.windzz@gmail.com>
References: <20181105143234.6015-1-tiny.windzz@gmail.com>
Message-ID: <14239857-9885-caf1-ded3-044f30f48e2e@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/5/18 6:32 AM, Yangtao Li wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 

Acked-by: Laura Abbott <labbott@redhat.com>

> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>   arch/arm/mm/ptdump_debugfs.c | 12 +-----------
>   1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/arch/arm/mm/ptdump_debugfs.c b/arch/arm/mm/ptdump_debugfs.c
> index be8d87be4b93..201cd467a739 100644
> --- a/arch/arm/mm/ptdump_debugfs.c
> +++ b/arch/arm/mm/ptdump_debugfs.c
> @@ -12,17 +12,7 @@ static int ptdump_show(struct seq_file *m, void *v)
>   	return 0;
>   }
>   
> -static int ptdump_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, ptdump_show, inode->i_private);
> -}
> -
> -static const struct file_operations ptdump_fops = {
> -	.open		= ptdump_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(ptdump);
>   
>   int ptdump_debugfs_register(struct ptdump_info *info, const char *name)
>   {
> 
