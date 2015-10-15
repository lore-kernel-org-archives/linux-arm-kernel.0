From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Thu, 15 Oct 2015 14:50:32 +0800
Subject: [PATCH v6 09/10] snd: dmaengine-pcm: add
 snd_dmaengine_pcm_get_caps interface
In-Reply-To: <20151015040500.GB27370@localhost>
References: <1444872865-2169-1-git-send-email-shawn.lin@rock-chips.com>
 <1444872998-2548-1-git-send-email-shawn.lin@rock-chips.com>
 <20151015040500.GB27370@localhost>
Message-ID: <561F4CB8.1000500@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/10/15 12:05, Vinod Koul wrote:
> On Thu, Oct 15, 2015 at 09:36:38AM +0800, Shawn Lin wrote:
>> +int snd_dmaengine_pcm_get_caps(struct device *dev, struct dma_slave_caps *caps)
>> +{
>> +	struct snd_soc_platform *platform;
>> +	struct dmaengine_pcm *pcm;
>> +	int ret = -ENODEV;
>> +
>> +	platform = snd_soc_lookup_platform(dev);
>> +	if (!platform)
>> +		return ret;
>> +
>> +	pcm = soc_platform_to_pcm(platform);
>> +
>> +	if (pcm->chan)
>> +		ret = dma_get_slave_caps(pcm->chan[0], caps);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_get_caps);
>
> I don't see the need of this wrapper if you are not going to use this inside
> common code.. Why not read this in driver, anyway you setting taht up in
> next patch

okay, I will read it in driver directly.

Thanks.

>


-- 
Best Regards
Shawn Lin
