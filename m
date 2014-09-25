From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Thu, 25 Sep 2014 10:25:06 +0200
Subject: [PATCH 2/2] socfpga: support suspend to ram
In-Reply-To: <1411590449-9794-3-git-send-email-atull@opensource.altera.com>
References: <1411590449-9794-1-git-send-email-atull@opensource.altera.com>
 <1411590449-9794-3-git-send-email-atull@opensource.altera.com>
Message-ID: <20140925082506.GC26991@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Wed, Sep 24, 2014 at 03:27:29PM -0500, atull at opensource.altera.com wrote:
> From: Alan Tull <atull@opensource.altera.com>
> 
> Add code that requests that the sdr controller go into
> self-refresh mode.  This code is run from ocram.
> 
> This patch assumes that u-boot has already configured sdr:
>   sdr.ctrlcfg.lowpwreq.selfrfshmask = 3
>   sdr.ctrlcfg.lowpwrtiming.clkdisablecycles = 8
>   sdr.ctrlcfg.dramtiming4.selfrfshexit = 512
> 
> How to suspend to ram:
>  $ echo enabled > \
> /sys/devices/soc/ffc02000.serial0/tty/ttyS0/power/wakeup
> 
>  $ echo -n mem > /sys/power/state
> 

(...)

Never looked into that, so maybe a stupid question:
What happens if the bootloader (u-boot or other) didn't configure the sdr?
Will it "just" not wake up again?

Regards,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
