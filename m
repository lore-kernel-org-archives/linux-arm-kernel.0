From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 14 Jul 2016 21:21:37 +0200
Subject: [PATCH 3/6] ARM: dts: imx25: substitute NO_PAD_CTL by the
 respective reset value
In-Reply-To: <CAOMZO5B-vrwvOHimF4HzfDMpkG2Nwjz-D0Awp-BrJUxDF_txPA@mail.gmail.com>
References: <20160712073859.GQ16643@pengutronix.de>
 <CAOMZO5B+grtejgSMKrZMT9inEdh+bL0smZKE52qtcQD1NCHrqQ@mail.gmail.com>
 <CAOMZO5D2E_G4ySUnj=yadziSunwMBSVZs-Rw=EvNybFKs2iD3w@mail.gmail.com>
 <20160712191541.GY16643@pengutronix.de>
 <CAOMZO5C3eQFfs=ZS5nfDw6XnEAgfcc_+W2n0y8Xd-zsTfd-+gA@mail.gmail.com>
 <CAOMZO5B4CUr_-U3s+fo-O_BcREWQijffXFeRmUPiwDWdhY07pQ@mail.gmail.com>
 <20160713062521.GZ16643@pengutronix.de>
 <CAOMZO5BtP29PD-vf1WKG0yd7OJy9A0Sthn4EQ+CuF1As2cmKoA@mail.gmail.com>
 <20160714183442.GG6040@pengutronix.de>
 <CAOMZO5B-vrwvOHimF4HzfDMpkG2Nwjz-D0Awp-BrJUxDF_txPA@mail.gmail.com>
Message-ID: <20160714192137.GH6040@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Fabio,

On Thu, Jul 14, 2016 at 04:16:59PM -0300, Fabio Estevam wrote:
> I am running U-boot 2016.07 from mainline.

hmm, ok.

> > I guess your tool (U-Boot?) would generate the output I want with:
> >
> >         md.l 0x43fac000 353
> >
> > (i.e. 353 32bit words, that are all the iomux registers)
> 
> Here it goes:
> 
> [...]

Thanks, will take a look.

> >> The memtool utility version I have is broken for mx25, so I can't dump
> >> this register easily in Linux.
> >
> > Which version do you have? How is it broken? Did you configure AIPS to
> 
> The problem is that all IOMUX registers were returning the same
> incorrect values with memtool on mx25.

Yeah, that's the effect when the AIPS access control registers are not
setup correctly.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
