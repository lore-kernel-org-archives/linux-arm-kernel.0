From: broonie@kernel.org (Mark Brown)
Date: Mon, 11 May 2015 16:58:26 +0100
Subject: [alsa-devel] [PATCH 12/13] drm: bridge/dw_hdmi-ahb-audio: add
 audio driver
In-Reply-To: <20150510193320.GZ2067@n2100.arm.linux.org.uk>
References: <20150509102501.GO2067@n2100.arm.linux.org.uk>
 <E1Yr1y8-0006lG-Mw@rmk-PC.arm.linux.org.uk>
 <554E3AA8.8060601@iki.fi>
 <20150509165536.GS2067@n2100.arm.linux.org.uk>
 <554E3EE1.40904@iki.fi>
 <20150509174054.GT2067@n2100.arm.linux.org.uk>
 <554E49FE.8040004@iki.fi>
 <20150509181153.GV2067@n2100.arm.linux.org.uk>
 <554FAA9E.100@iki.fi>
 <20150510193320.GZ2067@n2100.arm.linux.org.uk>
Message-ID: <20150511155826.GI3458@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 10, 2015 at 08:33:20PM +0100, Russell King - ARM Linux wrote:

> My personal view is that where we're dealing with PCM audio, the driver
> needs to set these bits correctly as there is nothing in userspace to
> do this.  This provides an identical interface between each audio device
> which accepts PCM samples - whether it's a SPDIF or non-SPDIF based
> device.

> For non-audio data sent via an audio device, the AES bits need to be
> conveyed from userspace, and we should respect what userspace gives us.
> (If it's wrong, it's a userspace bug, and userspace should be fixed,
> rather than trying to work around the bug by patching the kernel.)

For what it's worth this is exactly what I'd be expecting to happen -
the kernel should do something by default and then let applications
override it if they so desire.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150511/a5b4d220/attachment.sig>
