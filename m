From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 25 Jul 2014 14:34:38 +0800
Subject: [PATCH] imx-drm: imx-drm-core: add suspend/resume support
In-Reply-To: <53D0D850.8050201@pengutronix.de>
References: <1406193474-13695-1-git-send-email-shawn.guo@freescale.com>
 <1406195275.4590.18.camel@weser.hi.pengutronix.de>
 <53D0D850.8050201@pengutronix.de>
Message-ID: <20140725063437.GG8821@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 24, 2014 at 11:56:32AM +0200, Marc Kleine-Budde wrote:
> >> @@ -696,6 +696,44 @@ static int imx_drm_platform_remove(struct platform_device *pdev)
> >>  	return 0;
> >>  }
> >>  
> >> +#if CONFIG_PM_SLEEP
> > 
> > use #ifdef
> 
> ...or remove #if/#ifdef and mark as __maybe_unused

I personally do not like the idea of __maybe_unused.  Will there be a
compile error if I call some helper functions which are only available
with CONFIG_PM_SLEEP?

Shawn
