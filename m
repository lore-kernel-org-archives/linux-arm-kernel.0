From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 11 Mar 2017 18:51:37 +0000
Subject: [PATCH v5 15/39] [media] v4l2: add a frame interval error event
In-Reply-To: <5d5cf4a4-a4d3-586e-cd16-54f543dfcce9@gmail.com>
References: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
 <1489121599-23206-16-git-send-email-steve_longerbeam@mentor.com>
 <5b0a0e76-2524-4140-5ccc-380a8f949cfa@xs4all.nl>
 <ec05e6e0-79f2-2db2-bde9-4aed00d76faa@gmail.com>
 <6b574476-77df-0e25-a4d1-32d4fe0aec12@xs4all.nl>
 <5d5cf4a4-a4d3-586e-cd16-54f543dfcce9@gmail.com>
Message-ID: <20170311185137.GE21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 11, 2017 at 10:14:49AM -0800, Steve Longerbeam wrote:
> On 03/11/2017 03:39 AM, Hans Verkuil wrote:
> >It's fine to use an internal event as long as the end-user doesn't
> >see it. But if you lose vsyncs, then you never capture another frame,
> >right?
> 
> No, that's not correct. By loss of vertical sync, I mean the IPU
> captures portions of two different frames, resulting in a permanent
> "split image", with one frame containing portions of two consecutive
> images. Or, the video rolls continuously, if you remember the old CRT
> television sets of yore, it's the same rolling effect.

I have seen that rolling effect, but the iMX6 regains correct sync
within one complete "roll" just fine here with IMX219.  However, it
has always recovered.

So, I don't think there's a problem with the iMX6 part of the
processing, and so I don't think we should cripple the iMX6 capture
drivers for this problem.

It seems to me that the problem is with the source.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
