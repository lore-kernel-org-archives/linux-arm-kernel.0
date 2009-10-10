From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 10 Oct 2009 19:03:19 +0100
Subject: [PATCH 7/8] bcmring: add gpio csp code and header
In-Reply-To: <9383297B60843144AC17878B479520F110AE9A6EE6@SJEXCHCCR01.corp.ad.broadcom.com>
References: <20091010092841.GA23492@n2100.arm.linux.org.uk>
	<9383297B60843144AC17878B479520F110AE9A6EE6@SJEXCHCCR01.corp.ad.broadcom.com>
Message-ID: <20091010180319.GA28716@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 10, 2009 at 09:56:43AM -0700, Scott Branden wrote:
> I do see a lot of pin mux'ing code in various arch
> directories, but I do not see a common mechanism in the kernel to handle
> this.

Pin muxing seems to be very SoC specific, and so it is not covered by
a common implementation (yet).

Also, experience shows us that drivers should not be doing any pin
muxing operations themselves - the best place for that appears to be
the board support code itself, which knows how the board is wired up.
In addition, there are SoCs where putting pin muxing code in the driver
would make things really complicated, involving platforms having to
pass this information into drivers.
