From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 25 Nov 2014 13:54:24 +0100
Subject: [PATCH] of: support passing console options with stdout-path
In-Reply-To: <20141125103504.GA21525@leverpostej>
References: <1416867838-18652-1-git-send-email-leif.lindholm@linaro.org>
 <20141125103504.GA21525@leverpostej>
Message-ID: <20141125125424.GN14482@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 25, 2014 at 10:35:04AM +0000, Mark Rutland wrote:
> Hi Leif,
> 
> On Mon, Nov 24, 2014 at 10:23:58PM +0000, Leif Lindholm wrote:
> > Support specifying console options (like with console=ttyXN,<options>)
> > by appending them to the stdout-path property after a separating ':'.
> > 
> > Example:
> > 	stdout-path = "uart0:115200";
> 
> I would very much like to be able to use this -- it will allow
> distributions to boot on a board without having to know _anything_ about
> the console UART until userspace is up, which would make it possible to
> have a completely generic installer image, without requiring the
> platform to provide bootargs.

Note there are several serial drivers that read back the console options
from the hardware assuming it has been initialized correctly by the
bootloader already. So when your bootloader already made some output
on the console (which is likely) you can do that already. Of course
this doesn't solve all problems, like if you want to use a different
console for the kernel than for the bootloader.
Anyway, this behaviour is very nice since the kernel always uses the
same speed for the console as the bootloader does.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
