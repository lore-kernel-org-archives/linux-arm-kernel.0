From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 28 Dec 2017 08:55:47 +0100
Subject: [PATCH] ARM: pxa3xx: fix static checker warning in ulpi
In-Reply-To: <20171226123351.5384-1-grinberg@compulab.co.il> (Igor Grinberg's
 message of "Tue, 26 Dec 2017 14:33:51 +0200")
References: <20171226123351.5384-1-grinberg@compulab.co.il>
Message-ID: <874lob8ews.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Igor Grinberg <grinberg@compulab.co.il> writes:

> Static checker reports the following warning:
>
> arch/arm/mach-pxa/pxa3xx-ulpi.c:336 pxa3xx_u2d_probe()
> warn: did you mean to pass the address of 'u2d'
>
> Fix it by passing the correct pointer.
>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> ---
>  arch/arm/mach-pxa/pxa3xx-ulpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-pxa/pxa3xx-ulpi.c b/arch/arm/mach-pxa/pxa3xx-ulpi.c
> index 60cb59a7ebd1..c00450764352 100644
> --- a/arch/arm/mach-pxa/pxa3xx-ulpi.c
> +++ b/arch/arm/mach-pxa/pxa3xx-ulpi.c
> @@ -331,7 +331,7 @@ static int pxa3xx_u2d_probe(struct platform_device *pdev)
>  			goto err_free_plat;
>  	}
>  
> -	platform_set_drvdata(pdev, &u2d);
> +	platform_set_drvdata(pdev, u2d);
Applied to pxa/for-next, thanks.

Cheers.

-- 
Robert
