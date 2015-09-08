From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Tue, 08 Sep 2015 16:59:13 +0200
Subject: I.MX6 HDMI support in v4.2
In-Reply-To: <20150908125756.GY21084@n2100.arm.linux.org.uk> (Russell King's
 message of "Tue, 8 Sep 2015 13:57:56 +0100")
References: <m3bnde5whx.fsf@t19.piap.pl>
 <20150907112555.GS21084@n2100.arm.linux.org.uk>
 <m37fo25nrl.fsf@t19.piap.pl>
 <20150908091625.GV21084@n2100.arm.linux.org.uk>
 <m3y4gh41k4.fsf@t19.piap.pl>
 <20150908125756.GY21084@n2100.arm.linux.org.uk>
Message-ID: <m3lhch3qke.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> Note that most (all?) video requires some scaling.  A 720x576 video on
> square pixels needs to be scaled to 768x576, but at "modern" aspect
> ratio of 16:9, it needs to be scaled horizontally to 1024x576.

Sure. What I meant was the very application I'm currently working on
is, at least at the moment, ok with unscaled video (because it's all
1920x1080p).

> They're probably not the tearing - tearing is where you scan out part of
> the old frame and part of the new frame, which appears as a particularly
> noticable effect on scenes with a lot of change.

Right, basically a set of two "halves", moving slowly up or down.
This is BTW what can be observed on unsynchronized displays (e.g. on
multi-display machine usually only one display can be synchronized with
a video stream).

> Horizontal lines which are significantly different (eg, short black lines)
> will be CPU cache corruption - both the main etnaviv DRM and Lucas' "fixed"
> cache handling suffer from this.  My patch set doesn't.
>
>  git://ftp.arm.linux.org.uk/~rmk/linux-arm.git drm-etnaviv-devel
>
> contains my code.

Great, will switch to it tomorrow.
Thanks again.
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
