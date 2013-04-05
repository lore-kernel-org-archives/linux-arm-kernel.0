From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 5 Apr 2013 11:22:06 +0200
Subject: 3.8 no mach include directory anymore?
In-Reply-To: <15525047.PsIxlFA1vB@dabox>
References: <15525047.PsIxlFA1vB@dabox>
Message-ID: <20130405092206.GA10373@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tim,

On Fri, Apr 05, 2013 at 08:13:02AM +0200, Tim Sander wrote:
> Hi
> 
> I have a small driver which uses the MX35_IO_ADDRESS which had been defined in
> #include <mach/mx35.h>

A driver should never use MX35_IO_ADDRESS.

> but while the mx35.h file still exist the include directory has vanished?
> 
> Any idea how to get the module compiling again with 3.8?

Use ioremap, add whatever hack is necessary, or very much preferred:
Convert you board over to devicetree and retrieve the base address
properly from there.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
