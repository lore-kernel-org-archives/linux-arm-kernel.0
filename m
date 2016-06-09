From: sre@kernel.org (Sebastian Reichel)
Date: Thu, 9 Jun 2016 09:57:34 +0200
Subject: [PATCH] ARM: OMAP2: Enable Errata 430973 for OMAP3
In-Reply-To: <20160609071512.GK22406@atomide.com>
References: <1463700017-18527-1-git-send-email-nm@ti.com>
 <20160609071512.GK22406@atomide.com>
Message-ID: <20160609075734.GA8595@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jun 09, 2016 at 12:15:13AM -0700, Tony Lindgren wrote:
> * Nishanth Menon <nm@ti.com> [160519 16:23]:
> > Enable Erratum 430973 similar to commit 5c86c5339c56 ("ARM:
> > omap2plus_defconfig: Enable ARM erratum 430973 for omap3") - Since
> > multiple defconfigs can exist from various points of view (multi_v7,
> > omap2plus etc.. it is always better to enable the erratum from the
> > Kconfig selection point of view so that downstream kernels dont have
> > to rediscover this all over again.
> 
> This should safe to select now. Note that proc-v7.S still does not
> do anything with multiarch to configure it. So the bootloader still
> needs to enable it, or it needs to be done in the machine init like
> n900 does.

mh I totally forgot about 430973. I still think [0] is the
better solution. IIRC I never uploaded them to Russel's
patchsystem, though :(

[0] http://comments.gmane.org/gmane.linux.kernel/2002603

> So applying into omap-for-v4.7/fixes as it can solve some mysterious
> app crashers with armhf at least.

Only on N900 though:

$ git grep ARM_ERRATA_430973
arch/arm/Kconfig:config ARM_ERRATA_430973
arch/arm/configs/axm55xx_defconfig:CONFIG_ARM_ERRATA_430973=y
arch/arm/configs/omap2plus_defconfig:CONFIG_ARM_ERRATA_430973=y
arch/arm/mach-omap2/board-rx51.c:#ifdef CONFIG_ARM_ERRATA_430973
arch/arm/mach-omap2/pdata-quirks.c: if (IS_ENABLED(CONFIG_ARM_ERRATA_430973)) {
arch/arm/mm/proc-v7.S:#if defined(CONFIG_ARM_ERRATA_430973) && !defined(CONFIG_ARCH_MULTIPLATFORM)

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160609/7c3e20bf/attachment.sig>
