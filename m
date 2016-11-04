From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 4 Nov 2016 09:08:11 +0800
Subject: [PATCH v2 06/14] ASoC: sun4i-codec: Add support for A31 playback
 through headphone output
In-Reply-To: <20161103173602.zchyciwj66zdibc7@lukather>
References: <20161103075556.29018-1-wens@csie.org>
 <20161103075556.29018-7-wens@csie.org>
 <20161103173602.zchyciwj66zdibc7@lukather>
Message-ID: <CAGb2v65CZJ+1LTWWk3+vABV8PDgsDta+nZ7o3H2Z--KFPe2kog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 4, 2016 at 1:36 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Thu, Nov 03, 2016 at 03:55:48PM +0800, Chen-Yu Tsai wrote:
>> +/* headphone controls */
>> +static const char * const sun6i_codec_hp_src_enum_text[] = {
>> +     "DAC", "Mixer",
>> +};
>> +
>> +static SOC_ENUM_DOUBLE_DECL(sun6i_codec_hp_src_enum,
>> +                         SUN6I_CODEC_OM_DACA_CTRL,
>> +                         SUN6I_CODEC_OM_DACA_CTRL_LHPIS,
>> +                         SUN6I_CODEC_OM_DACA_CTRL_RHPIS,
>> +                         sun6i_codec_hp_src_enum_text);
>> +
>> +static const struct snd_kcontrol_new sun6i_codec_hp_src[] = {
>> +     SOC_DAPM_ENUM("Headphone Source Playback Route",
>> +                   sun6i_codec_hp_src_enum),
>> +};
>
> What is that route exactly? A muxer?

Yup. The following is part of the widgets list later in the code:

+       /* Headphone output path */
+       SND_SOC_DAPM_MUX("Headphone Source Playback Route",
+                        SND_SOC_NOPM, 0, 0, sun6i_codec_hp_src),

ChenYu
