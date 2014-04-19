From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 19 Apr 2014 09:42:29 +0100
Subject: [PATCH v2] staging: imx-drm-core: skip components whose parent
 device is disabled
In-Reply-To: <20140419055205.GX2523@dragon>
References: <1397440946-2303-1-git-send-email-shawn.guo@freescale.com>
 <20140418204249.GG24070@n2100.arm.linux.org.uk>
 <20140419055205.GX2523@dragon>
Message-ID: <20140419084229.GK24070@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 19, 2014 at 01:53:08PM +0800, Shawn Guo wrote:
> BTW, can you take a look at the following two patches, or are they
> already in your queue?
> 
> imx-drm: imx-drm-core: Fix imx_drm_encoder_get_mux_id
> https://lkml.org/lkml/2014/4/7/58

This one now is.

> mx-drm: imx-tve: correct DDC property name to 'ddc-i2c-bus'
> ('i' is missing from the prefix word, and it should be 'imx-drm')
> http://www.spinics.net/lists/arm-kernel/msg321057.html

This one touches arch/arm/boot/dts, which Arnd moaned at me for touching
via the staging tree during the merge window.  So, while I can take the
imx-tve part, I can't take the arch/arm/boot/dts part.  This patch needs
to be split.

It also means that the MBA platform will have its TVE output broken while
the two commits take their different paths, but I guess that's what you
get for this kind of sillyness about git trees having exclusive ownership
of various files in the kernel tree - more breakage not less.

There's one which I posted yesterday which I think should be merged along
with these - imx-drm: fix hdmi hotplug detection initial state

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
