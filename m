From: sean.wang@mediatek.com (Sean Wang)
Date: Tue, 26 Sep 2017 15:24:56 +0800
Subject: [PATCH] soc: mediatek: place Kconfig for all SoC driver under menu
In-Reply-To: <20170926075558.7e4c99c3@endymion>
References: <b7aeda2773ebd2f030ddd782b31a594a05fdef2c.1505982942.git.sean.wang@mediatek.com>
 <20170926075558.7e4c99c3@endymion>
Message-ID: <1506410696.21515.17.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-09-26 at 07:55 +0200, Jean Delvare wrote:
> On Thu, 21 Sep 2017 16:46:35 +0800, sean.wang at mediatek.com wrote:
> > From: Sean Wang <sean.wang@mediatek.com>
> > 
> > Add cleanup for placing all Kconfig for all MediaTek SoC drivers under
> > the independent menu as other SoCs vendor usually did.
> > 
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > ---
> >  drivers/soc/mediatek/Kconfig | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> > index 609bb34..a2fcd7f 100644
> > --- a/drivers/soc/mediatek/Kconfig
> > +++ b/drivers/soc/mediatek/Kconfig
> > @@ -1,6 +1,8 @@
> >  #
> >  # MediaTek SoC drivers
> >  #
> > +menu "MediaTek SoC drivers"
> 
> Could it depend on ARCH_MEDIATEK || COMPILE_TEST? So that it isn't
> presented if it is going to be empty.
> 

Okay, I'll add a dependency for the menu. And all "depends on
ARCH_MEDIATEK" for items insides the menu can also be removed.

such as

 menu "MediaTek SoC drivers"
+       depends on ARCH_MEDIATEK || COMPILE_TEST

 config MTK_INFRACFG
        bool "MediaTek INFRACFG Support"
-       depends on ARCH_MEDIATEK || COMPILE_TEST
        select REGMAP
        help
          Say yes here to add support for the MediaTek INFRACFG
controller. The
@@ -14,7 +14,6 @@ config MTK_INFRACFG

 config MTK_PMIC_WRAP
        tristate "MediaTek PMIC Wrapper Support"
-       depends on ARCH_MEDIATEK
        select RESET_CONTROLLER
        select REGMAP
        help
@@ -24,7 +23,6 @@ config MTK_PMIC_WRAP

 config MTK_SCPSYS
        bool "MediaTek SCPSYS Support"
-       depends on ARCH_MEDIATEK || COMPILE_TEST
        default ARCH_MEDIATEK

> > +
> >  config MTK_INFRACFG
> >  	bool "MediaTek INFRACFG Support"
> >  	depends on ARCH_MEDIATEK || COMPILE_TEST
> > @@ -30,3 +32,5 @@ config MTK_SCPSYS
> >  	help
> >  	  Say yes here to add support for the MediaTek SCPSYS power domain
> >  	  driver.
> > +
> > +endmenu
> 
> 
