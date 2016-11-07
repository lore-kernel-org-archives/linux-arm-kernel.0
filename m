From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 7 Nov 2016 09:51:27 +0800
Subject: [PATCH v2 06/14] ASoC: sun4i-codec: Add support for A31 playback
 through headphone output
In-Reply-To: <20161106185715.tlvcakzqay2lamd5@lukather>
References: <20161103075556.29018-1-wens@csie.org>
 <20161103075556.29018-7-wens@csie.org>
 <20161103173602.zchyciwj66zdibc7@lukather>
 <CAGb2v65CZJ+1LTWWk3+vABV8PDgsDta+nZ7o3H2Z--KFPe2kog@mail.gmail.com>
 <20161106185715.tlvcakzqay2lamd5@lukather>
Message-ID: <CAGb2v64Mq=LkEq7WNb+DdpoXC8dFw9vLsdOfH-o0LazXQSUQkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 7, 2016 at 2:57 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Fri, Nov 04, 2016 at 09:08:11AM +0800, Chen-Yu Tsai wrote:
>> On Fri, Nov 4, 2016 at 1:36 AM, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>> > Hi,
>> >
>> > On Thu, Nov 03, 2016 at 03:55:48PM +0800, Chen-Yu Tsai wrote:
>> >> +/* headphone controls */
>> >> +static const char * const sun6i_codec_hp_src_enum_text[] = {
>> >> +     "DAC", "Mixer",
>> >> +};
>> >> +
>> >> +static SOC_ENUM_DOUBLE_DECL(sun6i_codec_hp_src_enum,
>> >> +                         SUN6I_CODEC_OM_DACA_CTRL,
>> >> +                         SUN6I_CODEC_OM_DACA_CTRL_LHPIS,
>> >> +                         SUN6I_CODEC_OM_DACA_CTRL_RHPIS,
>> >> +                         sun6i_codec_hp_src_enum_text);
>> >> +
>> >> +static const struct snd_kcontrol_new sun6i_codec_hp_src[] = {
>> >> +     SOC_DAPM_ENUM("Headphone Source Playback Route",
>> >> +                   sun6i_codec_hp_src_enum),
>> >> +};
>> >
>> > What is that route exactly? A muxer?
>>
>> Yup. The following is part of the widgets list later in the code:
>>
>> +       /* Headphone output path */
>> +       SND_SOC_DAPM_MUX("Headphone Source Playback Route",
>> +                        SND_SOC_NOPM, 0, 0, sun6i_codec_hp_src),
>
> Oh, right.
>
> You can add my Acked-by on this one and the other patches too.

Thanks. Mark already merged all the driver patches though.

ChenYu
