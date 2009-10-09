From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Fri, 09 Oct 2009 16:14:52 +0400
Subject: [PATCH] irda/sa1100_ir: check return value of startup hook
In-Reply-To: <1255073153-24962-1-git-send-email-mad_soft@inbox.ru>
References: <1255073153-24962-1-git-send-email-mad_soft@inbox.ru>
Message-ID: <4ACF293C.7070803@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Dmitry Artamonow wrote:

> Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
[...]
> diff --git a/drivers/net/irda/sa1100_ir.c b/drivers/net/irda/sa1100_ir.c
> index 38bf7cf..df5db2d 100644
> --- a/drivers/net/irda/sa1100_ir.c
> +++ b/drivers/net/irda/sa1100_ir.c
> @@ -232,8 +232,11 @@ static int sa1100_irda_startup(struct sa1100_irda *si)
>  	/*
>  	 * Ensure that the ports for this device are setup correctly.
>  	 */
> -	if (si->pdata->startup)
> -		si->pdata->startup(si->dev);
> +	if (si->pdata->startup)	{
> +		ret = si->pdata->startup(si->dev);
> +		if (ret)
> +			return ret;
> +		}

    Overindented brace.

>  
>  	/*
>  	 * Configure PPC for IRDA - we want to drive TXD2 low.

WBR, Sergei
