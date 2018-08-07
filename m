From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Tue, 07 Aug 2018 09:19:54 +0200
Subject: [PATCH v6 4/8] media: platform: Add Cedrus VPU decoder driver
In-Reply-To: <CAAFQd5DgFDFupACthsz1iLpAeYRtUtEfzQC1E5XZQ6gPZAYi1Q@mail.gmail.com>
References: <20180725100256.22833-1-paul.kocialkowski@bootlin.com>
 <20180725100256.22833-5-paul.kocialkowski@bootlin.com>
 <b45a8a89-1313-7a08-206d-b93017724754@xs4all.nl>
 <dba0f9496b393c76f355398018b14ae06b2b18c9.camel@bootlin.com>
 <CAAFQd5DgFDFupACthsz1iLpAeYRtUtEfzQC1E5XZQ6gPZAYi1Q@mail.gmail.com>
Message-ID: <94e3eaf26ed7d6859d74abad0a0dbc94a3308a2e.camel@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, 2018-08-06 at 23:10 +0900, Tomasz Figa wrote:
> Hi Paul,
> 
> On Mon, Aug 6, 2018 at 10:50 PM Paul Kocialkowski
> <paul.kocialkowski@bootlin.com> wrote:
> > 
> > Hi Hans and thanks for the review!
> > 
> > On Sat, 2018-08-04 at 14:18 +0200, Hans Verkuil wrote:
> > > Hi Paul,
> > > 
> > > See below for my review comments. Mostly small fry, the main issue I found is
> > > that there is no support for VIDIOC_DECODER_CMD. That's the proper way of
> > > stopping a decoder. Don't rely on the deprecated allow_zero_bytesused field.
> > 
> > Mhh, it looks like this was kept around by negligence, but we do expect
> > that streamoff stops the decoder, not a zero bytesused field.
> > 
> > Is it still required to implement the V4L2_DEC_CMD_STOP
> > VIDIOC_DECODER_CMD in that case? I read in the doc that this ioctl
> > should be optional.
> 
> If I understand correctly that this decoder is stateless, there should
> be no need for any special flush sequence, since a 1:1 relation
> between OUTPUT and CAPTURE buffers is expected, which means that
> userspace can just stop queuing new OUTPUT buffers and keep dequeuing
> CAPTURE buffers until it matches all OUTPUT buffers queued before.

This is indeed a stateless decoder and I don't have any particular need
for a particular stop command indeed, since flushing remaining buffers
when stopping is already implemented at streamoff time.

> By the way, I guess we will also need some documentation for the
> stateless codec interface. Do you or Maxime (who sent the H264 part)
> have any plans to work on it? We have some internal documents, which
> should be convertible to rst using pandoc, but we might need some help
> with updating to latest request API and further editing. Alexandre
> (moved from Cc to To) is going to be looking into this.

As far as I'm concerned, I am interested in contributing to this
documentation although our priorities for the Allwinner VPU effort are
currently focused on H265 support. This might mean that my contributions
to this documentation will be made on a best-effort basis (as opposed to
during the workday). Either way, if someone was to come up with an
initial draft, I'd be happy to review it!

Cheers,

Paul

-- 
Paul Kocialkowski, Bootlin (formerly Free Electrons)
Embedded Linux and kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180807/ac09ff0b/attachment-0001.sig>
