From: joshc@ni.com (Josh Cartwright)
Date: Mon, 4 Apr 2016 18:29:26 -0500
Subject: [PATCH RESEND] ARM: l2x0: add three special L210 aux control flags
In-Reply-To: <CACRpkdZeAKkU4Cr6TTQor_6zw2iVGgXmTdcsQuHuR07Q8yZHiQ@mail.gmail.com>
References: <1458043882-16881-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdZeAKkU4Cr6TTQor_6zw2iVGgXmTdcsQuHuR07Q8yZHiQ@mail.gmail.com>
Message-ID: <20160404232926.GV28102@jcartwri.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 03, 2016 at 06:22:44PM +0200, Linus Walleij wrote:
> On Tue, Mar 15, 2016 at 1:11 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> > This adds support for setting the flag bits "wrap access disable",
> > "write allocate override" and "exclusive abort disable" to the L210
> > variant from the device tree.
> >
> > The "write allocate override" bit was used on the Nomadik and
> > necessary to properly make use of the L210 cache on that machine
> > without sporadic crashes.
> >
> > I took this oppportunity to add all three flags so we avoid excess
> > patching for each one.
> >
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Pawel Moll <pawel.moll@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> > Cc: Kumar Gala <galak@codeaurora.org>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: devicetree at vger.kernel.org
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Russell, this patch is in the patch tracker with Rob's ACK from
> the DT side, do you think you could apply it?

Similarly, we're waiting on feedback for:

  http://lkml.kernel.org/r/1456761716-10174-1-git-send-email-brad.mouring at ni.com

Also in the queue; also w/ Rob's Ack.  There was a change awhile back to
unconditionally enable the power-management features of the PL310 which
caused a noticeable performance degradation on our boards; placing the
PM options behind a togglable DT property provides us an out.

  Josh

PS. Sorry for the threadjack, but it seemed similar enough.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160404/3f2a0f30/attachment-0001.sig>
