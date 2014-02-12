From: broonie@kernel.org (Mark Brown)
Date: Wed, 12 Feb 2014 16:04:31 +0000
Subject: [PATCH 14/28] Remove MACH_SMDKC210
In-Reply-To: <1392070159.27939.34.camel@x220>
References: <1391971686-9517-1-git-send-email-richard@nod.at>
 <1391971686-9517-15-git-send-email-richard@nod.at>
 <20140210114154.GQ1757@sirena.org.uk>
 <1392039072.3585.15.camel@x220>
 <20140210141255.GI1757@sirena.org.uk>
 <1392046242.3585.41.camel@x220>
 <20140210163621.GA13533@sirena.org.uk>
 <1392070159.27939.34.camel@x220>
Message-ID: <20140212160431.GB28112@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 11:09:19PM +0100, Paul Bolle wrote:

> See, if you scan v3.10:arch/arm/mach-exynos/mach-smdkv310.c you'll
> notice the string "smdk-audio". If you grep that string you get a few
> hits. But none in v3.10:sound/soc/samsung/smdk_wm9713.c. And if you scan
> v3.10:sound/soc/samsung/smdk_wm9713.c for strings you'll find stuff like
> "wm9713-hifi",  "wm9713-codec", and "soc-audio". But these don't show up
> in v3.10:arch/arm/mach-exynos/mach-smdkv310.c. So it's not obvious how
> these two files relate.

> And I'm left wondering why SND_SOC_SAMSUNG_SMDK_WM9713 actually depends
> on (among other symbols) MACH_SMDKV310 and MACH_SMDKC210 in v3.10.

The hardware is physically present on those boards but must be selected
with DIP switches, the device registration needs to be changed in the
kernel when that happens (as the DT must be when it is in use).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140212/33499d57/attachment.sig>
