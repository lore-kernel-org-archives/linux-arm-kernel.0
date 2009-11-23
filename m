From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 23 Nov 2009 13:10:55 +0100
Subject: [PATCH 06/12] imx-ssi sound driver
In-Reply-To: <ed82fe3e0911211812i49342b0eg2afe861c866db90c@mail.gmail.com>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-2-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-3-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-4-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-5-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-6-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-7-git-send-email-s.hauer@pengutronix.de>
	<ed82fe3e0911211812i49342b0eg2afe861c866db90c@mail.gmail.com>
Message-ID: <20091123121055.GE30179@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 21, 2009 at 08:12:34PM -0600, Timur Tabi wrote:
> On Thu, Nov 19, 2009 at 9:48 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> > ?arch/arm/plat-mxc/Makefile ? ? ? ? ? | ? ?1 +
> > ?arch/arm/plat-mxc/include/mach/ssi.h | ? 17 +
> > ?arch/arm/plat-mxc/ssi-fiq.S ? ? ? ? ?| ?134 ++++
> > ?sound/soc/imx/devdma.c ? ? ? ? ? ? ? | ? 80 ++
> > ?sound/soc/imx/devdma.h ? ? ? ? ? ? ? | ? ?3 +
> > ?sound/soc/imx/imx-ssi.c ? ? ? ? ? ? ?| 1349 ++++++++++++++++++++++++++++++++++
> > ?sound/soc/imx/imx-ssi.h ? ? ? ? ? ? ?| ? 24 +
> 
> Why did you write a new SSI driver when there already is one in sound/soc/fsl?

Mainly because I wasn't aware of the fact that the fsl driver is the
same :(

I'm currently looking if and how the code can be merged. I don't know if
it's worth it though since the common code doesn't seem to be very big.

There will have to be some changes in the fsl-ssi driver. For example I
need the irq handler for my fiq handler which means that the fsl-ssi
driver is not allowed to request the irq for it's statistic. The other
thing is the hardware accesses as we do not have in_be*, out_be* and
setbits/clrbits. Of course all these things are doable and shouldn't be
a showstopper.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
