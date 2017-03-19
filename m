From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sun, 19 Mar 2017 09:55:58 +0000
Subject: [PATCH v5 00/39] i.MX Media Driver
In-Reply-To: <1489884074.21659.7.camel@ndufresne.ca>
References: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
 <20170318192258.GL21222@n2100.armlinux.org.uk>
 <aef6c412-5464-726b-42f6-a24b7323aa9c@mentor.com>
 <20170318204324.GM21222@n2100.armlinux.org.uk>
 <1489884074.21659.7.camel@ndufresne.ca>
Message-ID: <20170319095558.GP21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 18, 2017 at 08:41:14PM -0400, Nicolas Dufresne wrote:
> Along with the norm fallback, GStreamer could could also consider the
> currently set framerate as returned by?VIDIOC_G_PARM. At the same time,
> implementing that enumeration shall be straightforward, and will make a
> large amount of existing userspace work.

Since, according to v4l2-compliance, providing the enumeration ioctls
appears to be optional:

1) should v4l2-compliance be checking whether other frame sizes/frame
   intervals are possible, and failing if the enumeration ioctls are
   not supported?

2) would it also make sense to allow gstreamer's v4l2src to try setting
   a these parameters, and only fail if it's unable to set it?  IOW, if
   I use:

gst-launch-1.0 v4l2src device=/dev/video10 ! \
	video/x-bayer,format=RGGB,framerate=20/1 ! ...

   where G_PARM says its currently configured for 25fps, but a S_PARM
   with 20fps would actually succeed.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
