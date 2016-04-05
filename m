From: joshc@ni.com (Josh Cartwright)
Date: Tue, 5 Apr 2016 07:35:02 -0500
Subject: [PATCH RESEND] ARM: l2x0: add three special L210 aux control flags
In-Reply-To: <20160404233640.GW19428@n2100.arm.linux.org.uk>
References: <1458043882-16881-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdZeAKkU4Cr6TTQor_6zw2iVGgXmTdcsQuHuR07Q8yZHiQ@mail.gmail.com>
 <20160404232926.GV28102@jcartwri.amer.corp.natinst.com>
 <20160404233640.GW19428@n2100.arm.linux.org.uk>
Message-ID: <20160405123502.GA18394@jcartwri.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 05, 2016 at 12:36:40AM +0100, Russell King - ARM Linux wrote:
> On Mon, Apr 04, 2016 at 06:29:26PM -0500, Josh Cartwright wrote:
> > Similarly, we're waiting on feedback for:
> > 
> >   http://lkml.kernel.org/r/1456761716-10174-1-git-send-email-brad.mouring at ni.com
> > 
> > Also in the queue; also w/ Rob's Ack.  There was a change awhile back to
> > unconditionally enable the power-management features of the PL310 which
> > caused a noticeable performance degradation on our boards; placing the
> > PM options behind a togglable DT property provides us an out.
> 
> For that one, I've been wondering why it's seemingly acceptable to
> start throwing *errors* for *new* DT properties which weren't required
> before.

Yes, this doesn't sound appropriate and should be revisited.

> Also, there's no DT documentation for the new properties, which is a
> fundamental requirement - and Rob should not have given his ack
> without there being a DT documentation patch.

Yeah, I partly mispoke here.  The patch I linked to is the first of a
two part series, the DT bindings document is the second patch, which had
Rob's ack (not the one I linked).

However, it looks like what made it into your patch tracker was a
squashed version of both patches, which is probably not appropriate.
It's probably best we drop what's in the patch queue, and we can get a
new rev sent out addressing your concerns.

Thanks,
  Josh
