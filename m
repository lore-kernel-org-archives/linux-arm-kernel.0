From: padma.kvr@gmail.com (Padma Venkat)
Date: Thu, 5 Dec 2013 16:33:19 +0530
Subject: [PATCH] ASoC: samsung: Initialize the dma_data for secondary dai
In-Reply-To: <20131128113800.GB27568@sirena.org.uk>
References: <1385632932-16579-1-git-send-email-padma.v@samsung.com>
 <20131128113800.GB27568@sirena.org.uk>
Message-ID: <CAAgF-BdqRzB5MxTf_9nZkgSOY=F6dGAs0yhTkNHqrUQLonFAsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Thu, Nov 28, 2013 at 5:08 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Nov 28, 2013 at 03:32:12PM +0530, Padmavathi Venna wrote:
>
>> This is made based on Mark Brown for-next branch of sound.git
>> This patch is based on Mark Brown below patches for
>> generic dma engine support for samsung audio IPs.
>> ASoC: samsung: Use ASoC dmaengine code where possible
>> ASoC: samsung: Provide helper for DMA init
>
> Why don't we need this fix for mainline?  The dmaengine change is just
> moving the initialisation through a layer of indirection but there was
> initialisation anyway.  I'm concerned that there's a bug that ought to
> be fixed for v3.13 as well here.

Yes. We need this for mainline. Not dependent on your dmaengine changes.

>
>>       return snd_dmaengine_pcm_register(dev, &samsung_dmaengine_pcm_config,
>> -                                       SND_DMAENGINE_PCM_FLAG_COMPAT);
>> +                                       SND_DMAENGINE_PCM_FLAG_COMPAT |
>> +                             SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME);
>
> This is already done.

Should I send another patch by removing this flag from this patch?

Thanks
Padma
