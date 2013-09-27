From: cxie4@marvell.com (Chao Xie)
Date: Thu, 26 Sep 2013 19:15:23 -0700
Subject: [PATCH RESEND] ARM: pxa: ssp: remove kfree for memory allocated
 with devm_kzalloc
In-Reply-To: <52415363.5020009@gmail.com>
References: <CAPgLHd9T5_auqA_4Ev_Qh6f_vZONqc8z6AcJVuV1S0VkFn4S_Q@mail.gmail.com>
 <52415363.5020009@gmail.com>
Message-ID: <AAD1C6EB06EE3649B35B7E026785068D275FE72362@SC-VEXCH2.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Daniel Mack [mailto:zonque at gmail.com] 
> Sent: Tuesday, September 24, 2013 4:55 PM
> To: Wei Yongjun
> Cc: linux at arm.linux.org.uk; grant.likely at linaro.org; rob.herring at calxeda.com; broonie at sirena.org.uk; haojian.zhuang at gmail.com; olof at lixom.net; gregkh at linuxfoundation.org; yongjun_wei at trendmicro.com.cn; linux-arm-kernel at lists.infradead.org; Chao Xie
> Subject: Re: [PATCH RESEND] ARM: pxa: ssp: remove kfree for memory allocated with devm_kzalloc
> 
> On 24.09.2013 05:35, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> It's not necessary to free memory allocated with devm_kzalloc
> and using kfree leads to a double free.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Acked-by: Daniel Mack <zonque@gmail.com>
> 
> Chao Xie wanted to work on getting rid of the "middle layer" the pxa ssp
> driver has. If that's going to happen for 3.13, it will again affect
> both the ASoC part and code in arch/arm. Therefore, I would again prefer
> if ssp patches went through Mark's ASoC tree. Chao, are you still
> planning to work on this?
> 
For last month I had to work at other project.
I will continue to work at it at early Oct.
> 
> 
> Daniel
> 
> 
> ---
>  arch/arm/plat-pxa/ssp.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
> index 3ea0290..528143e 100644
> --- a/arch/arm/plat-pxa/ssp.c
> +++ b/arch/arm/plat-pxa/ssp.c
> @@ -250,7 +250,6 @@ static int pxa_ssp_remove(struct platform_device *pdev)
>  	list_del(&ssp->node);
>  	mutex_unlock(&ssp_lock);
>  
> -	kfree(ssp);
>  	return 0;
>  }
>  
> 
