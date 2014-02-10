From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 10 Feb 2014 23:09:19 +0100
Subject: [PATCH 14/28] Remove MACH_SMDKC210
In-Reply-To: <20140210163621.GA13533@sirena.org.uk>
References: <1391971686-9517-1-git-send-email-richard@nod.at>
 <1391971686-9517-15-git-send-email-richard@nod.at>
 <20140210114154.GQ1757@sirena.org.uk> <1392039072.3585.15.camel@x220>
 <20140210141255.GI1757@sirena.org.uk> <1392046242.3585.41.camel@x220>
 <20140210163621.GA13533@sirena.org.uk>
Message-ID: <1392070159.27939.34.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-02-10 at 16:36 +0000, Mark Brown wrote:
> On Mon, Feb 10, 2014 at 04:30:42PM +0100, Paul Bolle wrote:
> > So, next step: the Kconfig symbols MACH_SMDKV310 and MACH_SMDKC210 were
> > removed in commit 383ffda2fa ("ARM: EXYNOS: no more support non-DT for
> > EXYNOS SoCs"). That commit was part of v3.11. Correct?
> 
> Indeed, so we can see that these platforms were converted to use DT and
> the symbols were removed as a result.  This means that a good fix here
> is to ensure that the driver can be used with DT platforms.

One of the problems I face is that I find it hard to understand how this
stuff works in v3.10 (ie, before MACH_SMDKV310 and MACH_SMDKC210 were
dropped).

See, if you scan v3.10:arch/arm/mach-exynos/mach-smdkv310.c you'll
notice the string "smdk-audio". If you grep that string you get a few
hits. But none in v3.10:sound/soc/samsung/smdk_wm9713.c. And if you scan
v3.10:sound/soc/samsung/smdk_wm9713.c for strings you'll find stuff like
"wm9713-hifi",  "wm9713-codec", and "soc-audio". But these don't show up
in v3.10:arch/arm/mach-exynos/mach-smdkv310.c. So it's not obvious how
these two files relate.

And I'm left wondering why SND_SOC_SAMSUNG_SMDK_WM9713 actually depends
on (among other symbols) MACH_SMDKV310 and MACH_SMDKC210 in v3.10.


Paul Bolle
