From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 22 Aug 2018 11:15:57 +0200
Subject: [PATCH 1/9] CHROMIUM: v4l: Add H264 low-level decoder API
 compound controls.
In-Reply-To: <80e1d9cb49c6df06843e49332685f2b401023292.camel@collabora.com>
References: <20180613140714.1686-1-maxime.ripard@bootlin.com>
 <20180613140714.1686-2-maxime.ripard@bootlin.com>
 <80e1d9cb49c6df06843e49332685f2b401023292.camel@collabora.com>
Message-ID: <20180822091557.gtnlgoebyv6yttzf@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Aug 21, 2018 at 01:58:38PM -0300, Ezequiel Garcia wrote:
> On Wed, 2018-06-13 at 16:07 +0200, Maxime Ripard wrote:
> > From: Pawel Osciak <posciak@chromium.org>
> > 
> > Signed-off-by: Pawel Osciak <posciak@chromium.org>
> > Reviewed-by: Wu-cheng Li <wuchengli@chromium.org>
> > Tested-by: Tomasz Figa <tfiga@chromium.org>
> > [rebase44(groeck): include linux/types.h in v4l2-controls.h]
> > Signed-off-by: Guenter Roeck <groeck@chromium.org>
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > ---
> > 
> [..]
> > diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> > index 242a6bfa1440..4b4a1b25a0db 100644
> > --- a/include/uapi/linux/videodev2.h
> > +++ b/include/uapi/linux/videodev2.h
> > @@ -626,6 +626,7 @@ struct v4l2_pix_format {
> >  #define V4L2_PIX_FMT_H264     v4l2_fourcc('H', '2', '6', '4') /* H264 with start codes */
> >  #define V4L2_PIX_FMT_H264_NO_SC v4l2_fourcc('A', 'V', 'C', '1') /* H264 without start codes */
> >  #define V4L2_PIX_FMT_H264_MVC v4l2_fourcc('M', '2', '6', '4') /* H264 MVC */
> > +#define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H264 parsed slices */
> 
> As pointed out by Tomasz, the Rockchip VPU driver expects start codes [1], so the userspace
> should be aware of it. Perhaps we could document this pixel format better as:
> 
> #define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H264 parsed slices with start codes */

I'm not sure this is something we want to do at that point. libva
doesn't give the start code, so this is only going to make the life of
the sane controllers more difficult. And if you need to have the start
code and parse it, then you're not so stateless anymore.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180822/07de23d0/attachment.sig>
