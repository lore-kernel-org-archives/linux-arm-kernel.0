From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 12 Mar 2015 08:21:54 +0100
Subject: [PATCH 2/4] soc: Mediatek: Add SCPSYS power domain driver
In-Reply-To: <7hbnjzxxqo.fsf@deeprootsystems.com>
References: <1425888603-25800-1-git-send-email-s.hauer@pengutronix.de>
 <1425888603-25800-3-git-send-email-s.hauer@pengutronix.de>
 <7h61a94zy0.fsf@deeprootsystems.com>
 <20150310094142.GD24885@pengutronix.de>
 <1426043791.24243.9.camel@mtksdaap41>
 <20150311090345.GR24885@pengutronix.de>
 <7hbnjzxxqo.fsf@deeprootsystems.com>
Message-ID: <20150312072154.GB24885@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 11, 2015 at 10:14:23AM -0700, Kevin Hilman wrote:
> Sascha Hauer <s.hauer@pengutronix.de> writes:
> 
> >> I asked our designer about the bus protection feature, here is his
> >> response:
> >> 
> >> "
> >> It's for unexpected signal glitch in Power switch process.
> >> 
> >> During Power switch process, we have clock switch, reset, isolation
> >> enable/disable and  power switch involved where the transition of
> >> asynchronous reset and  isolation is the most critical one,  which have
> >> risk to introduce a unexpected short period signal transition from
> >> MTCMOS?s interface to other alive HW . 
> >> "
> >> 
> >> That means it protects unexpected bus accessing from HW, not from SW. So
> >> it will not hide bugs from wrong SW access.
> >
> > Ok, thanks for clarifying. This means we should enable this feature
> > sooner or later. Since the audio driver which is likely the first user
> > of this driver doesn't need the protection bits I think we have some
> > time and can add the protection bits once the clock patches have been
> > merged.
> 
> Sounds OK to me.
> 
> But I still think it belongs in the infracfg layer, and not in the PM
> domain layer.

I already have plans how to put the code into the infracfg driver. Where
the code is going to be called from remains to be seen. The power domain
driver might or might not be a good place for it.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
