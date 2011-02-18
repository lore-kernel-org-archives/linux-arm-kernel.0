From: jammy.zhou@linaro.org (Jammy Zhou)
Date: Fri, 18 Feb 2011 10:19:58 +0800
Subject: [PATCH] i.MX23/28 framebuffer driver
In-Reply-To: <alpine.LFD.2.00.1102171545470.21278@casper.infradead.org>
References: <1297257651-8002-1-git-send-email-s.hauer@pengutronix.de>
	<201102091731.07794.arnd@arndb.de>
	<AANLkTikhcphz_8TS4L+z2heayqnJbK1NEW8DzqTm=YKp@mail.gmail.com>
	<201102161322.08126.arnd@arndb.de>
	<AANLkTik+ounqcTJ6rhiUqKPGkwcCOKGXdsVADs6zHfPU@mail.gmail.com>
	<AANLkTimMBLhopNq0L-NuJLdX08SrA078VF3tWf9TcEom@mail.gmail.com>
	<alpine.LFD.2.00.1102171545470.21278@casper.infradead.org>
Message-ID: <AANLkTimcwr4vpycSQCH9vMaB+umh+yHD_+WD2MJNqMOB@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To accommodate the fact of independent display controller and GPU components
in ARM SOC, it will be better if we can separate KMS from DRM both in kernel
space and user space (i.e, create a new drivers/video/kms directory for
kernel side, move KMS related code in libdrm to libkms in user space). Then
we can build xrandr1.2+ support based on KMS for ARM platforms, even if DRM
is still not supported. Besides, for buffer management part (GEM) in DRM, if
possible, we can also make it an independent module leaving DRM just a
wrapper, so that the GEM stuff can be used more flexibly.

Regards,
Jammy

On Fri, Feb 18, 2011 at 12:14 AM, James Simmons <jsimmons@infradead.org>wrote:

>
> > I'm still in the learning-as-I-go phase here, so definitely not ready
> > to propose a solution, but it does seem to me like there is room for
> > some sort of kms-helper library here to handle more of the boilerplate
> > xf86-video-* stuff..  I guess I'll have a better picture once I have a
> > chance to add support for the various multi-monitor configurations.
> > But certainly would be interested if anyone already has some ideas.
>
> I have been thinking about this as well. One of the short coming for DRM
> on embedded platforms is the lack of a small well defined library that one
> could use. Right now libkms only handles buffer allocation. The mode
> setting is currently tied to the libdrm library. It would be nice to
> seperate the two out more. Move the mode setting code to libkms and then
> have libdrm be a wrapper around this. This way libdrm can both support
> the legacy drm drivers and the new kms drivers at the same time. It also
> makes a clear seperation. Jakob if you are willing to take this work I
> will gladly seen you patches.
>
> _______________________________________________
> linaro-dev mailing list
> linaro-dev at lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-dev
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110218/312cbc88/attachment-0001.html>
