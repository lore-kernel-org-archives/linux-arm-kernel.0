From: pebolle@tiscali.nl (Paul Bolle)
Date: Fri, 28 Feb 2014 22:43:09 +0100
Subject: [PATCH 14/28] Remove MACH_SMDKC210
In-Reply-To: <20140212160431.GB28112@sirena.org.uk>
References: <1391971686-9517-1-git-send-email-richard@nod.at>
 <1391971686-9517-15-git-send-email-richard@nod.at>
 <20140210114154.GQ1757@sirena.org.uk> <1392039072.3585.15.camel@x220>
 <20140210141255.GI1757@sirena.org.uk> <1392046242.3585.41.camel@x220>
 <20140210163621.GA13533@sirena.org.uk> <1392070159.27939.34.camel@x220>
 <20140212160431.GB28112@sirena.org.uk>
Message-ID: <1393623789.4052.17.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-02-12 at 16:04 +0000, Mark Brown wrote:
> On Mon, Feb 10, 2014 at 11:09:19PM +0100, Paul Bolle wrote:
> > See, if you scan v3.10:arch/arm/mach-exynos/mach-smdkv310.c you'll
> > notice the string "smdk-audio". If you grep that string you get a few
> > hits. But none in v3.10:sound/soc/samsung/smdk_wm9713.c. And if you scan
> > v3.10:sound/soc/samsung/smdk_wm9713.c for strings you'll find stuff like
> > "wm9713-hifi",  "wm9713-codec", and "soc-audio". But these don't show up
> > in v3.10:arch/arm/mach-exynos/mach-smdkv310.c. So it's not obvious how
> > these two files relate.
> 
> > And I'm left wondering why SND_SOC_SAMSUNG_SMDK_WM9713 actually depends
> > on (among other symbols) MACH_SMDKV310 and MACH_SMDKC210 in v3.10.
> 
> The hardware is physically present on those boards but must be selected
> with DIP switches, the device registration needs to be changed in the
> kernel when that happens (as the DT must be when it is in use).

In v3.14-rc4 these two symbols suddenly got removed, see commit
eaff64705dd5 ("ASoC: samsung: Remove invalid dependencies"). It does
exactly what I proposed last year, see
https://lkml.org/lkml/2013/7/14/27 . (That link currently shows a rather
empty page; is lkml.org having problems again?)

That commit is fine with me, of course. I now see no reason to continue
my, rather slowly progressing, search for the problem that you wanted to
get properly fixed. I suppose another commit already fixed it.

Thanks,


Paul Bolle
