From: HartleyS@visionengravers.com (Hartley Sweeten)
Date: Mon, 1 Dec 2014 17:16:18 +0000
Subject: [PATCH] arm: ep93xx: add dma_masks for the M2P and M2M DMA
 controllers
In-Reply-To: <201411281235.50962.arnd@arndb.de>
References: <1416590622-7765-1-git-send-email-hsweeten@visionengravers.com>
 <201411281235.50962.arnd@arndb.de>
Message-ID: <DC148C5AA1CEBA4E87973D432B1C2D88260702F5@P3PWEX4MB008.ex4.secureserver.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, November 28, 2014 4:36 AM, Arnd Bergmann wrote:
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

I think the ep93xx audio got broken around this commit:

commit e27e8a60cb4ca8e3b047c5d6ee9afff9c4c5b61a
Author: Lars-Peter Clausen <lars@metafoo.de>
Date:   Sat Apr 20 19:29:05 2013 +0200

    ASoC: ep93xx: Use generic dmaengine PCM

But I'm not sure exactly where. I will try to narrow it down.

There appear to be a number of ep93xx users still out there but
they are mostly still using 2.6 kernels. It might be ok to just get
this fix in for 3.18 and then wait to see if anyone complains about
the sound not working in older kernels.

Thanks,
Hartley
