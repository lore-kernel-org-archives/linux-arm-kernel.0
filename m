From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 31 Jul 2010 10:44:42 +0100
Subject: RFC ARM LPC32xx AMBA apb_pclk changes
In-Reply-To: <AANLkTi=eqwRMYLAUoXkuBgTrPWHsj_XbfQF4FgNOxiXd@mail.gmail.com>
References: <AANLkTi=eqwRMYLAUoXkuBgTrPWHsj_XbfQF4FgNOxiXd@mail.gmail.com>
Message-ID: <20100731094442.GF23886@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 29, 2010 at 05:24:47PM -0700, Kevin Wells wrote:
> This is a first cut at adding apb_pclk support for the AMBA bus driver.
> 
> The temporary clock enable/disable wrappers around the amba_register
> function will no longer be needed. A "apb_pclk" con_id wasn't added,
> using only the matching device IDs used by the AMBA drivers. Because
> the AMBA driver attempts to turn off the LCD clock prior to exist, the
> workaround for the LCD clock enable needs to be handled with
> clk_enable so it will stay on after the AMBA driver disables it's clock.

I think the clcd driver should be fixed not to do the first disable,
rather than work-around the problem like this.
