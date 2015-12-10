From: dannym@scratchpost.org (Danny Milosavljevic)
Date: Thu, 10 Dec 2015 21:52:27 +0100
Subject: [PATCH v5] sun4i-codec: add inputs
In-Reply-To: <20151210175420.GH27957@lukather>
References: <20151208042013.11d31f09@dayas> <20151210175420.GH27957@lukather>
Message-ID: <20151210215227.6453acc8@dayas>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Thu, 10 Dec 2015 18:54:20 +0100
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> > +	SOC_DAPM_SINGLE("Mic1-In Playback Switch", SUN4I_CODEC_DAC_ACTL,
> > +			SUN4I_CODEC_DAC_ACTL_MIC1RS, 1, 0),
> > +	SOC_DAPM_SINGLE("Mic2-In Playback Switch", SUN4I_CODEC_DAC_ACTL,
> > +			SUN4I_CODEC_DAC_ACTL_MIC2RS, 1, 0),
> >  };
> 
> Do we need the -In part of FM, Mic1 and Mic2?

For consistency to what's in linux-sunxi.git, I will remove the "-In" from 
the Mic names in v7.

For FM, do we? I don't know. Are there ALSA devices which output to FM?

> Mic1 is already defined a few lines above.
> And you have the Mixers routes a bit above too.

Aha, Mic1 is there in <https://github.com/linux-sunxi/linux-sunxi.git> 
branch "sunxi-next".
In <git://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git> 
branch "sunxi/for-next", it's not there. 
This patch is for the latter.

I'm currently rebasing on the former, but it will take some time. 
The differences between these driver versions are:
- Mic1 Preamplifier is registered as PGA instead of switch in the former.
- Mic1 is already an input in the former.
- VMIC is handled in the former.
- ADC Capturing support exists in the former.
That's it.

I'll retest a patch based on the former...

> [global mutation]
> We'll need to fix that, see the other discussion.

Yeah, I think I found a nicer way to do it in v6.

Thanks,
   Danny
