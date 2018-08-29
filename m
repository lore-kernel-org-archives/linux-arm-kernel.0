From: codrin.ciubotariu@microchip.com (Codrin Ciubotariu)
Date: Wed, 29 Aug 2018 18:33:19 +0300
Subject: [PATCH 1/2] ASoC: Add driver for PROTO Audio CODEC (with a WM8731)
In-Reply-To: <8f1ecff2-aab7-2a1d-a8d3-8d0062a8a9e0@microchip.com>
References: <20180829144727.13757-1-codrin.ciubotariu@microchip.com>
 <20180829144727.13757-2-codrin.ciubotariu@microchip.com>
 <20180829145355.GD27808@sirena.org.uk>
 <8f1ecff2-aab7-2a1d-a8d3-8d0062a8a9e0@microchip.com>
Message-ID: <54d79485-81ef-763a-c896-c6ab3e33b5d1@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29.08.2018 18:20, Codrin Ciubotariu wrote:
> On 29.08.2018 17:53, Mark Brown wrote:
>> On Wed, Aug 29, 2018 at 05:47:26PM +0300, Codrin Ciubotariu wrote:
>>
>>> +static const unsigned int wm8731_rates_12288000[] = {
>>> +??? 8000, 32000, 48000, 96000,
>>> +};
>>> +
>>> +static struct snd_pcm_hw_constraint_list wm8731_constraints_12288000 
>>> = {
>>> +??? .list = wm8731_rates_12288000,
>>> +??? .count = ARRAY_SIZE(wm8731_rates_12288000),
>>> +};
>>> +
>>> +static int snd_proto_startup(struct snd_pcm_substream *substream)
>>> +{
>>> +??? /* Setup constraints, because there is a 12.288 MHz XTAL on the 
>>> board */
>>> +??? snd_pcm_hw_constraint_list(substream->runtime, 0,
>>> +?????????????????? SNDRV_PCM_HW_PARAM_RATE,
>>> +?????????????????? &wm8731_constraints_12288000);
>>> +??? return 0;
>>> +}
>>
>> This bit is better added to the CODEC driver since it'll apply to any
>> system where there's this clock rate (someone else could come in and add
>> other rates, no need to do that yourself though it'd be nice of course).
> 
> I could do it.

It looks like these constraints are already in the wm8731 driver. I will 
wait for more comments and then I will send a v2 without this part.

Thanks and best regards,
Codrin
