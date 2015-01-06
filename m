From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 06 Jan 2015 14:54:19 +0100
Subject: [PATCH] ARM: dts: imx51-babbage: Fix ULPI PHY reset modelling
In-Reply-To: <CAOMZO5Bn58O2Mr4SsBqWbiwecOKOiQMDDugLzi+aRVf+jOx=Sg@mail.gmail.com>
References: <1420478348-2754-1-git-send-email-fabio.estevam@freescale.com>
 <20150106124343.GM24511@dragon> <1420551365.2333.15.camel@pengutronix.de>
 <CAOMZO5Bn58O2Mr4SsBqWbiwecOKOiQMDDugLzi+aRVf+jOx=Sg@mail.gmail.com>
Message-ID: <1420552459.2333.18.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 06.01.2015, 11:47 -0200 schrieb Fabio Estevam:
> On Tue, Jan 6, 2015 at 11:36 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> 
> > For the record:
> > I'm not happy with this patch. It still abuses the regulator API for
> > something completely unrelated and this may well break again in the
> > future. But given that it fixes an actual regression and you already
> > sent a pull including this I'm okay to keep it.
> >
> > We still need a proper fix to handle ULPI resets to get rid of this
> > hackery.
> 
> Actually the ULPI PHY reset is properly handled now. What is missing
> is the USB Hub reset to be properly handled.
> 
No it is not. A regulator isn't the proper abstraction for a reset at
all. Even if you (ab)use the regulator drivers ability to toggle a reset
GPIO.
A ULPI PHY reset needs to be modeled as a GPIO reset attached to USB
controller node. There is no other way to describe the hardware
accurately.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
