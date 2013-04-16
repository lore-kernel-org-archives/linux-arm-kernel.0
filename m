From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 16 Apr 2013 08:32:22 +0200
Subject: [PATCH v2 3/4] ARM: dts: mx53qsb: Add support for parallel display
In-Reply-To: <CAOMZO5DwoP4WXEVfKkqbfrJ60s0GxqkLOa_h1TQNJXY61_NTbQ@mail.gmail.com>
References: <1365516452-1287-1-git-send-email-rogerio.pimentel@freescale.com>
 <1365516452-1287-3-git-send-email-rogerio.pimentel@freescale.com>
 <1365520643.4023.52.camel@pizza.hi.pengutronix.de>
 <CAOkaPuV2xNR=Vxsa6tPdnPS34Q5ffV9-f8DefhcJfvVvXWOADQ@mail.gmail.com>
 <20130413170943.GX1906@pengutronix.de>
 <CAOMZO5DwoP4WXEVfKkqbfrJ60s0GxqkLOa_h1TQNJXY61_NTbQ@mail.gmail.com>
Message-ID: <20130416063222.GF1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 15, 2013 at 09:18:35PM -0300, Fabio Estevam wrote:
> Sascha/Phillip,
> 
> On Sat, Apr 13, 2013 at 2:09 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> 
> > Having the parallel display support is fine. Philipp just suggested to
> > add status = "disabled" for both the parallel display and the lvds
> > encoder so that for example the bootloader can decide which one to enable
> > during runtime. Otherwise we have two display options on the same pins and
> > the first one wins.
> 
> Ok, understood.
> 
> It is not clear how we can tell the bootloader that we want the CLAA
> WVGA panel or the HDMI daughter card, for example?

In barebox we would do a 'of_property -s /soc/display at di0 status okay'.
I don't know the corresponding U-Boot command.

> 
> What would be the kernel command line in each case?

Ther kernel command line is not involved here.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
