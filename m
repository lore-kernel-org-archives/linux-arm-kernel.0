From: dongas86@gmail.com (Dong Aisheng)
Date: Fri, 16 Sep 2011 11:02:11 +0800
Subject: [alsa-devel] [RFC v2 PATCH 1/1] ASoC: soc-core: symmetry checking
	for each DAIs separately
In-Reply-To: <4E5E1285.8020508@ti.com>
References: <1314609314-22162-1-git-send-email-b29396@freescale.com>
	<CAOZdJXXzMgET+gDknrRBv_yFENrzJe+oFPN7_o7RisBLUhw0Rw@mail.gmail.com>
	<65EE16ACC360FA4D99C96DC085B3F77222AE40@039-SN1MPN1-001.039d.mgd.msft.net>
	<4E5E1285.8020508@ti.com>
Message-ID: <CAA+hA=TSP4aUmQEOAsWyuKFHsq45rAeTzbpEaFNeDM8vZHg9=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

2011/8/31 Liam Girdwood <lrg@ti.com>:
> On 30/08/11 03:54, Dong Aisheng-B29396 wrote:
>>> -----Original Message-----
>>> From: Tabi Timur-B04825
>>> Sent: Tuesday, August 30, 2011 4:35 AM
>>> To: Dong Aisheng-B29396
>>> Cc: alsa-devel at alsa-project.org; lars at metafoo.de; s.hauer at pengutronix.de;
>>> broonie at opensource.wolfsonmicro.com; w.sang at pengutronix.de; lrg at ti.com;
>>> linux-arm-kernel at lists.infradead.org
>>> Subject: Re: [alsa-devel] [RFC v2 PATCH 1/1] ASoC: soc-core: symmetry
>>> checking for each DAIs separately
>>>
>>> On Mon, Aug 29, 2011 at 4:15 AM, Dong Aisheng <b29396@freescale.com>
>>> wrote:
>>>> The orginal code does not cover the case that one DAI such as codec
>>>> may be shared between other two DAIs(CPU).
>>>
>>> Can you give me an example of how this can occur?
>>>
>>
>> Pls check the following case used in mx28evk.
>> static struct snd_soc_dai_link mxs_sgtl5000_dai[] = {
>> ? ? ? ? {
>> ? ? ? ? ? ? ? ? .name ? ? ? ? ? = "HiFi Tx",
>> ? ? ? ? ? ? ? ? .stream_name ? ?= "HiFi Playback",
>> ? ? ? ? ? ? ? ? .codec_dai_name = "sgtl5000",
>> ? ? ? ? ? ? ? ? .codec_name ? ? = "sgtl5000.0-000a",
>> ? ? ? ? ? ? ? ? .cpu_dai_name ? = "mxs-saif.0",
>> ? ? ? ? ? ? ? ? .platform_name ?= "mxs-pcm-audio.0",
>> ? ? ? ? ? ? ? ? .ops ? ? ? ? ? ?= &mxs_sgtl5000_hifi_ops,
>> ? ? ? ? }, {
>> ? ? ? ? ? ? ? ? .name ? ? ? ? ? = "HiFi Rx",
>> ? ? ? ? ? ? ? ? .stream_name ? ?= "HiFi Capture",
>> ? ? ? ? ? ? ? ? .codec_dai_name = "sgtl5000",
>> ? ? ? ? ? ? ? ? .codec_name ? ? = "sgtl5000.0-000a",
>> ? ? ? ? ? ? ? ? .cpu_dai_name ? = "mxs-saif.1",
>> ? ? ? ? ? ? ? ? .platform_name ?= "mxs-pcm-audio.1",
>> ? ? ? ? ? ? ? ? .ops ? ? ? ? ? ?= &mxs_sgtl5000_hifi_ops,
>> ? ? ? ? },
>> };
>> You can also refer to:
>> http://thread.gmane.org/gmane.linux.ports.arm.kernel/129789/focus=129839
>>
>
> Timur, iirc your driver has some special symmetry requirement (maybe something todo with having 2 DAIs) ?
>
> I assume this is OK for you too ?
>
> Acked-by: Liam Girdwood <lrg@ti.com>
>
Can you apply this?

Regards
Dong Aisheng
