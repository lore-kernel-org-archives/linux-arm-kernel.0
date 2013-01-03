From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Thu, 3 Jan 2013 12:43:10 +0100 (CET)
Subject: =?UTF-8?q?=5BPATCH=20133/493=5D=20remove=20use=20of=20=5F=5Fdevexit=5Fp?=
In-Reply-To: <1353349642-3677-133-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-133-git-send-email-wfp5p@virginia.edu>
Message-ID: <Pine.LNX.4.64.1301031235370.17494@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bill

On Mon, 19 Nov 2012, Bill Pemberton wrote:

> CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
> needed.

Doesn't this also make the use of __refdata in many locations like this

[snip]

> diff --git a/drivers/media/platform/soc_camera/sh_mobile_csi2.c b/drivers/media/platform/soc_camera/sh_mobile_csi2.c
> index 0528650..0d0344a 100644
> --- a/drivers/media/platform/soc_camera/sh_mobile_csi2.c
> +++ b/drivers/media/platform/soc_camera/sh_mobile_csi2.c
> @@ -382,7 +382,7 @@ static __devexit int sh_csi2_remove(struct platform_device *pdev)
>  }
>  
>  static struct platform_driver __refdata sh_csi2_pdrv = {
> -	.remove	= __devexit_p(sh_csi2_remove),
> +	.remove	= sh_csi2_remove,
>  	.probe	= sh_csi2_probe,
>  	.driver	= {
>  		.name	= "sh-mobile-csi2",

superfluous? If so, I'm sure you'd be happy to make a couple more patches 
to continue this series ;-)

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
