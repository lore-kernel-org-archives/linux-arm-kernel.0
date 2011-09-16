From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 16 Sep 2011 15:06:16 +0200
Subject: [PATCH 4/8] ispvideo: Add support for G/S/ENUM_STD ioctl
In-Reply-To: <ADF30F4D7BDE934D9B632CE7D5C7ACA4047C4D09083D@dbde03.ent.ti.com>
References: <1315488922-16152-1-git-send-email-deepthy.ravi@ti.com>
	<201109081921.28051.laurent.pinchart@ideasonboard.com>
	<ADF30F4D7BDE934D9B632CE7D5C7ACA4047C4D09083D@dbde03.ent.ti.com>
Message-ID: <201109161506.16505.laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Deepthy,

On Friday 16 September 2011 15:00:53 Ravi, Deepthy wrote:
> On Thursday, September 08, 2011 10:51 PM Laurent Pinchart wrote: 
> > On Thursday 08 September 2011 15:35:22 Deepthy Ravi wrote:
> >> From: Vaibhav Hiremath <hvaibhav@ti.com>
> >> 
> >> In order to support TVP5146 (for that matter any video decoder),
> >> it is important to support G/S/ENUM_STD ioctl on /dev/videoX
> >> device node.
> > 
> > Why so ? Shouldn't it be queried on the subdev output pad directly ?
> 
> Because standard v4l2 application for analog devices will call these std
> ioctls on the streaming device node. So it's done on /dev/video to make the
> existing apllication work.

Existing applications can't work with the OMAP3 ISP (and similar complex 
embedded devices) without userspace support anyway, either in the form of a 
GStreamer element or a libv4l plugin. I still believe that analog video 
standard operations should be added to the subdev pad operations and exposed 
through subdev device nodes, exactly as done with formats.

-- 
Regards,

Laurent Pinchart
