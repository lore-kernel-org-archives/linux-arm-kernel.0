From: paulliu@debian.org (Ying-Chun Liu (PaulLiu))
Date: Tue, 17 Jul 2012 09:12:31 +0800
Subject: [PATCH] mfd: anatop: matches should be NULL when populate child
 devices
In-Reply-To: <1342428957-14321-1-git-send-email-richard.zhao@freescale.com>
References: <1342428957-14321-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <5004BBFF.4040101@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012?07?16? 16:55, Richard Zhao wrote:
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> ---
>  drivers/mfd/anatop-mfd.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/anatop-mfd.c b/drivers/mfd/anatop-mfd.c
> index 6da0634..5576e07 100644
> --- a/drivers/mfd/anatop-mfd.c
> +++ b/drivers/mfd/anatop-mfd.c
> @@ -83,7 +83,7 @@ static int __devinit of_anatop_probe(struct platform_device *pdev)
>  	drvdata->ioreg = ioreg;
>  	spin_lock_init(&drvdata->reglock);
>  	platform_set_drvdata(pdev, drvdata);
> -	of_platform_populate(np, of_anatop_match, NULL, dev);
> +	of_platform_populate(np, NULL, NULL, dev);
>  
>  	return 0;
>  }

Thanks.

Reviewed-by: Ying-Chun Liu (PaulLiu) <paulliu@debian.org>

-- 
                                PaulLiu (???)
E-mail: Ying-Chun Liu (PaulLiu) <paulliu@debian.org>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 900 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120717/e7798862/attachment.sig>
