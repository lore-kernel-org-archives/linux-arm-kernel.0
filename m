From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 10 Sep 2015 11:49:30 +0100
Subject: I.MX6 HDMI support in v4.2
In-Reply-To: <m3a8su4llv.fsf@t19.piap.pl>
References: <m3bnde5whx.fsf@t19.piap.pl>
 <20150907112555.GS21084@n2100.arm.linux.org.uk>
 <m37fo25nrl.fsf@t19.piap.pl>
 <20150908091625.GV21084@n2100.arm.linux.org.uk>
 <m3y4gh41k4.fsf@t19.piap.pl>
 <20150908125756.GY21084@n2100.arm.linux.org.uk>
 <m3a8su4llv.fsf@t19.piap.pl>
Message-ID: <20150910104930.GI21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 10, 2015 at 12:25:32PM +0200, Krzysztof Ha?asa wrote:
> The Y plane is ok, but the Xv window is green, like on old monochrome
> CRTs - what could that be? It looks like the UV planes are all wrong.

>From a quick read of the imx-drm ipuv3-plane code, it looks like it
doesn't bother with the U/V planes for planar images.  Nothing looks
at fb->offsets[1,2] nor fb->pitches[1,2].  However, it claims to
support DRM_FORMAT_YUV420 and DRM_FORMAT_YVU420 formats - which is
wrong if it doesn't look at these other offsets and pitches.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
