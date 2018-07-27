From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri, 27 Jul 2018 16:03:44 +0200
Subject: [PATCH 9/9] media: cedrus: Add H264 decoding support
In-Reply-To: <CAGb2v67k_bwATPiaRVifR0gnAaG56VztpW9WifOExQbLqm2Csg@mail.gmail.com>
References: <20180613140714.1686-1-maxime.ripard@bootlin.com>
 <20180613140714.1686-10-maxime.ripard@bootlin.com>
 <8c0b2fbec0302a15292d3629570ab1268fd306b8.camel@bootlin.com>
 <CAGb2v67k_bwATPiaRVifR0gnAaG56VztpW9WifOExQbLqm2Csg@mail.gmail.com>
Message-ID: <ec974f9dbf73dede2b82f81faafa68b04c7aec61.camel@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

On Fri, 2018-07-27 at 22:01 +0800, Chen-Yu Tsai wrote:
> On Fri, Jul 27, 2018 at 9:56 PM, Paul Kocialkowski
> <paul.kocialkowski@bootlin.com> wrote:
> > Hi,
> > 
> > On Wed, 2018-06-13 at 16:07 +0200, Maxime Ripard wrote:
> > > Introduce some basic H264 decoding support in cedrus. So far, only the
> > > baseline profile videos have been tested, and some more advanced features
> > > used in higher profiles are not even implemented.
> > 
> > Here are two specific comments about things I noticed when going through
> > the h264 code.
> > 
> > [...]
> > 
> > > @@ -88,12 +101,37 @@ struct sunxi_cedrus_ctx {
> > >       struct work_struct run_work;
> > >       struct list_head src_list;
> > >       struct list_head dst_list;
> > > +
> > > +     union {
> > > +             struct {
> > > +                     void            *mv_col_buf;
> > > +                     dma_addr_t      mv_col_buf_dma;
> > > +                     ssize_t         mv_col_buf_size;
> > > +                     void            *neighbor_info_buf;
> > > +                     dma_addr_t      neighbor_info_buf_dma;
> > 
> > Should be "neighbour" instead of "neighbor" and the same applies to most
> > variables related to this, as well as the register description.
> 
> This just means you've been hanging out with people who use American
> English. :)

Oh wow, I honestly thought this was a typo. My mistake then!

Thanks for the heads-up!

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180727/88ea9303/attachment.sig>
