From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 25 May 2012 16:59:01 +0200
Subject: [PATCH 1/2] mtd mxc_nand: use 32bit copy functions
In-Reply-To: <1337957902.30969.46.camel@sauron.fi.intel.com>
References: <1337955762-19157-1-git-send-email-s.hauer@pengutronix.de>
 <1337957902.30969.46.camel@sauron.fi.intel.com>
Message-ID: <20120525145901.GS30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 25, 2012 at 05:58:22PM +0300, Artem Bityutskiy wrote:
> On Fri, 2012-05-25 at 16:22 +0200, Sascha Hauer wrote:
> > The following commit changes the function used to copy from/to
> > the hardware buffer to memcpy_[from|to]io. This does not work
> > since the hardware cannot handle the byte accesses used by these
> > functions. Instead of reverting this patch introduce 32bit
> > correspondents of these functions.
> 
> Could you please take a look at the checkpatch.pl updates?

Will do.

> 
> WARNING:LONG_LINE: line over 80 characters
> #103: FILE: drivers/mtd/nand/mxc_nand.c:276:
> +static void memcpy32_fromio(void *trg, const volatile void __iomem  *src, size_t size)
> 
> WARNING:VOLATILE: Use of volatile is usually wrong: see Documentation/volatile-considered-harmful.txt
> #103: FILE: drivers/mtd/nand/mxc_nand.c:276:
> +static void memcpy32_fromio(void *trg, const volatile void __iomem  *src, size_t size)

This makes me wonder a bit, I basically copied the prototype from
the _memcpy_*_io template from arch/arm/kernel/io.c. Should they
be wrong?
otoh I also wondered why there were volatiles in arch/arm/kernel/io.c
in the first place ;)

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
