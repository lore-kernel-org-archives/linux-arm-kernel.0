From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 10 Mar 2015 16:55:56 +0200
Subject: [PATCH] video: treat signal like timeout as failure
In-Reply-To: <20150310144640.GM8656@n2100.arm.linux.org.uk>
References: <1421731430-13207-1-git-send-email-der.herr@hofr.at>
 <54FEE70D.3010307@ti.com> <20150310125116.GA26020@opentech.at>
 <20150310141511.GL8656@n2100.arm.linux.org.uk>
 <20150310143928.GA19501@opentech.at>
 <20150310144640.GM8656@n2100.arm.linux.org.uk>
Message-ID: <54FF05FC.5030704@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/03/15 16:46, Russell King - ARM Linux wrote:

> In which case, let me propose that the exynos fbdev driver needs to be
> moved to drivers/staging, and stay there until this stuff gets fixed.
> drivers/staging is supposed to be for stuff which isn't up to the mark,
> and which is potentially unstable.  And that's what this driver exactly
> is.

There is drivers/gpu/drm/exynos/ which is getting a lot of updates. So...

I'd propose removing the exynos fbdev driver if the exynos drm driver
offers the same functionality. I don't know if that's the case. Does the
drm driver support all the devices the fbdev supports?

Also, I'm not sure if and how we can remove drivers. If exynos fbdev
driver is dropped, that would perhaps break boards that have exynos
fbdev in their .dts file. And if the drm driver doesn't offer the exact
same /dev/fbX interface, it would break the userspace.

So I don't know if that's possible. But that's what I'd like to do,
eventually, for all the fbdev drivers. Implement drm driver, remove the
fbdev one.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150310/d88fe89e/attachment.sig>
