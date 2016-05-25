From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 25 May 2016 09:48:32 +0300
Subject: [PATCH] pinctrl: digicolor: add missing platform_set_drvdata()
 call
In-Reply-To: <1464155932-25344-1-git-send-email-yamada.masahiro@socionext.com>
References: <1464155932-25344-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20160525064832.GG2178@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Masahiro Yamada,

On Wed, May 25, 2016 at 02:58:52PM +0900, Masahiro Yamada wrote:
> gc_pinctrl_remove() calls platform_get_drvdata(), but I see neither
> platform_set_drvdata() nor dev_set_drvdata() anywhere in this driver.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Baruch Siach <baruch@tkos.co.il>

Thanks,
baruch

>  drivers/pinctrl/pinctrl-digicolor.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pinctrl/pinctrl-digicolor.c b/drivers/pinctrl/pinctrl-digicolor.c
> index 30ee564..c8073d4 100644
> --- a/drivers/pinctrl/pinctrl-digicolor.c
> +++ b/drivers/pinctrl/pinctrl-digicolor.c
> @@ -332,6 +332,8 @@ static int dc_pinctrl_probe(struct platform_device *pdev)
>  		return PTR_ERR(pmap->pctl);
>  	}
>  
> +	platform_set_drvdata(pdev, pmap);
> +
>  	return dc_gpiochip_add(pmap, pdev->dev.of_node);
>  }

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
