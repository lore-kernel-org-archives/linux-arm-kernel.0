From: mchehab@s-opensource.com (Mauro Carvalho Chehab)
Date: Fri, 21 Oct 2016 11:08:09 -0200
Subject: [PATCH v5 3/9] vcodec: mediatek: Add Mediatek V4L2 Video
 Decoder Driver
In-Reply-To: <20161021110104.5733240e@vento.lan>
References: <1472818800-22558-1-git-send-email-tiffany.lin@mediatek.com>
 <1472818800-22558-2-git-send-email-tiffany.lin@mediatek.com>
 <1472818800-22558-3-git-send-email-tiffany.lin@mediatek.com>
 <1472818800-22558-4-git-send-email-tiffany.lin@mediatek.com>
 <20161021110104.5733240e@vento.lan>
Message-ID: <20161021110809.269fd70d@vento.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Fri, 21 Oct 2016 11:01:04 -0200
Mauro Carvalho Chehab <mchehab@osg.samsung.com> escreveu:

> Em Fri, 2 Sep 2016 20:19:54 +0800
> Tiffany Lin <tiffany.lin@mediatek.com> escreveu:
> 
> > Add v4l2 layer decoder driver for MT8173
> > 
> > Signed-off-by: Tiffany Lin <tiffany.lin@mediatek.com>  
> 
> > +int vdec_if_init(struct mtk_vcodec_ctx *ctx, unsigned int fourcc)
> > +{
> > +	int ret = 0;
> > +
> > +	switch (fourcc) {
> > +	case V4L2_PIX_FMT_H264:
> > +	case V4L2_PIX_FMT_VP8:
> > +	default:
> > +		return -EINVAL;
> > +	}  
> 
> Did you ever test this driver? The above code will *always* return
> -EINVAL, with will cause vidioc_vdec_s_fmt() to always fail!
> 
> I suspect that what you wanted to do, instead, is:
> 
> 	switch (fourcc) {
> 	case V4L2_PIX_FMT_H264:
> 	case V4L2_PIX_FMT_VP8:
> 		break;
> 	default:
> 		return -EINVAL;

Yeah, a latter patch in this series added a break there.

Thanks,
Mauro
