From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 15 Sep 2015 17:53:45 +0200
Subject: I.MX6 HDMI support in v4.2
In-Reply-To: <m3bnd52y4s.fsf@t19.piap.pl>
References: <m3bnde5whx.fsf@t19.piap.pl>
 <20150907112555.GS21084@n2100.arm.linux.org.uk>
 <m337yp5gvv.fsf@t19.piap.pl> <1441709778.13536.8.camel@pengutronix.de>
 <m3bnd52y4s.fsf@t19.piap.pl>
Message-ID: <1442332425.2637.16.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 14.09.2015, 10:39 +0200 schrieb Krzysztof Ha?asa:
> Another round of tests, I noticed the new git versions :-)
> Testing Linux v4.2 + PLL5 DTS patch (for HDMI output with enabled
> LVDS).
> Using mplayer with YUV420 (DRM Xvideo would probably work with packed
> UYVY-alike formats but I need YUV420 because H.264 decoder produces
> it).
> The driver is git://ftp.arm.linux.org.uk/~rmk/xf86-video-armada.git,
> branch unstable-devel, and it uses
> git://ftp.arm.linux.org.uk/~rmk/libdrm-armada.git/.
> 
> 	IMX DRM Xvideo output:
> 
> Only unscaled video: no color (luminance is good but the color
> components are green). The driver doesn't use color information.
> I hope this is easily fixable.
> 
There were patches for that some weeks ago already, I would hope they
got applied to some tree destinied for upstream. Will look at that and
ping people if necessary.

> 
> 	rmk/drm-etnaviv-devel:
> 
> With unscaled video, the only visible problem is tearing in the
> middle
> of the screen (unability to sync with screen refresh).
> 
> With scaling, I'm getting horizontal lines (mostly visible when the
> scene changes) and some sort of stalls - sometimes two frames are
> alternating for few seconds then it goes forward.
> 
> 
> 	pengutronix/etnaviv-for-upstream:
That is the right branch, containing the changes I sent out for review.

It includes a new kernel<->userspace interface, so needs a modified
xf86-video-armada to go with it. You can pick that up here:
git://git.pengutronix.de/git/lst/xf86-video-armada.git for-rmk

Caution: the armada code is WIP and needs further cleanups. It should
work though.

> No etnaviv Xvideo:
> (==) armada(0): Backing store enabled
> (==) armada(0): Silken mouse enabled
> (EE) armada(0): etnaviv: unable to open: Not a directory
> (WW) armada(0): [drm] Vivante initialization failed, running
> unaccelerated
> 
> I assume I need a newer something.
> 
> 
> 	pengutronix/v4.2/topic/etnaviv-for-rmk:

Please don't use that branch. It just there to keep stability for
people that already know about it.

Regards,
Lucas
