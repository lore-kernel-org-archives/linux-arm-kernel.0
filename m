From: nicolas.dufresne@gmail.com (Nicolas Dufresne)
Date: Mon, 18 Apr 2016 13:48:17 -0400
Subject: [PATCH 3/7] [Media] vcodec: mediatek: Add Mediatek V4L2 Video
 Decoder Driver
In-Reply-To: <1460967754.7861.61.camel@mtksdaap41>
References: <1460548915-17536-1-git-send-email-tiffany.lin@mediatek.com>
 <1460548915-17536-2-git-send-email-tiffany.lin@mediatek.com>
 <1460548915-17536-3-git-send-email-tiffany.lin@mediatek.com>
 <1460548915-17536-4-git-send-email-tiffany.lin@mediatek.com>
 <5710FA3A.2030603@xs4all.nl> <1460958046.7861.48.camel@mtksdaap41>
 <57148D8E.9060601@xs4all.nl> <1460967754.7861.61.camel@mtksdaap41>
Message-ID: <1461001697.2719.7.camel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le lundi 18 avril 2016 ? 16:22 +0800, tiffany lin a ?crit?:
> > > We are plaining to remove m2m framework in th feature, although
> we think
> >?
> > Remove it for just the decoder driver or both encoder and decoder?
> >?
> Remove it from decoder driver.

Did you look at how CODA handle it (drivers/media/platform/coda/coda-
common.c) ? I don't know any detail, but they do have the same issue
and use both?v4l2_m2m_fop_poll and?v4l2_m2m_fop_mmap.

cheers,
Nicolas
