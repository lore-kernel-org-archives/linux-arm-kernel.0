From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 2 Jul 2014 07:50:53 +0100
Subject: [PATCH 1/1] drivers/mfd/ab8500-debugfs.c: remove unnecessary
 null test before debugfs_remove_recursive
In-Reply-To: <1403956697-3197-1-git-send-email-fabf@skynet.be>
References: <1403956697-3197-1-git-send-email-fabf@skynet.be>
Message-ID: <20140702065053.GA10311@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 28 Jun 2014, Fabian Frederick wrote:

> Fix checkpatch warning:
> WARNING: debugfs_remove_recursive(NULL) is safe this check is probably not required
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> ---
>  drivers/mfd/ab8500-debugfs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.

> diff --git a/drivers/mfd/ab8500-debugfs.c b/drivers/mfd/ab8500-debugfs.c
> index d1a22aa..7ca8713 100644
> --- a/drivers/mfd/ab8500-debugfs.c
> +++ b/drivers/mfd/ab8500-debugfs.c
> @@ -3192,8 +3192,7 @@ static int ab8500_debug_probe(struct platform_device *plf)
>  	return 0;
>  
>  err:
> -	if (ab8500_dir)
> -		debugfs_remove_recursive(ab8500_dir);
> +	debugfs_remove_recursive(ab8500_dir);
>  	dev_err(&plf->dev, "failed to create debugfs entries.\n");
>  
>  	return -ENOMEM;

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
