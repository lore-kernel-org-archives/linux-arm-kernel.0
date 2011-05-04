From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 4 May 2011 18:04:42 +0200
Subject: [PATCH 4/6] ARM: mxc: don't allow to compile together i.MX51 and
	i.MX53
In-Reply-To: <BANLkTinaFVXP10vbaF_We+kS2onwZAugQA@mail.gmail.com>
References: <1302464943-20721-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1302464943-20721-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110413122503.GB1897@S2100-06.ap.freescale.net>
	<20110413124149.GR18850@pengutronix.de>
	<BANLkTinaFVXP10vbaF_We+kS2onwZAugQA@mail.gmail.com>
Message-ID: <20110504160442.GK11574@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 04, 2011 at 10:48:40AM -0500, Matt Sealey wrote:
> 2011/4/13 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > Hi Shawn,
> >
> > On Wed, Apr 13, 2011 at 08:25:04PM +0800, Shawn Guo wrote:
> >> On Sun, Apr 10, 2011 at 09:49:01PM +0200, Uwe Kleine-K?nig wrote:
> >> [...]
> >> > + ? ? This enables support for machines using Freescale's i.MX50 and i.MX51
> >> s/MX51/MX53/
> > yeah, thanks, as you're not the first one to point this out I already
> > sent a fixup to Sascha.
> 
> Can someone confirm the following for me (Uwe probably as it's his
> patch most recently)
> 
> CONFIG_RUNTIME_PHYS_OFFSET
RUNTIME_PHYS_OFFSET didn't made it into mainline and is superseded by
ARM_PATCH_PHYS_VIRT.

> CONFIG_ARM_PATCH_PHYS_VIRT
> 
> These two config options, with absolutely no bootloader changes, will
> basically mask off some address (instruction pointer?) at the time of
> the check and therefore derive a perfectly good PHYS_OFFSET at runtime
> and make sure it is in use... within some limits (first 128MB, assumes
> that start of memory is at some particular alignment)?
> 
> I am confused about Nicolas' CONFIG_AUTO_ZRELADDR comment and how this
> applies. I am working out a way to have U-Boot ignore the hardcoded
> image entry point in a uImage to enable the above.
ARM_PATCH_PHYS_VIRT is a feature of the Image, AUTO_ZRELADDR is a
feature of the zImage. It solves more or less the same thing (and IIRC
RUNTIME_PHYS_OFFSET did both). So AUTO_ZRELADDR is only needed when
booting a zImage.

And IIRC U-Boot can boot zImages directly nowerdays. So this is probably
the better way to test that hacking it to ignore the image headers.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
