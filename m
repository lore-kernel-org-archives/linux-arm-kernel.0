From: pebolle@tiscali.nl (Paul Bolle)
Date: Sun, 14 Jul 2013 15:18:16 +0200
Subject: [PATCH] ARM: EXYNOS: remove references to non-DT SoCs
In-Reply-To: <20130714124538.GA11538@sirena.org.uk>
References: <1373804812.1370.23.camel@x61.thuisdomein>
 <20130714124538.GA11538@sirena.org.uk>
Message-ID: <1373807896.1370.43.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2013-07-14 at 13:45 +0100, Mark Brown wrote:
> Look at the code you are editing here:
> 
> > -       depends on SND_SOC_SAMSUNG && (MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDKV210 || MACH_SMDKC110 || MACH_SMDKV310 || MACH_SMDKC210)
> > +       depends on SND_SOC_SAMSUNG && (MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDKV210 || MACH_SMDKC110)
> 
> Simply removing the dependencies is not going to give the clearly
> intended effect here.  The dependency on the DT only machine needs to be
> replaced with something, not just deleted, otherwise the driver can't be
> enabled in Kconfig.

I interpreted commit 383ffda2fa as a commit that just removed a lot of
stuff: see its commit explanation and its diffstat (it adds one line and
deletes over 900 lines). Moreover, after that commit the references to
MACH_SMDKV310 and MACH_SMDKC210 both are nops. Deleting them can't
possibly change anything.

But, anyhow, what would be the symbols to use here?

> Also let me again remind you to submit patches with subject lines that
> are appropriate for the subsystem you're updating.  I very nearly
> deleted this unread since it looks like a patch for arch/arm with no
> relationship with audio but in fact it doesn't touch arch/arm at all.

I do try to use subject lines that are used in the sections I touch. I
seem to remember that you asked me _once_, I think one or two years ago,
to adjust to the system used for SoC. Since then you've received a
number of patches from me that, as far as I can remember, always used
that system.

Besides, this patch was intended as a follow up to commit 383ffda2fa, to
clean up two references it apparently forgot to remove, and therefor
basically copied the subject line used in that commit.


Paul Bolle
