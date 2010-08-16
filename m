From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Mon, 16 Aug 2010 14:21:00 -0700
Subject: input/touch: LPC32xx: Introduce touch driver for the LPC32xx (v2)
Message-ID: <1281993661-21097-1-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set introduces support for the LPC32xx touchscreen
controller driver. The LPC32xx touchscreen controller supports
automated event detection and conversion for resistive touchscreens.

The patch can be pulled from:
	git://git.lpclinux.com/linux-2.6-lpc ts-lpc32xx_v2

v2 includes updates from the initial review of the TSC driver..
	All local TSC_* macros have been prefixed with LCP32XX_
	Added lpc32xx_ prefix to stop_tsc() and start_tsc()
	Moved clk_enable and clk_disable into lpc32xx_start_tsc()
		and lpc32xx_stop_tsc() functions
	Added ->open and ->close methods using the start and
		stop tsc functions
	Removed use of devm_* functions. Modified error unwinding
		and _remove() based on this change.
	Fixed an error return condition from input_register_device()
	Fixed use of input_free_device
	Added a use count check for suspend and resume so device
		state isn't altered if it isn't open
