From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 3 Jan 2011 13:48:04 +0000
Subject: [PATCH 02/04] ARM i.MX25 Add SIM driver
In-Reply-To: <20110103130551.GA24408@pengutronix.de>
References: <20736.212.121.242.58.1294045639.squirrel@mail.fqingenieria.es>
	<20110103130551.GA24408@pengutronix.de>
Message-ID: <20110103134804.GL26785@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 03, 2011 at 02:05:51PM +0100, Sascha Hauer wrote:
> The following comments are mostly coding style related, running Lindent
> and checkpatch.pl on this patch seems to be a good start for improving
> this driver.

Beware of Lindent - it can scrunch lines against the right hand side.

Always build the driver before you Lindent it, take a copy of the object
file, then Lindent it, and then re-build it and confirm that the resulting
code and data is indentical.  A Lindent shouldn't ever change the produced
code, but unfortunately it has been known to do so.

Keep the Lindenting as a single commit - never combine it with other stuff.

Always go through the driver after running Lindent and fix up scrunches
on the right hand side by hand (maybe it needs the function splitting
into a few helper functions?)  Commit these (and any other fixups) as a
follow-on commit.
