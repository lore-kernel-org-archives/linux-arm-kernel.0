From: broonie@kernel.org (Mark Brown)
Date: Tue, 14 Jan 2014 12:13:43 +0000
Subject: [PATCH 3/4] arm64: topology: Tell the scheduler about the
 relative power of cores
In-Reply-To: <20140114101236.GA28912@e102568-lin.cambridge.arm.com>
References: <1389554441-27335-1-git-send-email-broonie@kernel.org>
 <1389554441-27335-4-git-send-email-broonie@kernel.org>
 <20140113164021.GA6934@e102568-lin.cambridge.arm.com>
 <20140113170156.GC29039@sirena.org.uk>
 <20140114101236.GA28912@e102568-lin.cambridge.arm.com>
Message-ID: <20140114121343.GA15567@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 14, 2014 at 10:12:36AM +0000, Lorenzo Pieralisi wrote:
> On Mon, Jan 13, 2014 at 05:01:56PM +0000, Mark Brown wrote:

> > I would really have expected static data from a function marked init to
> > end up marked appropriately, but whatever.

> I would not expect that.

Really?  If something is local to a function marked init it seems like
the __init ought to carry over to it.

> > > > +		rate = of_get_property(cn, "clock-frequency", &len);

> > It's already standard in the spec we claim to be following...

> So is it required ?

That's what ePAPR says.  If that's good decision making on the part of
ePAPR or not is a separate question.

> I was just referring to this thread, whose outcome is unclear to me.

> http://archive.arm.linux.org.uk/lurker/message/20131206.115707.24b095f4.en.html

> I am not questioning why it is needed, I am just asking whether it is
> optional or not. If it is, getting error messages in the kernel log does not
> seem correct.

At present we don't really have a better way to get the information so
we're relying on it; until the scheduler is able to talk to cpufreq not
providing this information means we won't be able to provide a relative
performance estimate to the scheduler.  This means that we probably
ought to be telling the user if we couldn't figure out the top frequency
for the core.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140114/81b8c90d/attachment.sig>
