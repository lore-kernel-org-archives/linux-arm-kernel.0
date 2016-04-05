From: brad.mouring@ni.com (Brad Mouring)
Date: Tue, 5 Apr 2016 09:05:15 -0500
Subject: [PATCH RESEND] ARM: l2x0: add three special L210 aux control flags
In-Reply-To: <20160405131254.GB18394@jcartwri.amer.corp.natinst.com>
References: <1458043882-16881-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdZeAKkU4Cr6TTQor_6zw2iVGgXmTdcsQuHuR07Q8yZHiQ@mail.gmail.com>
 <20160404232926.GV28102@jcartwri.amer.corp.natinst.com>
 <20160404233640.GW19428@n2100.arm.linux.org.uk>
 <20160405080827.GA19428@n2100.arm.linux.org.uk>
 <20160405131254.GB18394@jcartwri.amer.corp.natinst.com>
Message-ID: <20160405140515.GA20317@zardoz.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 05, 2016 at 08:12:54AM -0500, Josh Cartwright wrote:
> On Tue, Apr 05, 2016 at 09:08:27AM +0100, Russell King - ARM Linux wrote:
> > On Tue, Apr 05, 2016 at 12:36:40AM +0100, Russell King - ARM Linux wrote:
> > > On Mon, Apr 04, 2016 at 06:29:26PM -0500, Josh Cartwright wrote:
> > > > Similarly, we're waiting on feedback for:
> > > > 
> > > >   http://lkml.kernel.org/r/1456761716-10174-1-git-send-email-brad.mouring at ni.com
> > > > 
> > > > Also in the queue; also w/ Rob's Ack.  There was a change awhile back to
> > > > unconditionally enable the power-management features of the PL310 which
> > > > caused a noticeable performance degradation on our boards; placing the
> > > > PM options behind a togglable DT property provides us an out.
> > > 
> > > For that one, I've been wondering why it's seemingly acceptable to
> > > start throwing *errors* for *new* DT properties which weren't required
> > > before.  Also, there's no DT documentation for the new properties,
> > > which is a fundamental requirement - and Rob should not have given
> > > his ack without there being a DT documentation patch.

2/2 Is the documentation. The patch that sits in the queue is the combination
of those two, including the documentation since the help of the patch queue
recommends submitting a single feature as a single patch

Queued patch: http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8549/1

> > > Obviously, the kernel review process has broken on this one... or
> > > I must remember this sneaky trick for getting new DT properties in
> > > without the required documentation...
> > 
> > There's another issue here - we go from enabling these options by
> > default to leaving them as the firmware specified them.  While that's
> > something I approve of, I'm not happy because it means all platforms
> > that have these PM bits enabled today could end up losing them - so
> > it's a PM regression waiting to happen.  Who's going to add them to
> > all the dt blobs where platforms _can_ cope with having these PM bits
> > enabled?
> 
> Viewing the pending patch as causing a PM regression is one way to look
> at it, however another way to look at is is that the commit which
> unconditionally enabled the PM features caused a performance regression;
> in particular commit 3a43b581dac1 ("ARM: l2c: always enable low power
> modes") which landed in v3.16.  (Perhaps, though, the distinction isn't
> important, as it doesn't necessarily help dictate a course of action.)

I initially wrote the patch maintaining the "on-by-default" behavior. So
many of the other DT-controlled features, however, take the approach of
defaulting to the firmware's configuration, it seems odd and out-of-place
to suddenly impose a default setting.

Of course, I am open to feedback, and thanks for giving this some attention
Russell.

Brad
