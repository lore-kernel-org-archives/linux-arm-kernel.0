From: broonie@kernel.org (Mark Brown)
Date: Mon, 6 Apr 2015 16:01:27 +0100
Subject: LDP: next-20150402: twl4030 regression?
In-Reply-To: <20150406135829.GH4027@n2100.arm.linux.org.uk>
References: <5522886D.5050409@ti.com> <20150406134541.GE6023@sirena.org.uk>
 <55228FE0.2040702@ti.com>
 <20150406135829.GH4027@n2100.arm.linux.org.uk>
Message-ID: <20150406150127.GF6023@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 06, 2015 at 02:58:29PM +0100, Russell King - ARM Linux wrote:
> On Mon, Apr 06, 2015 at 08:53:36AM -0500, Nishanth Menon wrote:

> > > at least a description of the problem you're seeing and some attempt at

> > Test was a simple boot test. There seems to be a lockdep reported at the
> > very least in the log provided (see
> > https://github.com/nmenon/kernel-test-logs/blob/next-20150402/omap2plus_defconfig/ldp.txt#L488
> > ).

> I think what Mark is trying to say is to include a fuller description of
> the problem, and don't expect people to fire up their web browser to get
> a basic overview of what the problem is.

Yes, indeed.  I hadn't actually opened the links, I might've got round
to it later on.

> My guess is that the problem _appears_ to be that someone's added a call
> to debug_check_no_locks_held() into schedule_hrtimeout_range_clock()
> without considering what this means.

> What it means is that you can't now use usleep_range() from within any
> driver probe function - which is absolutely absurd.

I can't think of any regulator side changes which might be relevant in
that period.  It's possible that there might be something in the MFD I
guess.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150406/12c26bd7/attachment.sig>
