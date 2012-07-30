From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 30 Jul 2012 15:32:08 +0100
Subject: [PATCH 01/18] Documentation: Describe the ux500 realated audio
 related DT nodes
In-Reply-To: <20120730134804.GE4468@opensource.wolfsonmicro.com>
References: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
 <1343393162-11938-2-git-send-email-lee.jones@linaro.org>
 <20120729203106.GD4384@opensource.wolfsonmicro.com>
 <50163A09.8060203@linaro.org>
 <20120730134804.GE4468@opensource.wolfsonmicro.com>
Message-ID: <50169AE8.4020601@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/07/12 14:48, Mark Brown wrote:
> On Mon, Jul 30, 2012 at 08:38:49AM +0100, Lee Jones wrote:
>> On 29/07/12 21:31, Mark Brown wrote:
>>> On Fri, Jul 27, 2012 at 01:45:45PM +0100, Lee Jones wrote:
>
>>>> +   - Machine Driver : "stericsson,snd-soc-mop500"
>>>> +   - CPU-side DAI   : "stericsson,ux500-msp-i2s"
>>>> +   - DMA (platform) : "stericsson,ux500-pcm"
>>>> +   - Audio CODEC    : "stericsson,ab8500-codec"
>
>>> What is this a binding document for?  It looks like the binding for a
>>> machine driver...
>
>> No, it's a binding document for all of the ux500 driver and CODEC
>> blocks. Do you really want me to split it all up? I think the only
>> component which could be sanely split-out is the ab8500-codec, which
>> could (should?) live in [1].
>
> Yes, of course!  Each device will have a separate binding with different
> requirements.
>
>> These properties are relevant for some, but not all of the
>> components above, hence why the are listed at 'optional properties'.
>
> Which is part of the problem here, it makes it much harder to tell what
> you need to do for the individual devices.

Once again, I'll split them out, but I think there are people talking 
about documentation consolidation, as it's going to become very messy, 
very quickly if we keep adding new files for each device. Soon the 
Documentation directory will be as large as the driver base. :)

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
