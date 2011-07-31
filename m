From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 30 Jul 2011 22:02:15 -0600
Subject: [PATCH 1/2] arm/mx5: parse iomuxc pad configuratoin from device
	tree
In-Reply-To: <20110726024354.GI21641@S2100-06.ap.freescale.net>
References: <1311606467-28985-1-git-send-email-shawn.guo@linaro.org>
	<1311606467-28985-2-git-send-email-shawn.guo@linaro.org>
	<20110725204630.GD26735@ponder.secretlab.ca>
	<20110726024354.GI21641@S2100-06.ap.freescale.net>
Message-ID: <20110731040215.GJ24334@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26, 2011 at 10:43:55AM +0800, Shawn Guo wrote:
> On Mon, Jul 25, 2011 at 02:46:30PM -0600, Grant Likely wrote:
> > On Mon, Jul 25, 2011 at 11:07:46PM +0800, Shawn Guo wrote:
> > The current linux code has each pin config simply a u64.  Now, an
> > engineer certainly wouldn't be asked to write raw u64 values, but we
> > could add some form of #define or macro syntax to dtc so that the
> > symbolic names currently used in the board.c file would continue to
> > work.
> 
> I was told that the binding should not be bonded to Linux
> implementation.  Now I'm told to go the opposite direction? ;)

Nope; it's perfectly valid to use the current Linux implementation for
inspiration, since a real implementation can be proven to actually
/work/.  :-)  However, the binding must be documented from the
perspective of how the hardware works, not from the perspective of
what Linux currently wants.

g.
