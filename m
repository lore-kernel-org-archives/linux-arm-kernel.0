From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 28 May 2015 16:15:41 +0200
Subject: [PATCH] drm: atmel_hlcdc: Add support for get_timings
In-Reply-To: <1432821104.3228.60.camel@pengutronix.de>
References: <1432199216-1139-1-git-send-email-davidcdueck@googlemail.com>
 <20150526112853.688d26b7@bbrezillon>
 <1432811608.3228.43.camel@pengutronix.de>
 <20150528144555.13cd755a@bbrezillon>
 <1432821104.3228.60.camel@pengutronix.de>
Message-ID: <20150528161541.7c853787@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 28 May 2015 15:51:44 +0200
Philipp Zabel <p.zabel@pengutronix.de> wrote:

> Am Donnerstag, den 28.05.2015, 14:45 +0200 schrieb Boris Brezillon:
> > Hi Philip,
> > 
> > On Thu, 28 May 2015 13:13:28 +0200
> > Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > 
> > > Hi Boris,
> > > 
> > > Am Dienstag, den 26.05.2015, 11:28 +0200 schrieb Boris Brezillon:
> > > > Hi David,
> > > > 
> > > > On Thu, 21 May 2015 11:06:56 +0200
> > > > David Dueck <davidcdueck@googlemail.com> wrote:
> > > > 
> > > > > drm_panel supports querying timing ranges. If the supplied mode does
> > > > > not work with the hlcdc we query the panel and try to find a suitable
> > > > > mode.
> > > > 
> > > > This patch looks good to me.
> > > > 
> > > > Philip, Thierry, could you confirm this is the correct way of dealing
> > > > with timing ranges.
> > > 
> > > I wonder about two things:
> > > 
> > > This implementation minimizes the sum of absolute differences between
> > > chosen and typical values. I wonder if it would be better to try and
> > > minimize the difference between the chosen and nominal vertical refresh
> > > rate.
> > 
> > I'm not sure to understand what you mean.
> > Are you suggesting that we should try keeping the vtotal (and maybe the
> > htotal too) value unchanged by adapting the timing values ?
> 
> More or less, only that I'd first modify htotal and vtotal to get closer
> to the ideal frametime (1/vrefresh) if the pixel clock can't be set
> exactly to the panel's typical pixel clock rate.

Okay, now I get it (I was just keeping the pixel clk rate out of the
equation).
That sounds reasonable.

Thanks,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
