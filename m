From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 14 Jul 2016 20:34:42 +0200
Subject: [PATCH 3/6] ARM: dts: imx25: substitute NO_PAD_CTL by the
 respective reset value
In-Reply-To: <CAOMZO5BtP29PD-vf1WKG0yd7OJy9A0Sthn4EQ+CuF1As2cmKoA@mail.gmail.com>
References: <20160711073721.GM16643@pengutronix.de>
 <CAOMZO5ASsA88TQLAPdyit0xr3Lqh8e+8C_ZgoUa7w2rZxTb-ag@mail.gmail.com>
 <20160712073859.GQ16643@pengutronix.de>
 <CAOMZO5B+grtejgSMKrZMT9inEdh+bL0smZKE52qtcQD1NCHrqQ@mail.gmail.com>
 <CAOMZO5D2E_G4ySUnj=yadziSunwMBSVZs-Rw=EvNybFKs2iD3w@mail.gmail.com>
 <20160712191541.GY16643@pengutronix.de>
 <CAOMZO5C3eQFfs=ZS5nfDw6XnEAgfcc_+W2n0y8Xd-zsTfd-+gA@mail.gmail.com>
 <CAOMZO5B4CUr_-U3s+fo-O_BcREWQijffXFeRmUPiwDWdhY07pQ@mail.gmail.com>
 <20160713062521.GZ16643@pengutronix.de>
 <CAOMZO5BtP29PD-vf1WKG0yd7OJy9A0Sthn4EQ+CuF1As2cmKoA@mail.gmail.com>
Message-ID: <20160714183442.GG6040@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Fabio,

On Thu, Jul 14, 2016 at 02:04:14PM -0300, Fabio Estevam wrote:
> On Wed, Jul 13, 2016 at 3:25 AM, Uwe Kleine-K?nig
> <u.kleine-koenig@pengutronix.de> wrote:
> 
> > Which U-Boot did you test? Mainline or the vendor variant?

I assume the vendor variant, because your patch doesn't match what I saw
in U-Boot mainline.

> > Can you provide the output of
> >
> >         md 0x43fac000+0x584
> 
> Here it goes:
> => md.l 0x43fac584 1
> 43fac584: 00000000                               ....

I guess your tool (U-Boot?) would generate the output I want with:

	md.l 0x43fac000 353

(i.e. 353 32bit words, that are all the iomux registers)

> > in U-Boot (which for sure has a different syntax that I don't know) and
> > from Linux
> >
> >         memtool md 0x43fac000+0x584
> 
> The memtool utility version I have is broken for mx25, so I can't dump
> this register easily in Linux.

Which version do you have? How is it broken? Did you configure AIPS to
allow non-privileged access to the peripherals? Our internal
documentation tells you have to set (in the boot loader) the following
registers to 0:

	0x43f00020 0x43f00024 0x43f00028 0x43f0002c
	0x43f00040 0x43f00044 0x43f00048 0x43f0004c 0x43f00050

After that memtool works fine for me in Linux.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
