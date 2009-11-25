From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 25 Nov 2009 08:27:15 +0100
Subject: [PATCH v2] mx27: Add basic support for Maxtrack i-MXT TD60
In-Reply-To: <154077.29305.qm@web51006.mail.re2.yahoo.com>
References: <37367b3a0911241021u68ac346dmf30fc98f252b1d35@mail.gmail.com>
	<154077.29305.qm@web51006.mail.re2.yahoo.com>
Message-ID: <20091125072715.GS30179@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2009 at 03:19:42PM -0800, Fabio Estevam wrote:
> Hi Alan,
> 
> --- On Tue, 11/24/09, Alan Carvalho de Assis <acassis@gmail.com> wrote:
> 
> > From: Alan Carvalho de Assis <acassis@gmail.com>
> > Subject: [PATCH v2] mx27: Add basic support for Maxtrack i-MXT TD60
> > To: "linux-arm-kernel" <linux-arm-kernel@lists.infradead.org>
> > Cc: "Sascha Hauer" <s.hauer@pengutronix.de>, "Russell King - ARM Linux" <linux@arm.linux.org.uk>, "Daniel Mack" <daniel@caiaq.de>
> > Date: Tuesday, November 24, 2009, 4:21 PM
> > Signed-off-by: Alan Carvalho de Assis
> > <acassis@gmail.com>
> > ---
> >  arch/arm/mach-mx2/Kconfig? ? |? ? 7
> > ++
> >  arch/arm/mach-mx2/Makefile???|? ?
> > 1 +
> >  arch/arm/mach-mx2/mxt_td60.c |? 245
> > ++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 253 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/mach-mx2/mxt_td60.c
> 
> Don't you need to add entries to
> include/asm-arm/arch-mxc/debug-macro.S and arch
> /arm/plat-mxc/include/mach/board-mxt_td60.h like other MX27 based
> boards?

There is no board specific code in debug-macro.S any more.
board-mxt_td60.h is not needed, too. However, adding the board to
uncompress.h might be a good idea to see the "uncompressing Linux"
string.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
