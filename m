From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Feb 2016 12:37:57 +0100
Subject: [PATCH] rtc: mt6397: Add platform device ID table
In-Reply-To: <56C1E5C8.6040007@osg.samsung.com>
References: <1455016095-13724-1-git-send-email-javier@osg.samsung.com>
 <1455501497.7263.4.camel@mtksdaap41> <56C1E5C8.6040007@osg.samsung.com>
Message-ID: <2416670.q30ahHlzPm@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 15 February 2016 11:50:48 Javier Martinez Canillas wrote:
> 
> On 02/14/2016 10:58 PM, Eddie Huang wrote:
> 
> [snip]
> 
> >> @@ -412,6 +418,7 @@ static struct platform_driver mtk_rtc_driver = {
> >>      },
> >>      .probe  = mtk_rtc_probe,
> >>      .remove = mtk_rtc_remove,
> >> +    .id_table = mt6397_rtc_id,
> >>   };
> >>
> >>   module_platform_driver(mtk_rtc_driver);
> >> @@ -419,4 +426,3 @@ module_platform_driver(mtk_rtc_driver);
> >>   MODULE_LICENSE("GPL v2");
> >>   MODULE_AUTHOR("Tianping Fang <tianping.fang@mediatek.com>");
> >>   MODULE_DESCRIPTION("RTC Driver for MediaTek MT6397 PMIC");
> >> -MODULE_ALIAS("platform:mt6397-rtc");
> >
> > This patch looks good to me, but I am wondering, since we tend to use
> > device tree method to match driver, do we still need support platform
> > device ID ?
> >
> 
> I'm not familiar with neither this IP block nor the SoC so it is up to
> you. I just noticed this issue when reviewing a regulator driver for a
> similar PMIC posted by someone from mediatek.
> 
> I thought platform device was needed since the driver has a MODULE_ALIAS()
> but please let me know what you prefer and I can re-spin the patch and
> just remove the MODULE_ALIAS() if that makes more sense for this platform.
>   
> 

I agree. We can alway add a MODULE_DEVICE_TABLE() if we get multiple
users of this driver on architectures that don't use devicetree yet.

	Arnd
