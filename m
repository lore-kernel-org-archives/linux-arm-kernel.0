From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 27 Oct 2010 18:31:40 +0200
Subject: [PATCH] ARM: imx: Add some core definitions for MX53
In-Reply-To: <86A0E76937111F4C92FABEC0A2098851051D6523@az33exm21>
References: <1288119235-7036-1-git-send-email-Dinh.Nguyen@freescale.com>
	<20101027082958.GA6797@angua.secretlab.ca>
	<20101027090921.GB8554@pengutronix.de>
	<20101027102253.GA7822@angua.secretlab.ca>
	<20101027132213.GJ6017@pengutronix.de>
	<4CC82A13.8000909@eukrea.com>
	<20101027135642.GM6017@pengutronix.de>
	<86A0E76937111F4C92FABEC0A2098851051D6523@az33exm21>
Message-ID: <20101027163140.GN6017@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 27, 2010 at 07:57:11AM -0700, Nguyen Dinh-R00091 wrote:
> >
> >Yes, I know. Is MX5_1_3 better? Any other suggestions?
> 
> Not sure why we can't do something like this?
> 
> In mx5x.h, 
> MX51_PERIP_1 /* Address specific to mx51 */
> MX53_PERIP_1 /* Address specific to mx53 */
> MX5_PERIP_2 /* Address that is shared to mx51, mx53, and any later mx5X chips */

The problem is that we don't know about 'any later chips' and we don't
know whether the MX5_ assumption stays true for later MX5 chips.

To end this, let's just use the complete names for all i.MX defines,
that is MX51 for MX51 and MX53 for MX53. It's the only way to handle
this consistently for *all* i.MX, not only the MX5 ones.

Uwe has worked a lot on making the overhead for this as little s
possible and in the end we are just talking about a handfull of base
addresses and interrupt/dma request numbers. It should be simple to add
them without asking the question 'is this mxx specific or mxy also?'
over and over again.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
