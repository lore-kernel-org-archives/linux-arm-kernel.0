From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sun, 17 Jun 2012 15:02:42 +0200
Subject: [PATCH] ARM: mx23: Add initial support for olinuxino board
In-Reply-To: <CAOMZO5AOiaUqbiOS6e40v=jHJ2U3Dit2D5b8_2OZnEeV-A_Ong@mail.gmail.com>
References: <1339914539-4154-1-git-send-email-festevam@gmail.com>
 <201206171314.09561.marex@denx.de>
 <CAOMZO5CrRwduuFVtvHHnP2Vb-XS=VR+rf-RS9ZaeSkWmdUnWQw@mail.gmail.com>
 <CAOMZO5AOiaUqbiOS6e40v=jHJ2U3Dit2D5b8_2OZnEeV-A_Ong@mail.gmail.com>
Message-ID: <20120617130242.GA28394@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 17, 2012 at 09:59:18AM -0300, Fabio Estevam wrote:
> On Sun, Jun 17, 2012 at 9:41 AM, Fabio Estevam <festevam@gmail.com> wrote:
> > On Sun, Jun 17, 2012 at 8:14 AM, Marek Vasut <marex@denx.de> wrote:
> >
> >>> ?static const char *imx23_dt_compat[] __initdata = {
> >>> ? ? ? "fsl,imx23-evk",
> >>> + ? ? "fsl,imx23-olinuxino",
> >>
> >> Is this addition needed?
> >
> > Actually it is not required. Board boots just fine without it.
> >
> > I have just kept this for compatibilty with other i.MX boards boards
> > added to dt.
> >
> > I followed the same approach from imx6q_dt_compat and imx53_dt_compat.
> 
> I would prefer to do something like that instead:
> 
> static const char *<soc>_dt_compat[] __initdata = {
> 	"fsl,<soc>",
> 	NULL,
> }
> 
> ,this way we do not have to patch a C file when adding a new board file.
> 

There already is a fsl,imx23 compatible entry, you just have to use it.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
