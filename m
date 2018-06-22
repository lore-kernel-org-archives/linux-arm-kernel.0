From: peter.chen@nxp.com (Peter Chen)
Date: Fri, 22 Jun 2018 00:49:43 +0000
Subject: [PATCH] usb: chipidea: Fix ULPI on imx51
In-Reply-To: <26d9fd57-07bc-0bba-2f29-ca778bd85328@cogentembedded.com>
References: <20180530173414.6121-1-andrew.smirnov@gmail.com>
 <CAOMZO5AyAegbvUtX42by99mU8yQfi91bmhJfd9iqu1Ak0dEHiw@mail.gmail.com>
 <CAOMZO5DJj=oQfsB-vNP=81HCiy-69j-5U+Km9P6LxGpnLx9xzg@mail.gmail.com>
 <CAHQ1cqHxq+RM1nNHECY75Cojd_kxu1ERLe6+MhMLUa5kb10r8w@mail.gmail.com>
 <0f31d801-528e-54ee-f385-b7aa3eef414f@cogentembedded.com>
 <26d9fd57-07bc-0bba-2f29-ca778bd85328@cogentembedded.com>
Message-ID: <HE1PR04MB1450D1881C07BEAEF4A8283B8B750@HE1PR04MB1450.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> >>>>
> >>
> >> I never assumed it was a regression and that USB worked on RDU1 board
> >> before, so I never tried to see if this was a regression. I can only
> >> tell you that it hangs as soon as any PORTSC registers are accessed.
> >
> > Hang at register access usually means that module that owns the
> > register is not clocked.
> 
> On RDU1, call to usb_phy_init() actually calls usb_gen_phy_init() that does
> regulator_enable() for &vusb_reg and clk_prepare_enable() for &clk_26M_usb.  I
> thing some of these two is actually needed to avoid hang on register access.

Fabio, would you please check both regulator and clock for ULPI PHY are on at imx51bbg?

Peter
