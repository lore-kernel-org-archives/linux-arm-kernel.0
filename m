From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 25 Aug 2015 16:57:52 +0100
Subject: [PATCH v3 06/14] Documentation: drm/bridge: add document for
 analogix_dp
In-Reply-To: <20150825142150.GB3820@ulmo.nvidia.com>
References: <1439995728-18046-1-git-send-email-ykk@rock-chips.com>
 <1439995834-18363-1-git-send-email-ykk@rock-chips.com>
 <20150825095817.GC14034@ulmo.nvidia.com>
 <55DC75C8.209@rock-chips.com>
 <20150825142150.GB3820@ulmo.nvidia.com>
Message-ID: <20150825155752.GU7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 25, 2015 at 04:21:51PM +0200, Thierry Reding wrote:
> You cited code from dw_hdmi.c earlier, it looks like it might be correct
> even though it doesn't cite a reference for why this was done. Perhaps
> someone on this thread, or someone involved with dw_hdmi can answer
> where that code came from.

dw_hdmi doesn't do any format conversion - it's hard coded to RGB, 8
bits per colour component.  That's a requirement for all HDMI sinks.

The reason it's hard-coded in dw_hdmi is that (a) no one has yet decided
its worth the effort to get the dw_hdmi hardware to do the colourspace
conversion to the YUV spaces and verify that it works, and (b) I really
don't see the point when we're talking about computer like devices which
work primerily with RGB and RGB is always supported by the sink.

As far as greater colour depths go, the driver came from the Freescale
iMX6 code base, and the hardware which feeds dw_hdmi can't do more than
8 bits per component - so going to 10, 12 or 16 bits per component is
beyond what iMX6 can cope with.  Hence, no one on the iMX6 side has a
need for the deep colour stuff.

In any case, I view this as a very low priority issue - it would be nice
to have audio support on HDMI for iMX6 at some point in the next 20 years,
preferably before the hardware becomes obsolete.  I've been maintaining
patches for this for 1.5 years now... how much longer is it going to take?
My pull request to David from 15th July was ignored.  My re-send of that
after he returned was ignored.  My reminder of it has been ignored.  What's
going on in DRM land?  It would be nice to get _some_ kind of feedback so
I know why they're not being taken, so I can fix whatever the issue is.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
