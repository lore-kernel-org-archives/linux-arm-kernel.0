From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 20 Mar 2017 14:15:41 +0100
Subject: [PATCH v5 00/39] i.MX Media Driver
In-Reply-To: <aef6c412-5464-726b-42f6-a24b7323aa9c@mentor.com>
References: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
 <20170318192258.GL21222@n2100.armlinux.org.uk>
 <aef6c412-5464-726b-42f6-a24b7323aa9c@mentor.com>
Message-ID: <1490015741.2917.66.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2017-03-18 at 12:58 -0700, Steve Longerbeam wrote:
> 
> On 03/18/2017 12:22 PM, Russell King - ARM Linux wrote:
> > Hi Steve,
> >
> > I've just been trying to get gstreamer to capture and h264 encode
> > video from my camera at various frame rates, and what I've discovered
> > does not look good.
> >
> > 1) when setting frame rates, media-ctl _always_ calls
> >     VIDIOC_SUBDEV_S_FRAME_INTERVAL with pad=0.

To allow setting pad > 0:
https://patchwork.linuxtv.org/patch/39348/

> > 2) media-ctl never retrieves the frame interval information, so there's
> >     no way to read it back with standard tools, and no indication that
> >     this is going on...
> 
> I think Philipp Zabel submitted a patch which addresses these
> in media-ctl. Check with him.

To read back and propagate the frame interval:
https://patchwork.linuxtv.org/patch/39349/
https://patchwork.linuxtv.org/patch/39351/

regards
Philipp
