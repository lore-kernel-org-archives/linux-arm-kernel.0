From: sbkim73@samsung.com (Sangbeom Kim)
Date: Thu, 07 Apr 2011 13:44:37 +0900
Subject: [alsa-devel] [PATCH 3/3] SoC: SAMSUNG: Add WM8580 PCM Machine
	driver
In-Reply-To: <BANLkTinOadw2TkNMs2_Lvmskb=yU8XYUuw@mail.gmail.com>
References: <1302136270-28776-1-git-send-email-sbkim73@samsung.com>
	<1302136270-28776-4-git-send-email-sbkim73@samsung.com>
	<BANLkTinOadw2TkNMs2_Lvmskb=yU8XYUuw@mail.gmail.com>
Message-ID: <041f01cbf4de$85702f30$90508d90$@com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi! Jassi

On Thursday, April 07, 2011 12:43 PM, Jassi Brar wrote:
> > +static struct snd_soc_dai_link smdk_dai[] = {
> > +       {
> > +               .name = "WM8580 PAIF PCM RX",
> > +               .stream_name = "Playback",
> > +               .cpu_dai_name = "samsung-pcm.0",
> > +               .codec_dai_name = "wm8580-hifi-playback",
> > +               .platform_name = "samsung-audio",
> > +               .codec_name = "wm8580-codec.0-001b",
> > +               .ops = &smdk_wm8580_pcm_ops,
> > +       }, {
> > +               .name = "WM8580 PAIF PCM TX",
> > +               .stream_name = "Capture",
> > +               .cpu_dai_name = "samsung-pcm.0",
> > +               .codec_dai_name = "wm8580-hifi-capture",
> > +               .platform_name = "samsung-audio",
> > +               .codec_name = "wm8580-codec.0-001b",
> > +               .ops = &smdk_wm8580_pcm_ops,
> > +       },
> > +};
> 
> IIRC the PCM DAI is connected to Secondary i/f of WM8580
> on some SMDKs. Isn't it smdk6410 ?

Yes, Your remember is right. SMDK6410 has WM8580 PCM DAI.
But, In this time, I couldn't test on SMDK6410.
After testing on SMDK6410, I will submit related patch.

Thanks and regards,
SB Kim
