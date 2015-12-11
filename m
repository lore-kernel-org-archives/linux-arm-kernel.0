From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 11 Dec 2015 10:45:37 +0800
Subject: [PATCH v5] sun4i-codec: add inputs
In-Reply-To: <20151210215227.6453acc8@dayas>
References: <20151208042013.11d31f09@dayas> <20151210175420.GH27957@lukather>
 <20151210215227.6453acc8@dayas>
Message-ID: <CAGb2v643+bbOM-zgPeQrypyJg13r4m6h=1qAP-Zd5_CVB07BWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2015 at 4:52 AM, Danny Milosavljevic
<dannym@scratchpost.org> wrote:
> Hi Maxime,
>
> On Thu, 10 Dec 2015 18:54:20 +0100
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
>> > +   SOC_DAPM_SINGLE("Mic1-In Playback Switch", SUN4I_CODEC_DAC_ACTL,
>> > +                   SUN4I_CODEC_DAC_ACTL_MIC1RS, 1, 0),
>> > +   SOC_DAPM_SINGLE("Mic2-In Playback Switch", SUN4I_CODEC_DAC_ACTL,
>> > +                   SUN4I_CODEC_DAC_ACTL_MIC2RS, 1, 0),
>> >  };
>>
>> Do we need the -In part of FM, Mic1 and Mic2?
>
> For consistency to what's in linux-sunxi.git, I will remove the "-In" from
> the Mic names in v7.
>
> For FM, do we? I don't know. Are there ALSA devices which output to FM?
>
>> Mic1 is already defined a few lines above.
>> And you have the Mixers routes a bit above too.
>
> Aha, Mic1 is there in <https://github.com/linux-sunxi/linux-sunxi.git>
> branch "sunxi-next".
> In <git://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git>
> branch "sunxi/for-next", it's not there.
> This patch is for the latter.

linux-sunxi/sunxi-next is a branch we maintain that has "most" new features
and patches aimed at the next release. It is not an official kernel branch,
nor is it always up to date (though we try to merge new things in).

mripard/linux sunxi/for-next is Maxime's sunxi branches, which is mostly
clock and dts patches.

You should always base your patches on the "next" branch of the maintainer
that will take your patches. In this case, ASoC:

    https://git.kernel.org/cgit/linux/kernel/git/broonie/sound.git/log/?h=for-next

There's also a sunxi topic branch:

    https://git.kernel.org/cgit/linux/kernel/git/broonie/sound.git/log/?h=topic/sunxi

Or you can just base them off linux-next.


Regards
ChenYu

>
> I'm currently rebasing on the former, but it will take some time.
> The differences between these driver versions are:
> - Mic1 Preamplifier is registered as PGA instead of switch in the former.
> - Mic1 is already an input in the former.
> - VMIC is handled in the former.
> - ADC Capturing support exists in the former.
> That's it.
>
> I'll retest a patch based on the former...
>
>> [global mutation]
>> We'll need to fix that, see the other discussion.
>
> Yeah, I think I found a nicer way to do it in v6.
>
> Thanks,
>    Danny
