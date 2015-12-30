From: jamesjj.liao@mediatek.com (James Liao)
Date: Wed, 30 Dec 2015 18:08:42 +0800
Subject: [PATCH 1/4] soc: mediatek: Separate scpsys driver common code
In-Reply-To: <2524123.scG8tD5NSM@wuerfel>
References: <1451457706-14798-1-git-send-email-jamesjj.liao@mediatek.com>
 <1451457706-14798-2-git-send-email-jamesjj.liao@mediatek.com>
 <2524123.scG8tD5NSM@wuerfel>
Message-ID: <1451470122.22426.1.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wed, 2015-12-30 at 09:52 +0100, Arnd Bergmann wrote:
> On Wednesday 30 December 2015 14:41:43 James Liao wrote:
> > diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> > index 0a4ea80..eca6fb7 100644
> > --- a/drivers/soc/mediatek/Kconfig
> > +++ b/drivers/soc/mediatek/Kconfig
> > @@ -22,11 +22,20 @@ config MTK_PMIC_WRAP
> >  
> >  config MTK_SCPSYS
> >         bool "MediaTek SCPSYS Support"
> > -       depends on ARCH_MEDIATEK || COMPILE_TEST
> > -       default ARM64 && ARCH_MEDIATEK
> >         select REGMAP
> >         select MTK_INFRACFG
> >         select PM_GENERIC_DOMAINS if PM
> >         help
> >           Say yes here to add support for the MediaTek SCPSYS power domain
> >           driver.
> > +
> > +config MTK_SCPSYS_MT8173
> > +       bool "MediaTek MT8173 SCPSYS Support"
> > +       depends on ARCH_MEDIATEK || COMPILE_TEST
> > +       select MTK_SCPSYS
> > +       default ARCH_MEDIATEK
> > 
> 
> Please don't "select" a user-visible Kconfig symbol. Either hide MTK_SCPSYS
> by removing the string behind 'bool', or make this "depends on MTK_SCPSYS".

It looks something wrong during cherry-pick. MTK_SCPSYS should be
invisible from user. I'll remove the string behind 'bool' in next patch.


Best regards,

James
