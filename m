From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Oct 2011 09:44:21 +0100
Subject: [PATCH 1/2] [ARM] mach-types: Re-add apf9328
In-Reply-To: <20111013090609.GT577@pengutronix.de>
References: <1318087189-22977-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
	<20111008192621.GA28049@pengutronix.de>
	<20111008220722.GG25689@n2100.arm.linux.org.uk>
	<20111013090609.GT577@pengutronix.de>
Message-ID: <20111017084421.GD21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 13, 2011 at 11:06:09AM +0200, Uwe Kleine-K?nig wrote:
> On Sat, Oct 08, 2011 at 11:07:22PM +0100, Russell King - ARM Linux wrote:
> > On Sat, Oct 08, 2011 at 09:26:21PM +0200, Wolfram Sang wrote:
> > > On Sat, Oct 08, 2011 at 05:19:48PM +0200, Gwenhael Goavec-Merou wrote:
> > > > 
> > > > Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
> > > 
> > > I think this file is maintained by Russell, yet I want to ack that the entry
> > > below is missing for building mx1_defconfig. Found that, too.
> > 
> > The thing is - read the comments at the top of the file.  There's hints
> > there as to what will happen if you patch the file.  The hint is
> > 'automatically generated'.  So when I next update the file, any patches
> > done to the file will be wiped out.
> Currently the id is still missing in your for-next branch and it is
> marked as "mainlined" on http://www.arm.linux.org.uk/developer/machines/
> (906).
> 
> That means that the next update should include the id, right? Maybe it's
> worth to add it already earlier with the patch Gwenhael proposed as
> without it mx1_defconfig is broken. After f32609c5a035 it even breaks
> imx_v4_v5_defconfig.
> 
> BTW is there a way to see the mach-types file as it would land in
> linux.git if it were updated now?

http://www.arm.linux.org.uk/developer/machines/download.php?q=1

will be the exact file if I were to update it right now (that's the
URL it's retrieved from.)

One of the problems we now have is that I no longer have visibility
of platforms going into mainline (I only find out after they've been
merged into mainline), so I've no way to update the database with
that information before I do an update - my information will be up
to three months out of date.  This in turn means that the 12 month
grace period can expire and the entries deleted from the merged file
_after_ they've been merged and queued up elsewhere.

As I've already said, this has now become one very big unmanagable
problem.  It needs someone to spend a lot of time at each update
manually verifying every addition and removal (and kicking those
people who botch their entries up - which given my interpretation of
the data protection act means it can only be me).

I haven't committed an update since August, and at this point in the
cycle, I'm not going to before this merge window - the risks of breaking
something already merged or queued up are just too great to consider
doing so now.

Longer term, I don't have an answer to this problem - I don't think
there is a workable answer to a distributed development model with
a centralized ID database with a grace period on 'unused' entries.
