From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 6 May 2013 16:36:53 -0600
Subject: [RESEND][PATCH 1/3] arm: dts: introduce config HAS_BANDGAP
In-Reply-To: <20130506213413.GH5634@blackmetal.musicnaut.iki.fi>
References: <1367874058-2378-1-git-send-email-eduardo.valentin@ti.com>
 <1367874058-2378-2-git-send-email-eduardo.valentin@ti.com>
 <20130506213413.GH5634@blackmetal.musicnaut.iki.fi>
Message-ID: <20130506223653.GA12089@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 07, 2013 at 12:34:13AM +0300, Aaro Koskinen wrote:
> On Mon, May 06, 2013 at 05:00:56PM -0400, Eduardo Valentin wrote:
> > Introduce HAS_BANDGAP config entry. This config is a
> > boolean value so that arch code can flag is they
> > feature a bandgap device.
> 
> Maybe it could be mentioned that omap-thermal already depend on this?
> At least for a random reviewer it was not immediately clear why this is
> added, especially since there were no users for it in subsequent patches.

I looked (very briefly), and it seemed like omap-thermal is self
contained and doesn't need arch support?

I get the impression it is desired to minimize driver kconfig
dependencies to the minimum required to compile to increase build
testing coverage, so maybe it would be appropriate to drop this
entirely?

Jason
