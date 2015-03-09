From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Mon, 9 Mar 2015 16:26:24 +0800
Subject: [PATCH 2/2] pinctrl: mediatek: Adjust mt8173 pinctrl kconfig
In-Reply-To: <1425639954.24292.274.camel@x220>
References: <1425623091-30478-1-git-send-email-yingjoe.chen@mediatek.com>
 <1425623091-30478-2-git-send-email-yingjoe.chen@mediatek.com>
 <1425639954.24292.274.camel@x220>
Message-ID: <1425889584.4871.12.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2015-03-06 at 12:05 +0100, Paul Bolle wrote:
> On Fri, 2015-03-06 at 14:24 +0800, Yingjoe Chen wrote:
> > --- a/drivers/pinctrl/mediatek/Kconfig
> > +++ b/drivers/pinctrl/mediatek/Kconfig
> 
> > @@ -8,11 +8,13 @@ config PINCTRL_MTK_COMMON
> >  	select OF_GPIO
> >  
> >  config PINCTRL_MT8135
> > -	def_bool MACH_MT8135
> > +	def_bool MACH_MT8135 || COMPILE_TEST
> >  	select PINCTRL_MTK_COMMON
> >  
> >  config PINCTRL_MT8173
> > -	def_bool MACH_MT8173
> > +	bool "Mediatek MT8173 pin control"
> > +	def_bool y
> 
> The kconfig tools will do what you mean here, but I think it's cleaner
> to make this just:
> 	bool "Mediatek MT8173 pin control"
> 	default y
> 

Hi Paul,

Just sent a new version with this change.
Thanks for your suggestion.

Joe.C
