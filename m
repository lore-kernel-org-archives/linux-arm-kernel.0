From: padma.kvr@gmail.com (Padma Venkat)
Date: Wed, 7 Aug 2013 16:35:22 +0530
Subject: [PATCH V3 6/7] ASoC: Samsung: wm8994: Register the osc clock.
In-Reply-To: <20130807101024.GX6427@sirena.org.uk>
References: <1375866616-5541-1-git-send-email-padma.v@samsung.com>
 <1375866616-5541-7-git-send-email-padma.v@samsung.com>
 <20130807101024.GX6427@sirena.org.uk>
Message-ID: <CAAgF-BcoUaUkcuBpP3xRKQPCz6ceV7pvAC9kmbyckp_H1QCJaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Wed, Aug 7, 2013 at 3:40 PM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Aug 07, 2013 at 02:40:15PM +0530, Padmavathi Venna wrote:
>> This patch registers the 16MHz oscillator clock as fixed clk.
>
>> +/* 16.9MHz fixed oscillator clock */
>> +static void init_osc_clock(void)
>> +{
>> +     struct device_node *np;
>> +
>> +     np = of_find_compatible_node(NULL, NULL, "osc3_clk16mhz");
>> +     of_fixed_clk_setup(np);
>> +}
>> +
>>  static int smdk_hw_params(struct snd_pcm_substream *substream,
>>       struct snd_pcm_hw_params *params)
>>  {
>> @@ -173,6 +183,8 @@ static int smdk_audio_probe(struct platform_device *pdev)
>>               smdk_dai[0].platform_of_node = smdk_dai[0].cpu_of_node;
>>       }
>>
>> +     init_osc_clock();
>> +
>
> This doesn't seem great - it means that this machine driver needs to

Yes. True. But I am not sure of the correct place to keep this code.
Any suggestions?

Thanks
Padma

> know about a specifically named fixed clock which makes it hard to reuse
> on other similar boards.  For example I'm intending to reuse this on
> Arndale.  Mike?
