From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 01 Jul 2013 16:06:00 +0200
Subject: [PATCH 1/2] ARM: dts: mx53qsb: Enable VPU support
In-Reply-To: <CAOMZO5Chnn72t12rf6tkrWNSnDreKsh57nagKc5_Vhi0j_mSWw@mail.gmail.com>
References: <1372459759-10488-1-git-send-email-festevam@gmail.com>
 <1372683396.4971.35.camel@pizza.hi.pengutronix.de>
 <CAOMZO5Chnn72t12rf6tkrWNSnDreKsh57nagKc5_Vhi0j_mSWw@mail.gmail.com>
Message-ID: <1372687560.4971.40.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

Am Montag, den 01.07.2013, 10:46 -0300 schrieb Fabio Estevam:
> On Mon, Jul 1, 2013 at 9:56 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > Hi Fabio,
> >
> > Am Freitag, den 28.06.2013, 19:49 -0300 schrieb Fabio Estevam:
> >> From: Fabio Estevam <fabio.estevam@freescale.com>
> >>
> >> Enable Video Processing Unit (VPU) support.
> >>
> >> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> >> ---
> >> Depends on Philipp Zabel's patch:
> >> [PATCH] ARM: dts: add sram for imx53 and imx6q
> >>
> >> Philipp,
> >>
> >> I tried using the original mx53 vpu firmware that comes with the FSL BSP, but it
> >> failed to load:
> >>
> >> coda 63ff4000.vpu: firmware get command error
> >> coda 63ff4000.vpu: HW initialization failed
> >>
> >> Any suggestions?
> >>
> >> Thanks!
> >
> > /*
> >  * The CODA driver needs the raw firmware without header in memory order.
> >  * This is how I converted vpu_fw_imx53.bin from the Freescale BSP into
> >  * v4l2-coda7541-imx53.bin:
> >  */
> 
> Thanks for your C code, Philipp.
> 
> Now I get:
> 
> coda 63ff4000.vpu: Initialized CODA7541.
> coda 63ff4000.vpu: Unsupported firmware version: 13.4.41
> coda 63ff4000.vpu: codec registered as /dev/video0
> 
> As input file I am using the vpu_fw_imx53.bin from FSL BSP version 11.09.
> 
> Where should I get the vpu_fw_imx53.bin file so that I do not get the
> unsupported warning?

The current firmware version is 1.4.50 (yes, 1.4.50 > 13.4.41). It is
contained in the L3.0.35_12.09.01 or L3.0.35_4.0.0 (20130424) BSP
releases.

regards
Philipp
