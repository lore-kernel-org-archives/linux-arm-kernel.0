From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 11 Jan 2011 16:05:34 +0000
Subject: [PATCH 1/2] serial: Add auart driver for i.MX23/28
In-Reply-To: <1294758545-9445-2-git-send-email-s.hauer@pengutronix.de>
References: <1294758545-9445-1-git-send-email-s.hauer@pengutronix.de>
	<1294758545-9445-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20110111160534.GI11039@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 11, 2011 at 04:09:04PM +0100, Sascha Hauer wrote:
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

So you don't handle any of the termios settings at all in this driver
such as ignoring parity, reading parity, framing errors, etc.

There's a reason that you're provided with read_status_mask and
ignore_status_mask.

If you don't intend to support those termios modes, ensure that you
force the termios structure to reflect what you actually do implement
so that userspace can detect the capabilities of your driver.

IOW, iflags INPCK, BRKINT, PARMRK, IGNPAR, IGNBRK and cflag CREAD.
