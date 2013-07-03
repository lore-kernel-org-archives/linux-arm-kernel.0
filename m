From: voice.shen@atmel.com (Bo Shen)
Date: Wed, 3 Jul 2013 16:13:28 +0800
Subject: [alsa-devel] [PATCH 2/2] ASoC: atmel-pcm: use generic dmaengine
 framework
In-Reply-To: <51D3DBE8.4090407@metafoo.de>
References: <1372755849-19546-1-git-send-email-voice.shen@atmel.com>
 <1372755849-19546-3-git-send-email-voice.shen@atmel.com>
 <51D2F306.7040603@metafoo.de> <51D37F87.2010008@atmel.com>
 <51D3D482.1050100@metafoo.de> <51D3D969.1060308@atmel.com>
 <51D3DBE8.4090407@metafoo.de>
Message-ID: <51D3DD28.8050900@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lars,

On 7/3/2013 16:08, Lars-Peter Clausen wrote:
> On 07/03/2013 09:57 AM, Bo Shen wrote:
>> Hi Lars,
>>
>> On 7/3/2013 15:36, Lars-Peter Clausen wrote:
>>>>>> +        slave_config->dst_addr = (dma_addr_t)ssc->phybase + SSC_THR;
>>>>>>> [...]
>>>>>>>>> +        slave_config->src_addr = (dma_addr_t)ssc->phybase + SSC_RHR;
>>>>>>>
>>>>>>> Change the type of phybase to dma_addr_t
>>>>>
>>>>> It should be:
>>>>> slave_config->dst_addr = (dma_addr_t)(ssc->phybase + SSC_THR);
>>>>> slave_config->src_addr = (dma_addr_t)(ssc->phybase + SSC_RHR);
>>> The type of phybase in the ssc_device struct should be changed from
>>> resource_size_t to dma_addr_t.
>>
>> Actually, the phybase in ssc_device structure is resource_size_t which used to
>> access the ssc device register.
>> Here, we use ssc register as dma source address or destination address, so we
>> convert it to dma_addr_t type. So, not need to change, am I right?
>
> Isn't 'regs' used to access the registers? As far as I can see phybase is only
> used in the audio DMA driver.

Thanks for point out this. I will change the phybase type from 
resource_size_t to dma_addr_t.

> - Lars
>

Best Regards,
Bo Shen
