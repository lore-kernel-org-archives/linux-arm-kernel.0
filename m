From: florian.meier@koalo.de (Florian Meier)
Date: Sun, 5 Jan 2014 20:05:10 +0100
Subject: [PATCHv9] dmaengine: Add support for BCM2835
In-Reply-To: <201401051952.07355.arnd@arndb.de>
References: <52C5A6A3.8000405@koalo.de> <201401051506.03481.arnd@arndb.de>
 <CABDT8WyUVbPu60qwMbAxKS=2m2akskybZQS3-+rehuUD+3oBXQ@mail.gmail.com>
 <201401051952.07355.arnd@arndb.de>
Message-ID: <CABDT8Wx-jRKQYS+pvPcy7OVBvy_qSkqZmvEMmagT7dFisKmpCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.01.2014 19:52, Arnd Bergmann wrote:
> On Sunday 05 January 2014, Florian Meier wrote:
>> On 05.01.2014 15:06, Arnd Bergmann wrote:
>>>>
>>>> Sigh, the API is developing faster than I can keep track with updating
>>>> this patch. I hope some day I will be faster....
>>>> When Russell told me about the second one before, it hoped that I can
>>>> avoid merging different trees on my own, but it seems that you want me
>>>> to do that ;-)
>>>
>>> The dma_get_any_slave_channel() change is probably my fault. I suggested
>>> both the initial dma_get_slave_channel() API and this one because the
>>> original approach turned out too complicated. If dma_set_mask_and_coherent().
>>>
>>> I don't think you have to merge other trees, to get both APIs, they should
>>> already be part of the dma-slave tree that your patch would get merged
>>> into. If not, we can probably come up with a different solution. The
>>> dma_set_mask_and_coherent() suggestion is not as important as the
>>> dma_get_any_slave_channel() one, if you have to choose between them.
>>
>> Both changes are in the slave-dma tree, but I need patches from the
>> bcm2835 tree and the asoc tree, too. Although, it shouldn't be too
>> complicated to merge them, I hope.
>
> Why do you need the bcm2835 and asoc changes? The addition of the
> dmaengine driver should be self-contained as far as I can tell,
> except that the audio driver won't work unless both are merged.
>
> This wouldn't be considered a strict dependency since you are not
> breaking anything that used to work prior to the patches, and you
> don't create a kernel version that doesn't build. Note that this
> would be different if you had a dependency on a platform_data
> definition.

You are right! I just have to merge them for testing the driver.
