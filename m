From: HartleyS@visionengravers.com (Hartley Sweeten)
Date: Fri, 28 Nov 2014 22:30:52 +0000
Subject: [PATCH] arm: ep93xx: add dma_masks for the M2P and M2M DMA
 controllers
In-Reply-To: <201411281235.50962.arnd@arndb.de>
References: <1416590622-7765-1-git-send-email-hsweeten@visionengravers.com>,
 <201411281235.50962.arnd@arndb.de>
Message-ID: <DC148C5AA1CEBA4E87973D432B1C2D88260697B7@P3PWEX4MB008.ex4.secureserver.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, November 28, 2014 4:35 AM, Arnd Bergmann wrote:
> On Friday 21 November 2014, H Hartley Sweeten wrote:
>> The dma_mask and coherent_dma_mask need to be set or DMA memory allocations
>> will fail with error messages like this:
>>
>>   ep93xx-dma ep93xx-dma-m2p: coherent DMA mask is unset
>>
>>   ep93xx-dma ep93xx-dma-m2m: coherent DMA mask is unset
>>
>> Add the missing information to the ep93xx-dma-m2p and ep93xx-dma-m2m
>> devices.
>>
>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>> Reported-by: Jeremy Moles <cubicool@gmail.com>
>> Tested-by: Alexander Sverdlin <subaparts@yandex.ru>
>> Cc: Ryan Mallon <rmallon@gmail.com>
>
> Applied to next/fixes-non-critical. I couldn't tell from your description
> whether you want this on 3.18 or even backported to older releases,
> which I guess would make sense.
>
> If you want a backport, let me know.

Arnd,

This fixes the ep93xx sound driver. It should probably be backported and
applied to 3.18.

The sound driver was broken when it was converted to the dmaengine API.
I missed this when the driver was converted because my normal ep93xx
boards do not have sound support.

I'll try to determine when the audio actually broke so we can figure out how
far the backport needs to go,

Thanks,
Hartley
