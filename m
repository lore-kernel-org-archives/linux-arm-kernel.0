From: yong.deng@magewell.com (Yong)
Date: Fri, 22 Dec 2017 18:55:47 +0800
Subject: [linux-sunxi] [PATCH v4 2/2] media: V3s: Add support for
 Allwinner CSI.
In-Reply-To: <20171222102156.cfemen6ouxxxbrem@plaes.org>
References: <1513936020-35569-1-git-send-email-yong.deng@magewell.com>
 <20171222102156.cfemen6ouxxxbrem@plaes.org>
Message-ID: <20171222185547.356dbc3ebe76d0ebec88d052@magewell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, 22 Dec 2017 10:21:56 +0000
Priit Laes <plaes@plaes.org> wrote:

> On Fri, Dec 22, 2017 at 05:47:00PM +0800, Yong Deng wrote:
> > Allwinner V3s SoC have two CSI module. CSI0 is used for MIPI interface
> > and CSI1 is used for parallel interface. This is not documented in
> > datasheet but by testing and guess.
> > 
> > This patch implement a v4l2 framework driver for it.

...

> > +	if ((sdev->csi.v4l2_ep.bus_type == V4L2_MBUS_PARALLEL
> > +	      || sdev->csi.v4l2_ep.bus_type == V4L2_MBUS_BT656)
> > +	     && sdev->csi.v4l2_ep.bus.parallel.bus_width == 16) {
> > +		switch (pixformat) {
> > +		case V4L2_PIX_FMT_HM12:
> > +		case V4L2_PIX_FMT_NV12:
> > +		case V4L2_PIX_FMT_NV21:
> > +		case V4L2_PIX_FMT_NV16:
> > +		case V4L2_PIX_FMT_NV61:
> > +		case V4L2_PIX_FMT_YUV420:
> > +		case V4L2_PIX_FMT_YVU420:
> > +		case V4L2_PIX_FMT_YUV422P:
> > +			switch (mbus_code) {
> > +			case MEDIA_BUS_FMT_UYVY8_1X16:
> > +			case MEDIA_BUS_FMT_VYUY8_1X16:
> > +			case MEDIA_BUS_FMT_YUYV8_1X16:
> > +			case MEDIA_BUS_FMT_YVYU8_1X16:
> > +				return true;
> > +			}
> > +			break;
> > +		}
> Should we add default cases and warning messages here for debug purposes?

OK. I will add all the default cases and messages.

Thanks,
Yong
