From: broonie@kernel.org (Mark Brown)
Date: Sun, 14 Jul 2013 13:45:38 +0100
Subject: [PATCH] ARM: EXYNOS: remove references to non-DT SoCs
In-Reply-To: <1373804812.1370.23.camel@x61.thuisdomein>
References: <1373804812.1370.23.camel@x61.thuisdomein>
Message-ID: <20130714124538.GA11538@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 14, 2013 at 02:26:52PM +0200, Paul Bolle wrote:
> Commit 383ffda2fa ("ARM: EXYNOS: no more support non-DT for EXYNOS
> SoCs") removed the Kconfig symbols MACH_SMDKV310 and MACH_SMDKC210.
> Now remove the references to both of these symbols from the Kconfig
> entry for SND_SOC_SAMSUNG_SMDK_WM9713. They're not needed anymore.

Look at the code you are editing here:

> -       depends on SND_SOC_SAMSUNG && (MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDKV210 || MACH_SMDKC110 || MACH_SMDKV310 || MACH_SMDKC210)
> +       depends on SND_SOC_SAMSUNG && (MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDKV210 || MACH_SMDKC110)

Simply removing the dependencies is not going to give the clearly
intended effect here.  The dependency on the DT only machine needs to be
replaced with something, not just deleted, otherwise the driver can't be
enabled in Kconfig.

Also let me again remind you to submit patches with subject lines that
are appropriate for the subsystem you're updating.  I very nearly
deleted this unread since it looks like a patch for arch/arm with no
relationship with audio but in fact it doesn't touch arch/arm at all.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130714/5cfbc8a3/attachment.sig>
