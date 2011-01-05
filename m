From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Jan 2011 15:34:57 +0000
Subject: still nfs problems [Was: Linux 2.6.37-rc8]
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB5930248201279@dbde02.ent.ti.com>
References: <20101230171453.GA5787@pengutronix.de>
	<1293731992.4919.5.camel@heimdal.trondhjem.org>
	<20101230191846.GB14221@pengutronix.de>
	<20110103213850.GC25121@pengutronix.de>
	<1294100558.25100.8.camel@heimdal.trondhjem.org>
	<20110105084014.GN25121@pengutronix.de>
	<20110105110517.GQ25121@pengutronix.de>
	<20110105112701.GA8638@n2100.arm.linux.org.uk>
	<4D246098.50908@pengutronix.de>
	<B85A65D85D7EB246BE421B3FB0FBB5930248201279@dbde02.ent.ti.com>
Message-ID: <20110105153457.GB8638@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 05, 2011 at 06:32:58PM +0530, Nori, Sekhar wrote:
> Here are some logs:
> 
> fileid changed fsid 0:c: expected fileid 0x2db61d, got 0x2dad20
> 
> fileid changed fsid 0:c: expected fileid 0x100000000000, got 0x7070000000000000

Just to be clear, what I was seeing was things like:

expected fileid <32-bit number> got <64-bit number with same 32-bit LS bits>

so it looked like something was truncating a 64-bit fileid down
to 32-bits.
