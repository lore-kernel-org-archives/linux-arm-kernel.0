From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Nov 2009 23:50:12 +0000
Subject: [PATCH 05/10] ARM: PNX4008: convert watchdog to use clk API
	enable/disable calls
In-Reply-To: <083DF309106F364B939360100EC290F804F55464A2@eu1rdcrdc1wx030.exi.nxp.com>
References: <20091120144422.GA18223@n2100.arm.linux.org.uk>
	<E1NBUk5-0004Pg-Q4@rmk-PC.arm.linux.org.uk>
	<20091120150332.GY19336@infomag.iguana.be>
	<083DF309106F364B939360100EC290F804F55464A2@eu1rdcrdc1wx030.exi.nxp.com>
Message-ID: <20091123235012.GK18142@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2009 at 12:38:12AM +0100, Kevin Wells wrote:
> The wdt_enable() functions also assumes a wdt counter rate of 13MHz
> with the WDOG_COUNTER_RATE macro. I think this was ok for the original
> PNX part, but the LPC32XX platform's rate will vary based on the
> system clock rate of the device. The nominal rate is 13.325MHz.
> 
> I've checked the previous 3 WDT patches and made the necessary changes
> to my clock driver and everything still works on the LPC32xx platforms,
> but can't check changes on the PNX4008 platform (have no hardware).
> 
> I'll submit a patch to use clk_get_rate instead of the macro..

Great.  As far as switching to clk_get_rate, the PNX4008 code is not
nice in that regard, but it will be made to return the desired 13MHz
value. ;)

Out of interest, the PNX4008 code hasn't been seriously touched since
December 2006 - does anyone care about it?  I've not had any reply
from Vitaly, so I suspect he doesn't have anything to do with it
anymore.

If the answer is no, it might be a good idea to declare the code dead
and schedule it for removal in maybe six months time.
