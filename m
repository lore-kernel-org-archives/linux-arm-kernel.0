From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 03 Sep 2013 16:35:19 +0200
Subject: [PATCH 2/2] ARM: OMAP4+: Move SRAM data to DT
In-Reply-To: <CA+Bv8XaK3fBkRZjN8dCzi9dt9C3SVe2nT746Szzb_F=69w=fMw@mail.gmail.com>
References: <1377598305-15539-1-git-send-email-rnayak@ti.com>
 <1377598305-15539-3-git-send-email-rnayak@ti.com>
 <CA+Bv8XaK3fBkRZjN8dCzi9dt9C3SVe2nT746Szzb_F=69w=fMw@mail.gmail.com>
Message-ID: <1378218919.5891.3.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 03.09.2013, 06:56 -0700 schrieb Russ Dill:
> On Tue, Aug 27, 2013 at 3:11 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> > Use drivers/misc/sram.c driver to manage SRAM on all DT only
> > OMAP platforms (am33xx, am43xx, omap4 and omap5) instead of
> > the existing private implementation.
> >
> > Address and size related data  is removed from mach-omap2/sram.c
> > and now passed to drivers/misc/sram.c from DT.
> >
> > Users can hence use general purpose allocator apis instead of
> > OMAP private ones to manage and use SRAM.
> >
> > Currently there are no users on SRAM on these platfoms.
> >
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> 
> I was trying to experiment with this on am33xx, but I noticed that the
> ioremap region is not marked exec, so it cannot be used to run code.

Could you outline a use-case where you would need to execute code from
SRAM while running in a linux system? I'm curious what you would use
this for.

Regards,
Lucas
-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
