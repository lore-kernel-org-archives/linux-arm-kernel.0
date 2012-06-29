From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 29 Jun 2012 11:15:48 +0200
Subject: [PATCH] ARM: imx: fix i.MX35 CPU architecture
In-Reply-To: <2054987969.254809.1340896110005.JavaMail.root@advansee.com>
References: <20120628105720.GA21278@pengutronix.de>
 <2054987969.254809.1340896110005.JavaMail.root@advansee.com>
Message-ID: <20120629091548.GH24458@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2012 at 05:08:30PM +0200, Beno?t Th?baudeau wrote:
> On Thu, Jun 28, 2012 at 12:57:20PM +0200, Sascha Hauer wrote:
> > On Wed, Jun 27, 2012 at 10:28:26PM +0200, Beno?t Th?baudeau wrote:
> > > The data sheet of the i.MX35 says it is an ARM1136JF-S processor,
> > > version r1p3,
> > > which, according to section "B.1. New instructions" of the
> > > ARM1136JF-S and
> > > ARM1136J-S Technical Reference Manual, makes the i.MX35 CPU
> > > architecture not
> > > only ARMv6, but ARMv6k.
> > 
> > Is this true for i.MX31 aswell?
> 
> No.
> 
> > If not, we would have to add
> > additional
> > magic to enable CPU_V6K only when SOC_IMX31 is not selected.
> 
> Why? That could be "select CPU_V6K if !SOC_IMX31", but e.g. CPU_V7 is selected
> by SOC_IMX5 whether or not SOC_IMX31 or SOC_IMX35 is selected, and CPU_V6/6K/7
> conflicts are handled with priorities by the ARM infrastructure.

A boot test on i.MX31 shows that you are probably right. I remember a
time when enabling CPU_V6K caused trouble, but it seems this has been
sorted out.

So, applied this one.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
