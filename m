From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Mon, 19 Sep 2011 21:01:02 +0530
Subject: [PATCH 4/8] ispvideo: Add support for G/S/ENUM_STD ioctl
In-Reply-To: <201109161506.16505.laurent.pinchart@ideasonboard.com>
References: <1315488922-16152-1-git-send-email-deepthy.ravi@ti.com>
	<201109081921.28051.laurent.pinchart@ideasonboard.com>
	<ADF30F4D7BDE934D9B632CE7D5C7ACA4047C4D09083D@dbde03.ent.ti.com>
	<201109161506.16505.laurent.pinchart@ideasonboard.com>
Message-ID: <19F8576C6E063C45BE387C64729E739404EC8113E2@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Laurent Pinchart [mailto:laurent.pinchart at ideasonboard.com]
> Sent: Friday, September 16, 2011 6:36 PM
> To: Ravi, Deepthy
> Cc: linux-media at vger.kernel.org; tony at atomide.com; linux at arm.linux.org.uk;
> linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; mchehab at infradead.org; g.liakhovetski at gmx.de;
> Hiremath, Vaibhav
> Subject: Re: [PATCH 4/8] ispvideo: Add support for G/S/ENUM_STD ioctl
> 
> Hi Deepthy,
> 
> On Friday 16 September 2011 15:00:53 Ravi, Deepthy wrote:
> > On Thursday, September 08, 2011 10:51 PM Laurent Pinchart wrote:
> > > On Thursday 08 September 2011 15:35:22 Deepthy Ravi wrote:
> > >> From: Vaibhav Hiremath <hvaibhav@ti.com>
> > >>
> > >> In order to support TVP5146 (for that matter any video decoder),
> > >> it is important to support G/S/ENUM_STD ioctl on /dev/videoX
> > >> device node.
> > >
> > > Why so ? Shouldn't it be queried on the subdev output pad directly ?
> >
> > Because standard v4l2 application for analog devices will call these std
> > ioctls on the streaming device node. So it's done on /dev/video to make
> the
> > existing apllication work.
> 
> Existing applications can't work with the OMAP3 ISP (and similar complex
> embedded devices) without userspace support anyway, either in the form of
> a
> GStreamer element or a libv4l plugin. I still believe that analog video
> standard operations should be added to the subdev pad operations and
> exposed
> through subdev device nodes, exactly as done with formats.
> 
[Hiremath, Vaibhav] Laurent,

I completely agree with your point that, existing application will not work without setting links properly. But I believe the assumption here is, media-controller should set the links (along with pad formants) and all existing application should work as is. Isn't it?

The way it is being done currently is, set the format at the pad level which is same as analog standard resolution and use existing application for streaming...

I am ok, if we add s/g/enum_std api support at sub-dev level but this should also be supported on streaming device node.

Thanks,
Vaibhav

> --
> Regards,
> 
> Laurent Pinchart
