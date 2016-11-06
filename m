From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 6 Nov 2016 19:57:15 +0100
Subject: [PATCH v2 06/14] ASoC: sun4i-codec: Add support for A31 playback
 through headphone output
In-Reply-To: <CAGb2v65CZJ+1LTWWk3+vABV8PDgsDta+nZ7o3H2Z--KFPe2kog@mail.gmail.com>
References: <20161103075556.29018-1-wens@csie.org>
 <20161103075556.29018-7-wens@csie.org>
 <20161103173602.zchyciwj66zdibc7@lukather>
 <CAGb2v65CZJ+1LTWWk3+vABV8PDgsDta+nZ7o3H2Z--KFPe2kog@mail.gmail.com>
Message-ID: <20161106185715.tlvcakzqay2lamd5@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 04, 2016 at 09:08:11AM +0800, Chen-Yu Tsai wrote:
> On Fri, Nov 4, 2016 at 1:36 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi,
> >
> > On Thu, Nov 03, 2016 at 03:55:48PM +0800, Chen-Yu Tsai wrote:
> >> +/* headphone controls */
> >> +static const char * const sun6i_codec_hp_src_enum_text[] = {
> >> +     "DAC", "Mixer",
> >> +};
> >> +
> >> +static SOC_ENUM_DOUBLE_DECL(sun6i_codec_hp_src_enum,
> >> +                         SUN6I_CODEC_OM_DACA_CTRL,
> >> +                         SUN6I_CODEC_OM_DACA_CTRL_LHPIS,
> >> +                         SUN6I_CODEC_OM_DACA_CTRL_RHPIS,
> >> +                         sun6i_codec_hp_src_enum_text);
> >> +
> >> +static const struct snd_kcontrol_new sun6i_codec_hp_src[] = {
> >> +     SOC_DAPM_ENUM("Headphone Source Playback Route",
> >> +                   sun6i_codec_hp_src_enum),
> >> +};
> >
> > What is that route exactly? A muxer?
> 
> Yup. The following is part of the widgets list later in the code:
> 
> +       /* Headphone output path */
> +       SND_SOC_DAPM_MUX("Headphone Source Playback Route",
> +                        SND_SOC_NOPM, 0, 0, sun6i_codec_hp_src),

Oh, right.

You can add my Acked-by on this one and the other patches too.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161106/37df34b8/attachment-0001.sig>
