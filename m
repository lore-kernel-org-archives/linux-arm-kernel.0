From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 8 Feb 2012 10:00:55 +0100
Subject: [PATCH v2 02/10] pwm: Allow chips to support multiple PWMs.
In-Reply-To: <20120208081508.GA6673@avionic-0098.mockup.avionic-design.de>
References: <1328541585-24642-1-git-send-email-thierry.reding@avionic-design.de>
 <1328541585-24642-3-git-send-email-thierry.reding@avionic-design.de>
 <4F31AB63.3020301@gmail.com>
 <20120208081508.GA6673@avionic-0098.mockup.avionic-design.de>
Message-ID: <20120208090055.GP3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2012 at 09:15:08AM +0100, Thierry Reding wrote:
> * Ryan Mallon wrote:
> > On 07/02/12 02:19, Thierry Reding wrote:
> > > The total maximum number of PWM devices is currently fixed to 64, but
> > > can easily be made configurable via Kconfig.
> > 
> > It would be better to make the code handle arbitrary numbers of PWMs. A
> > Kconfig knob becomes annoying when you have more than one platform
> > configured into the kernel.
> 
> AFAICT handling an arbitrary number of PWMs will only be possible once we get
> rid of the global namespace and therefore should be postponed for later. I
> may be wrong, though, so if anybody can point me in the right direction I'm
> perfectly happy to change that in this series.
> 
> > > The patch is incomplete in that it doesn't convert any existing drivers
> > > that are now broken.
> > 
> > Does this patch actually break the drivers in terms of not building or
> > running? If so, can this patch series be reworked a bit to allow the old
> > PWM framework to be used until all of the drivers are converted?
> 
> That sentence is misleading. Since the new framework implements the exact
> same API as the drivers, any unconverted drivers will still work unless they
> are built within the same kernel as the framework.

I have a series porting all in kernel drivers to this framework. I can
follow up on this series once it's clear we want to go this way. With
this series the way will be free to move to a better pwm matching
without a global pwm index because the drivers won't be affected by
this change anymore.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
