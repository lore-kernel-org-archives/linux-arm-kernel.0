From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Nov 2015 11:25:44 +0100
Subject: [PATCH 3/3] ASoC: samsung: pass filter function as pointer
In-Reply-To: <564A78A6.9010501@samsung.com>
References: <5466463.9HBcuLFGQf@wuerfel> <8896684.3di3I3vzeA@wuerfel>
 <564A78A6.9010501@samsung.com>
Message-ID: <22364793.tICMzOOh4L@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 November 2015 09:45:26 Krzysztof Kozlowski wrote:
> On 14.11.2015 02:24, Arnd Bergmann wrote:
> > diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
> > index 0945b5de39e7..5a4133b6e6a6 100644
> > --- a/sound/soc/samsung/i2s.c
> > +++ b/sound/soc/samsung/i2s.c
> > @@ -1244,7 +1244,8 @@ static int samsung_i2s_probe(struct platform_device *pdev)
> >  		if (ret != 0)
> >  			return ret;
> >  
> > -		return samsung_asoc_dma_platform_register(&pdev->dev);
> > +		return samsung_asoc_dma_platform_register(&pdev->dev,
> > +						  i2s_pdata->dma_filter);
> >  	}
> 
> Here (and maybe in other places?) - NULL pointer exception. The pdata is
> NULL on all newer platforms (e.g. all Exynos).
> 
> BTW, later there is even check for NULL pdata which is pointed also by
> Smatch.

Thanks for spotting this! I'll fix it up.

	Arnd
