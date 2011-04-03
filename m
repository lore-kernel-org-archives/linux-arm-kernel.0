From: shawn.guo@freescale.com (Shawn Guo)
Date: Sun, 3 Apr 2011 11:06:29 +0800
Subject: [PATCH] arm/dt: Add a make rule to build dtb for enabled platform
In-Reply-To: <4D9747E4.3050902@gmail.com>
References: <1301740783-23147-1-git-send-email-shawn.guo@linaro.org>
	<4D9747E4.3050902@gmail.com>
Message-ID: <20110403030628.GA27332@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 02, 2011 at 10:59:32AM -0500, Rob Herring wrote:
> Shawn,
> 
Hi Rob,

> On 04/02/2011 05:39 AM, Shawn Guo wrote:
> >It's based on commit fe8e6d0b0e601ca0a63fe768d4b812d5a45a9da7
> >"arm/dt: Add dtb make rule" from Rob Herring.
> >
> >With 'make ARCH=arm dtb', it builds Device Tree Blobs for those
> >platforms enabled by CONFIG.
> >
> >Signed-off-by: Shawn Guo<shawn.guo@linaro.org>
> >---
> >This patch works against Linaro kernel tree.  But it needs to go
> >through mainline review before it gets applied.
> >
> >  arch/arm/Makefile      |    3 +++
> >  arch/arm/boot/Makefile |   14 ++++++++++++++
> >  2 files changed, 17 insertions(+), 0 deletions(-)
> >
> >diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> >index d51ab6c..7fd2af9 100644
> >--- a/arch/arm/Makefile
> >+++ b/arch/arm/Makefile
> >@@ -292,6 +292,9 @@ zinstall uinstall install: vmlinux
> >  %.dtb:
> >  	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/$@
> >
> >+dtb:
> >+	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/$@
> >+
> >  # We use MRPROPER_FILES and CLEAN_FILES now
> >  archclean:
> >  	$(Q)$(MAKE) $(clean)=$(boot)
> >diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
> >index 08fc37f..dcea984 100644
> >--- a/arch/arm/boot/Makefile
> >+++ b/arch/arm/boot/Makefile
> >@@ -63,6 +63,20 @@ endif
> >  $(obj)/%.dtb: $(src)/dts/%.dts
> >  	$(call cmd,dtc)
> >
> >+dtb-$(CONFIG_MACH_HARMONY) += tegra-harmony.dtb
> >+dtb-$(CONFIG_MACH_MX51_BABBAGE) += mx51-babbage.dtb
> >+dtb-$(CONFIG_MACH_MX51_EFIKAMX) += genesi-efikamx.dtb
> >+dtb-$(CONFIG_MACH_MX51_EFIKASB) += genesi-efikasb.dtb
> >+dtb-$(CONFIG_MACH_MX53_LOCO) += mx53-loco.dtb
> >+dtb-$(CONFIG_MACH_OMAP3_BEAGLE) += omap3-beagle.dtb
> >+dtb-$(CONFIG_MACH_OMAP4_PANDA) += omap4-panda.dtb
> >+dtb-$(CONFIG_MACH_OVERO) += omap3-overo.dtb
> >+dtb-$(CONFIG_MACH_SMDKV310) += exynos4-smdkv310.dtb
> >+dtb-$(CONFIG_ARCH_VERSATILE_PB) += versatile-pb.dtb
> >+dtb-$(CONFIG_MACH_VERSATILE_AB) += versatile-ab.dtb
> 
> And now this file has to be touched for every platform added.
> Perhaps this can pick-up the dts name from Makefile.boot. Although
> Makefile.boot could possibly be removed on some platforms.
> 
I was following the way that powerpc does similar thing.  But yes,
your suggestion looks saner in terms of keeping arch/arm/boot/Makefile
clean.  I would incorporate it in v2.

Thanks for the comment.

-- 
Regards,
Shawn
