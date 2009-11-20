From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Nov 2009 14:44:22 +0000
Subject: [PATCH 0/10] PNX clock API fixes
Message-ID: <20091120144422.GA18223@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following on from the previous set of patches...

The PNX4008 clock API usage is extremely poor.  Nothing works as it was
intended to - clk_set_rate() is used to turn clocks on and off, or
set dividers.  I certainly doesn't take the desired clock rate in Hz.
clk_get_rate() doesn't report the clock rate in Hz either - it doesn't
even report any kind of rate.

clk_enable and clk_disable seem to be very weird too.

This patch set fixes the I2C and watchdog drivers so that they can be
used with clk API implementations which do actually conform with the
clk API.

As per the previous set, selective cc's.  Full set will be on
linux-arm-kernel.
