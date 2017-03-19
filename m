From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sun, 19 Mar 2017 14:22:40 +0000
Subject: [PATCH v5 00/39] i.MX Media Driver
In-Reply-To: <20170319142110.GT21222@n2100.armlinux.org.uk>
References: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
 <20170318192258.GL21222@n2100.armlinux.org.uk>
 <aef6c412-5464-726b-42f6-a24b7323aa9c@mentor.com>
 <20170318204324.GM21222@n2100.armlinux.org.uk>
 <4e7f91fa-e1c4-1cbc-2542-2aaf19a35329@mentor.com>
 <20170319142110.GT21222@n2100.armlinux.org.uk>
Message-ID: <20170319142240.GA23922@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 19, 2017 at 02:21:10PM +0000, Russell King - ARM Linux wrote:
> There's a good reason why I dumped a full debug log using GST_DEBUG=*:9,
> analysed it for the cause of the failure, and tried several different
> pipelines, including the standard bayer2rgb plugin.
> 
> Please don't blame this on random stuff after analysis of the logs _and_
> reading the appropriate plugin code has shown where the problem is.  I
> know gstreamer can be very complex, but it's very possible to analyse
> the cause of problems and pin them down with detailed logs in conjunction
> with the source code.

Oh, and the proof of correct analysis is that fixing the kernel capture
driver to enumerate the frame sizes and intervals fixes the issue, even
with bayer2rgbneon being used.

Therefore, there is _no way_ what so ever that it could be caused by that
plugin.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
