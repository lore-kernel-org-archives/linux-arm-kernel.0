From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Wed, 11 Jul 2012 12:17:52 +0200
Subject: [PATCH 1/2] media: Add mem2mem deinterlacing driver.
In-Reply-To: <CACKLOr1xgjuGp-jshCaCBZwG4pbWsBSt9Cq9jUdd3PGjpHiXEQ@mail.gmail.com>
References: <1341996904-22893-1-git-send-email-javier.martin@vista-silicon.com>
 <201207111145.51858.hverkuil@xs4all.nl>
 <CACKLOr1xgjuGp-jshCaCBZwG4pbWsBSt9Cq9jUdd3PGjpHiXEQ@mail.gmail.com>
Message-ID: <201207111217.52973.hverkuil@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 11 July 2012 12:02:48 javier Martin wrote:
> Hi Hans,
> thank you for your comments.
> 
> On 11 July 2012 11:45, Hans Verkuil <hverkuil@xs4all.nl> wrote:
> > Hi Javier!
> >
> > Thanks for the patch.
> >
> > On Wed 11 July 2012 10:55:03 Javier Martin wrote:
> >> Some video decoders such as tvp5150 provide separate
> >> video fields (V4L2_FIELD_SEQ_TB). This driver uses
> >> dmaengine to convert this format to V4L2_FIELD_INTERLACED_TB
> >> (weaving) or V4L2_FIELD_NONE (line doubling)
> >
> > Which field is used for the line doubling? Top or bottom? Or is each field
> > doubled, thus doubling the framerate?
> 
> No, just top field is used.
> I don't know if it's worth defining a new field format for doubling fields.

Probably not, but just make sure it is clearly documented.

> > I also recommend adding SEQ_BT/INTERLACED_BT support: NTSC transmits the bottom
> > field first, so it is useful to have support for that.
> 
> Adding that is quite easy but I cannot test it.
> Maybe someone could add it later?

It shouldn't be too hard to test: make the top field red and the bottom field blue
and check if the resulting image is correct.

Regards,

	Hans
