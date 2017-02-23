From: tiwai@suse.de (Takashi Iwai)
Date: Thu, 23 Feb 2017 15:24:13 +0100
Subject: [PATCH v2 4/8] sound: soc: pxa: Suppress SND_MMP_SOC for arm64
In-Reply-To: <473e4976-77eb-4b67-e874-ae6bd717ddaa@suse.de>
References: <20170222022929.10540-1-afaerber@suse.de>
 <20170222022929.10540-5-afaerber@suse.de>
 <20170222184734.wmkbzfsz4yklofcg@sirena.org.uk>
 <473e4976-77eb-4b67-e874-ae6bd717ddaa@suse.de>
Message-ID: <s5hefyp6l4i.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 23 Feb 2017 15:11:46 +0100,
Andreas F?rber wrote:
> 
> Am 22.02.2017 um 19:47 schrieb Mark Brown:
> > On Wed, Feb 22, 2017 at 03:29:24AM +0100, Andreas F?rber wrote:
> > 
> > This is patch 4 of 8, what's going on with dependencies here?
> 
> No dependencies on previous patches. 5/8 adds ARCH_MMP to arm64.
> 
> It compiled without this (just Kconfig warnings), so this could go
> through the appropriate sound tree as a cleanup.
> 
> > Please use subject lines matching the style for the subsystem.  This
> > makes it easier for people to identify relevant patches.
> 
> Should I make it "ASoC: pxa: ..." then? SND_MMP_SOC selects SND_ARM,
> which in sound/arm/Kconfig says 'Drivers that are implemented on ASoC
> can be found in "ALSA for SoC audio support" section.', which confused
> me about whether or not this is an ASoC compliant driver if it selects a
> non-ASoC symbol.

It's a bug that selects SND_ARM there.  I guess this was wrongly taken
from the old example of AC97 ARM SoC code, which was fixed later.
ASoC stuff is basically irrelevant from the legacy sound/arm/*.


thanks,

Takashi
