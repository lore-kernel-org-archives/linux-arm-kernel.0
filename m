From: ben@decadent.org.uk (Ben Hutchings)
Date: Sun, 28 Nov 2010 15:11:16 +0000
Subject: [PATCH] econet: Move to staging; remove from defconfig
In-Reply-To: <20101127.223845.189711153.davem@davemloft.net>
References: <20101128002135.GA4562@suse.de>
	<20101127.172644.226781076.davem@davemloft.net>
	<1290909215.3292.230.camel@localhost>
	<20101127.223845.189711153.davem@davemloft.net>
Message-ID: <1290957076.3292.277.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2010-11-27 at 22:38 -0800, David Miller wrote:
> From: Ben Hutchings <ben@decadent.org.uk>
> Date: Sun, 28 Nov 2010 01:53:35 +0000
> 
> > On Sat, 2010-11-27 at 17:26 -0800, David Miller wrote:
> >> From: Greg KH <gregkh@suse.de>
> >> Date: Sat, 27 Nov 2010 16:21:35 -0800
> >> 
> >> > And I need an ack from the networking maintainer to be able to accept
> >> > this also.
> >> 
> >> I'm not applying this, nor do I want anyone else to.
> >> 
> >> If people think this protocol is not maintained adequately
> >> right now, wait until you push it into staging.
> >> 
> >> Furthermore, once Phil Blundell was made aware of security
> >> holes in econet he fixed them within a few days.  Which is
> >> much better than I can say for some of the other protocols
> >> and filesystems in the tree.
> > 
> > Those bugs were present for years and would have been obvious to anyone
> > who cared to read the code.  While I very much appreciate Phil's quick
> > response, I don't think this reactive maintenance is enough.
> 
> These same arguments could for be made for RDS.  Look at all the
> hellacious awful obvious crap we've discovered in that code recently.
> A simple read would have caught those too, and I don't see it's
> maintainer doing such things.

Indeed, hence the change I made for the upcoming Debian release was:

  * af_802154,decnet,econet,rds,x25: Disable auto-loading as mitigation
    against local exploits.  These protocol modules are not widely used
    and can be explicitly loaded or aliased on systems where they are
    wanted.

(While decnet may be in better shape than the others, auto-loading is
unnecessary for us as the userland support package explicitly loads
it..)

> So, you're very much still not convincing Ben, but feel free to keep
> trying.

I'm not going to try any more.

Ben.

-- 
Ben Hutchings
Once a job is fouled up, anything done to improve it makes it worse.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 828 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101128/ecd46179/attachment.sig>
