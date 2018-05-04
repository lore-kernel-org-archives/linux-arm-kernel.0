From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri, 04 May 2018 09:58:41 +0200
Subject: [PATCH v2 06/10] media: v4l: Add definition for Allwinner's
 MB32-tiled NV12 format
In-Reply-To: <198e991c-1052-5bfb-f397-0e7d388b3c00@xs4all.nl>
References: <20180419154124.17512-1-paul.kocialkowski@bootlin.com>
 <20180419154536.17846-2-paul.kocialkowski@bootlin.com>
 <198e991c-1052-5bfb-f397-0e7d388b3c00@xs4all.nl>
Message-ID: <18af23e5efe2cdef5ed4b51c6dbf1ddeef8ffd5f.camel@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, 2018-04-20 at 15:59 +0200, Hans Verkuil wrote:
> On 04/19/18 17:45, Paul Kocialkowski wrote:
> > This introduces support for Allwinner's MB32-tiled NV12 format,
> > where
> > each plane is divided into macroblocks of 32x32 pixels. Hence, the
> > size
> > of each plane has to be aligned to 32 bytes. The pixels inside each
> > macroblock are coded as they would be if the macroblock was a single
> > plane, line after line.
> > 
> > The MB32-tiled NV12 format is used by the video engine on Allwinner
> > platforms: it is the default format for decoded frames (and the only
> > one
> > available in the oldest supported platforms).
> > 
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  include/uapi/linux/videodev2.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/include/uapi/linux/videodev2.h
> > b/include/uapi/linux/videodev2.h
> > index 4b8336f7bcf0..43993a116e2b 100644
> > --- a/include/uapi/linux/videodev2.h
> > +++ b/include/uapi/linux/videodev2.h
> > @@ -669,6 +669,7 @@ struct v4l2_pix_format {
> >  #define V4L2_PIX_FMT_Z16      v4l2_fourcc('Z', '1', '6', ' ') /*
> > Depth data 16-bit */
> >  #define V4L2_PIX_FMT_MT21C    v4l2_fourcc('M', 'T', '2', '1') /*
> > Mediatek compressed block mode  */
> >  #define V4L2_PIX_FMT_INZI     v4l2_fourcc('I', 'N', 'Z', 'I') /*
> > Intel Planar Greyscale 10-bit and Depth 16-bit */
> > +#define V4L2_PIX_FMT_MB32_NV12 v4l2_fourcc('M', 'N', '1', '2') /*
> > Allwinner NV12 in 32x32 macroblocks */
> >  
> >  /* 10bit raw bayer packed, 32 bytes for every 25 pixels, last LSB 6
> > bits unused */
> >  #define V4L2_PIX_FMT_IPU3_SBGGR10	v4l2_fourcc('i', 'p', '3',
> > 'b') /* IPU3 packed 10-bit BGGR bayer */
> > 
> 
> Add an entry for this to v4l_fill_fmtdesc() in v4l2-ioctl.c.
> 
> It also needs to be documented in the spec.

Noted, I will look in that direction for the future versions.

Cheers,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180504/89c68886/attachment-0001.sig>
