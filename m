From: slash.tmp@free.fr (Mason)
Date: Tue, 21 Apr 2015 00:43:03 +0200
Subject: Standard/common method for booting secondary cores
Message-ID: <553580F7.7040903@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

With the current push for CONFIG_ARCH_MULTIPLATFORM,
I'm wondering if things like starting secondary cores
have been "standardized"/factorized to the point where
I can just use some default implementation?

I think the implementation I'm using as a starting
point uses SMC calls. I think we are using "TrustZone"
where Linux runs in NS (non secure) mode, and a tiny
proprietary OS runs in secure mode.

IIUC (which is probably NOT the case), when Linux runs
in NS mode, some operations that are typically carried
out at boot/init are not allowed, such as

- starting secondary cores
- configuring the L2 cache controller

and this must be done by the secure OS via SMC?

I'd be happy to be given pointers to internet references
and do my own reading. I've bookmarked a few on related
subjects:

http://events.linuxfoundation.org/sites/events/files/slides/clement-smp-bring-up-on-arm-soc.pdf
http://www.linux-arm.org/pub/LinuxPlatform/RealViewLink/Booting_ARM_Linux_SMP_on_MPCore.doc
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0388g/Beihjjgb.html
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.prd29-genc-009492c/index.html

Are the arch/arm/common/mcpm_* files relevant?

Regards.
