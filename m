From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 31 Oct 2013 15:06:45 +0100
Subject: [Patch v2][ 04/37] [media] v4l2: add new V4L2_PIX_FMT_RGB666
 pixel format.
In-Reply-To: <20131031111806.72b6856b@samsung.com>
References: <1382022155-21954-1-git-send-email-denis@eukrea.com>
 <1382022155-21954-5-git-send-email-denis@eukrea.com>
 <20131031111806.72b6856b@samsung.com>
Message-ID: <27124564.ioQJs5F4eu@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 31 October 2013 11:18:06 Mauro Carvalho Chehab wrote:
> Em Thu, 17 Oct 2013 17:02:02 +0200
> 
> Denis Carikli <denis@eukrea.com> escreveu:
> > That new macro is needed by the imx_drm staging driver
> > 
> >   for supporting the QVGA display of the eukrea-cpuimx51 board.
> > 
> > Cc: Rob Herring <rob.herring@calxeda.com>
> > Cc: Pawel Moll <pawel.moll@arm.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Stephen Warren <swarren@wwwdotorg.org>
> > Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> > Cc: devicetree at vger.kernel.org
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: driverdev-devel at linuxdriverproject.org
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: dri-devel at lists.freedesktop.org
> > Cc: Mauro Carvalho Chehab <m.chehab@samsung.com>
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: linux-media at vger.kernel.org
> > Cc: Sascha Hauer <kernel@pengutronix.de>
> > Cc: linux-arm-kernel at lists.infradead.org
> > Cc: Eric B?nard <eric@eukrea.com>
> > Signed-off-by: Denis Carikli <denis@eukrea.com>
> 
> It seems better to apply this one together with the other DRM patches via
> DRM tree. So:
> 	Acked-by: Mauro Carvalho Chehab <m.chehab@samsung.com>

Actually, if I might, I'd like to nak this patch, as adding new pixel formats 
requires updating the documentation as well (see 
Documentation/DocBook/media/v4l/pixfmt*.xml).

> > ---
> > 
> >  include/uapi/linux/videodev2.h |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/include/uapi/linux/videodev2.h
> > b/include/uapi/linux/videodev2.h index 437f1b0..e8ff410 100644
> > --- a/include/uapi/linux/videodev2.h
> > +++ b/include/uapi/linux/videodev2.h
> > @@ -294,6 +294,7 @@ struct v4l2_pix_format {
> > 
> >  #define V4L2_PIX_FMT_RGB555X v4l2_fourcc('R', 'G', 'B', 'Q') /* 16 
> >  RGB-5-5-5 BE  */ #define V4L2_PIX_FMT_RGB565X v4l2_fourcc('R', 'G', 'B',
> >  'R') /* 16  RGB-5-6-5 BE  */ #define V4L2_PIX_FMT_BGR666 
> >  v4l2_fourcc('B', 'G', 'R', 'H') /* 18  BGR-6-6-6	  */> 
> > +#define V4L2_PIX_FMT_RGB666  v4l2_fourcc('R', 'G', 'B', 'H') /* 18 
> > RGB-6-6-6	  */> 
> >  #define V4L2_PIX_FMT_BGR24   v4l2_fourcc('B', 'G', 'R', '3') /* 24 
> >  BGR-8-8-8     */ #define V4L2_PIX_FMT_RGB24   v4l2_fourcc('R', 'G', 'B',
> >  '3') /* 24  RGB-8-8-8     */ #define V4L2_PIX_FMT_BGR32  
> >  v4l2_fourcc('B', 'G', 'R', '4') /* 32  BGR-8-8-8-8   */
-- 
Regards,

Laurent Pinchart
