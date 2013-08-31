From: lars@metafoo.de (Lars-Peter Clausen)
Date: Sat, 31 Aug 2013 22:45:26 +0200
Subject: [alsa-devel] [PATCH 00/14] SPDIF support
In-Reply-To: <20130831191414.GG6617@n2100.arm.linux.org.uk>
References: <20130831123458.GF6617@n2100.arm.linux.org.uk>
 <52220B9A.9000007@metafoo.de> <20130831191414.GG6617@n2100.arm.linux.org.uk>
Message-ID: <522255E6.6010800@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/31/2013 09:14 PM, Russell King - ARM Linux wrote:
> On Sat, Aug 31, 2013 at 05:28:26PM +0200, Lars-Peter Clausen wrote:
>> On 08/31/2013 02:34 PM, Russell King - ARM Linux wrote:
>> [...]
>>> The same conditions apply as per my previous posting - the DAI link
>>> needs to be setup and the associated DAPM routes to tell the CPU DAI
>>> which outputs are in use, like this:
>>>
>>> DAI link:
>>>                 .name = "S/PDIF1",
>>>                 .stream_name = "IEC958 Playback",
>>>                 .platform_name = "mvebu-audio.1",
>>>                 .cpu_dai_name = "mvebu-audio.1",
>>>                 .codec_dai_name = "dit-hifi",
>>>                 .codec_name = "spdif-dit",
>>>
>>> static const struct snd_soc_dapm_route routes[] = {
>>>         { "Playback", NULL, "spdifdo" },
>>> };
>>
>> This is still not exactly the right way to implement this though. Add a
>> second DAI to your CPU driver, like this:
> 
> What you're suggesting is the DPCM solution.

No it is not using any DPCM. You only need to use DPCM if you want to use
both DAIs at the same time. But maybe you want to do that?

- Lars
