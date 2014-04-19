From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 19 Apr 2014 19:00:49 +0800
Subject: [PATCH v2] staging: imx-drm-core: skip components whose parent
 device is disabled
In-Reply-To: <20140419084229.GK24070@n2100.arm.linux.org.uk>
References: <1397440946-2303-1-git-send-email-shawn.guo@freescale.com>
 <20140418204249.GG24070@n2100.arm.linux.org.uk>
 <20140419055205.GX2523@dragon>
 <20140419084229.GK24070@n2100.arm.linux.org.uk>
Message-ID: <20140419110048.GY2523@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 19, 2014 at 09:42:29AM +0100, Russell King - ARM Linux wrote:
> On Sat, Apr 19, 2014 at 01:53:08PM +0800, Shawn Guo wrote:
> > BTW, can you take a look at the following two patches, or are they
> > already in your queue?
> > 
> > imx-drm: imx-drm-core: Fix imx_drm_encoder_get_mux_id
> > https://lkml.org/lkml/2014/4/7/58
> 
> This one now is.
> 
> > mx-drm: imx-tve: correct DDC property name to 'ddc-i2c-bus'
> > ('i' is missing from the prefix word, and it should be 'imx-drm')
> > http://www.spinics.net/lists/arm-kernel/msg321057.html
> 
> This one touches arch/arm/boot/dts, which Arnd moaned at me for touching
> via the staging tree during the merge window.  So, while I can take the
> imx-tve part, I can't take the arch/arm/boot/dts part.  This patch needs
> to be split.
> 
> It also means that the MBA platform will have its TVE output broken while
> the two commits take their different paths, but I guess that's what you
> get for this kind of sillyness about git trees having exclusive ownership
> of various files in the kernel tree - more breakage not less.

I think Arnd's main concern is about merge conflict, which shouldn't be
a problem for this particular case.  The change on dts file is pretty
trivial.  And I assume this is a fix to be landed on mainline before
-rc5 or so.  Then I can rebase my DT branch on top of it.  That said,
merge conflict is not really a problem for this patch.  Arnd?

Shawn

> 
> There's one which I posted yesterday which I think should be merged along
> with these - imx-drm: fix hdmi hotplug detection initial state
> 
> -- 
> FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
> improving, and getting towards what was expected from it.
> 
> 
