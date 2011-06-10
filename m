From: shreshthakumar.sahu@stericsson.com (Shreshtha Kumar SAHU)
Date: Fri, 10 Jun 2011 14:37:06 +0530
Subject: [PATCH 2/2] amba pl011: platform data for reg lockup and glitch
In-Reply-To: <20110609210218.GH24424@n2100.arm.linux.org.uk>
References: <1307653008-3398-1-git-send-email-linus.walleij@stericsson.com>
	<20110609210218.GH24424@n2100.arm.linux.org.uk>
Message-ID: <20110610090704.GA476@bnru02.bnr.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 09, 2011 at 23:02:18 +0200, Russell King - ARM Linux wrote:
> On Thu, Jun 09, 2011 at 10:56:48PM +0200, Linus Walleij wrote:
> > +	/* uart-0 pins gpio configuration should be
> > +	 * kept intact to prevent glitch in tx line
> > +	 * when tty dev is opened. Later these pins
> > +	 * are configured to uart mop500_pins_uart0
> > +	 *
> > +	 * It will be replaced with uart configuration
> > +	 * once the issue is solved.
> > +	 */
> > +	GPIO0_GPIO	| PIN_INPUT_PULLUP,
> > +	GPIO1_GPIO	| PIN_OUTPUT_HIGH,
> > +	GPIO2_GPIO	| PIN_INPUT_PULLUP,
> > +	GPIO3_GPIO	| PIN_OUTPUT_LOW,
> 
> Why do you want the TXD line (GPIO3) to be indicating a break condition?

Yes it should be PIN_OUTPUT_HIGH, as it is configured in mop500_pins_uart0.

Thanks,
Shreshtha
