From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Sun, 08 Dec 2013 16:16:15 -0800 (PST)
Subject: [alsa-devel] [PATCH 2/2] ASoC: sh: rcar: Depend
 on	ARCH_SHMOBILE_LEGACY
In-Reply-To: <1682501.71qI5yTem5@avalon>
References: <1384000429-3590-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1384000429-3590-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1682501.71qI5yTem5@avalon>
Message-ID: <87wqjevpyv.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent

Thank you for your patch

> What's your opinion about this patch ? It needs to be applied on top of 
> "[PATCH 1/2] ARM: Rename ARCH_SHMOBILE to ARCH_SHMOBILE_LEGACY" which has been 
> queued by Simon.
> 
> On Saturday 09 November 2013 13:33:49 Laurent Pinchart wrote:
> > The driver doesn't compile on multiplatform kernels as it requires
> > <mach/clock.h>.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> >  sound/soc/sh/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/sound/soc/sh/Kconfig b/sound/soc/sh/Kconfig
> > index 56d8ff6..ce7cfd6 100644
> > --- a/sound/soc/sh/Kconfig
> > +++ b/sound/soc/sh/Kconfig
> > @@ -36,6 +36,7 @@ config SND_SOC_SH4_SIU
> > 
> >  config SND_SOC_RCAR
> >  	tristate "R-Car series SRU/SCU/SSIU/SSI support"
> > +	depends on ARCH_SHMOBILE_LEGACY
> >  	select SND_SIMPLE_CARD
> >  	select RCAR_CLK_ADG
> >  	help

<mach/clock.h> had been removed by this patch.
Does it solve your issue ?

commit d3be689e6a07c00123786659b4429b07cf4272ac
Author: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date:   Tue Sep 24 01:25:08 2013 -0700

    ASoC: rcar: remove unnecessary mach/clock.h
    
    ${LINUX}/sound/soc/sh driver can be compiled from
    SuperH and ARM.
    but, ${LINUX}/sound/soc/sh/rcar driver included
    SH-ARM specific header.
    This patch removes it
    
    Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    Signed-off-by: Mark Brown <broonie@linaro.org>
