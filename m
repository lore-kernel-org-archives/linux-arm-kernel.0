From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Wed, 14 Oct 2015 22:33:06 +0800
Subject: [alsa-devel] [PATCH v5 06/10] dmaengine: add API for getting dma
 controller's quirk
In-Reply-To: <20151014105310.GQ27370@localhost>
References: <1442187923-5736-1-git-send-email-shawn.lin@rock-chips.com>
 <1442188139-6017-1-git-send-email-shawn.lin@rock-chips.com>
 <20151005153746.GG13501@vkoul-mobl.iind.intel.com>
 <56139289.7000005@rock-chips.com> <561629D6.9010702@metafoo.de>
 <20151014105310.GQ27370@localhost>
Message-ID: <561E67A2.7080602@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/10/14 18:53, Vinod Koul wrote:
> On Thu, Oct 08, 2015 at 10:31:18AM +0200, Lars-Peter Clausen wrote:
>>> Basically I agree not to expose dma's quirk to slave controllers...But, the
>>> fact I mentioned on cover letter explain the reasons why I have to let slave
>>> controllers know that they are working with a broken dma. It's a dilemma
>>> that if we don't want that to be exposed(let slave controllers' driver get
>>> the info via a API), we have t add broken quirk for all of them ,here and
>>> there, which seems to be a disaster:(
>>
>> The problem with this API is that it transports values with device specific
>> meanings over a generic API. Which is generally speaking not a good idea
>> because the consumer witch is supposed to be generic suddenly needs to know
>> which provider it is talking to.
>>
>> A better solution in this case typically is either introduce a generic API
>> with generic values or a custom API with custom values, but don't mix the two.
>>
>>>
>>> I would appreciate it if you could give me some suggestions at your earliest
>>> convenience. :)
>>
>> In this case I think the best way to handle this is not quirks, but rather
>> expose the actual maximum burst size using the DMA capabilities API. Since
>> supporting only a certain burst depth is not really a quirk. All hardware
>> has a limit for this and for some it might be larger or smaller than for
>> others and it might be the same IP core but the maximum size depends on some
>> IP core parameters. So this should be discoverable.
>
> yes that makes more sense than adding quirks, exposing the right values
> which should be a readable property for driver will ensure it works on
> system with/without quirks

Sorry for late response in this thread.

Right, we can expose max-burst to clients by dma_slave_caps instead of 
quirks. I will try it and send v6 ASAP.

Thanks Lars and Vinod.

>


-- 
Best Regards
Shawn Lin
