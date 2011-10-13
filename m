From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 13 Oct 2011 23:12:33 +0100
Subject: [PATCH v2 3/5] regulator: helper routine to extract
	regulator_init_data
In-Reply-To: <20111013183821.GN18574@ponder.secretlab.ca>
References: <1318263578-7407-1-git-send-email-rnayak@ti.com>
	<1318263578-7407-4-git-send-email-rnayak@ti.com>
	<20111010172222.GG3607@opensource.wolfsonmicro.com>
	<4E93DB41.2080900@ti.com>
	<20111013183821.GN18574@ponder.secretlab.ca>
Message-ID: <20111013221232.GB2866@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 13, 2011 at 12:38:21PM -0600, Grant Likely wrote:

> These *sound* like flags that the driver would set based on its own
> capabilities; in which case it is something that would be encoded
> directly into the driver.

They're almost entirely a combination of system specifics and software
capabilities - it's not even reliably one or the other.  For example the
ability to switch regulator modes is going to depend on a combination of
the modes a specific regulator offers, the set of things connected to
the regulator in the current system (not all of which will be software
visible), how good all the connected consumer drivers are at providing
accurate information about what they're going to need from the system in
terms of quality of regulation and current draw and how good the board
design is in making these things reality.

For robustness (for some of these things if you get it wrong we're
talking catastrophic hardware failure) the Linux regulator API is
extremely conservative and won't touch the hardware unless explicitly
told that a specific thing is OK on a given board.
