From: bard.shen@gmail.com (Bo Shen)
Date: Wed, 03 Jul 2013 13:22:53 +0800
Subject: [alsa-devel] [PATCH 1/2] ASoC: atmel_ssc_dai: move set dma data
 to startup callback
In-Reply-To: <51D37C59.3090306@atmel.com>
References: <1372755849-19546-1-git-send-email-voice.shen@atmel.com>
 <1372755849-19546-2-git-send-email-voice.shen@atmel.com>
 <51D2F0FA.6040409@metafoo.de> <51D37C59.3090306@atmel.com>
Message-ID: <51D3B52D.5020304@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lars,

On 7/3/2013 09:20, Bo Shen wrote:
> Hi Lars-Peter,
>
> On 7/2/2013 23:25, Lars-Peter Clausen wrote:
>> On 07/02/2013 11:04 AM, Bo Shen wrote:
>> [...]
>>> +    dma_params->substream = substream;
>>
>> Unrelated to this patch, but having a substream field in the
>> dma_params seems
>> to be redundant, since you need to know the substream to get the
>> dma_params in
>> the first place. Looking at the code it also seems to be unused other
>> than this
>> assignment. Maybe you can send a follow up patch to remove it.
>>
>> [...]
>>
>
> Yes, this is redundant. I will remove it in next version patches.

Sorry for mistake, this substream parameter need by the interrupt for 
PDC transfer, so, I will keep it.

Best Regards,
Bo Shen
