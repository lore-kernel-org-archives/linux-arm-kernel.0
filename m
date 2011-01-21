From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 21 Jan 2011 19:07:07 +0100
Subject: [PATCH] video: pxa168fb: remove a redundant pxa168fb_check_var
	call
In-Reply-To: <1295608686.3976.9.camel@phoenix>
References: <1295608686.3976.9.camel@phoenix>
Message-ID: <201101211907.07386.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 January 2011 12:18:06 Axel Lin wrote:
> Current implementation calls pxa168fb_check_var twice in pxa168fb_probe.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  drivers/video/pxa168fb.c |    6 +-----
>  1 files changed, 1 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/video/pxa168fb.c b/drivers/video/pxa168fb.c
> index cea6403..35f61dd 100644
> --- a/drivers/video/pxa168fb.c
> +++ b/drivers/video/pxa168fb.c
> @@ -701,16 +701,12 @@ static int __devinit pxa168fb_probe(struct
> platform_device *pdev) */
>  	pxa168fb_init_mode(info, mi);
> 
> -	ret = pxa168fb_check_var(&info->var, info);
> -	if (ret)
> -		goto failed_free_fbmem;
> -
>  	/*
>  	 * Fill in sane defaults.
>  	 */
>  	ret = pxa168fb_check_var(&info->var, info);
>  	if (ret)
> -		goto failed;
> +		goto failed_free_fbmem;
> 
>  	/*
>  	 * enable controller clock

Please, don't use the get_maintainers script. This CCs too many people, really. 
As for pxa168, only CC linux-arm-kernel, Eric, Haojian and that's about it 
(fixed). Thanks

I can't comment on the code, though Haojian, is there any particular reason why 
the call's twice in there? Maybe some HW quirk or something?

Cheers
