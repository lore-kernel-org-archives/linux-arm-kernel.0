From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 24 Feb 2016 17:56:57 +0100
Subject: [PATCH] rtc: mt6397: Add platform device ID table
In-Reply-To: <1455628747.2981.4.camel@mtksdaap41>
References: <1455016095-13724-1-git-send-email-javier@osg.samsung.com>
 <2416670.q30ahHlzPm@wuerfel> <1455628747.2981.4.camel@mtksdaap41>
Message-ID: <3216713.qF8RyQVuPO@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 February 2016 21:19:07 Eddie Huang wrote:
> On Tue, 2016-02-16 at 12:37 +0100, Arnd Bergmann wrote:
> > On Monday 15 February 2016 11:50:48 Javier Martinez Canillas wrote:
> > > 
> > > On 02/14/2016 10:58 PM, Eddie Huang wrote:
> > > 
> > > [snip]
> > > 
> > > >> @@ -412,6 +418,7 @@ static struct platform_driver mtk_rtc_driver = {
> > > >>      },
> > > >>      .probe  = mtk_rtc_probe,
> > > >>      .remove = mtk_rtc_remove,
> > > >> +    .id_table = mt6397_rtc_id,
> > > >>   };
> > > >>
> > > >>   module_platform_driver(mtk_rtc_driver);
> > > >> @@ -419,4 +426,3 @@ module_platform_driver(mtk_rtc_driver);
> > > >>   MODULE_LICENSE("GPL v2");
> > > >>   MODULE_AUTHOR("Tianping Fang <tianping.fang@mediatek.com>");
> > > >>   MODULE_DESCRIPTION("RTC Driver for MediaTek MT6397 PMIC");
> > > >> -MODULE_ALIAS("platform:mt6397-rtc");
> > > >
> > > > This patch looks good to me, but I am wondering, since we tend to use
> > > > device tree method to match driver, do we still need support platform
> > > > device ID ?
> > > >
> > > 
> > > I'm not familiar with neither this IP block nor the SoC so it is up to
> > > you. I just noticed this issue when reviewing a regulator driver for a
> > > similar PMIC posted by someone from mediatek.
> > > 
> > > I thought platform device was needed since the driver has a MODULE_ALIAS()
> > > but please let me know what you prefer and I can re-spin the patch and
> > > just remove the MODULE_ALIAS() if that makes more sense for this platform.
> > >   
> > > 
> > 
> > I agree. We can alway add a MODULE_DEVICE_TABLE() if we get multiple
> > users of this driver on architectures that don't use devicetree yet.
> > 
> 
> Sure. Thanks the patch to add expandability to this driver.
> 
> Acked-by: Eddie Huang <eddie.huang@mediatek.com>

I think we misunderstood one another. I think we can drop both the MODULE_DEVICE_TABLE and the MODULE_ALIAS: there is no need for another
driver ID when it is always probed using DT.

	Arnd
