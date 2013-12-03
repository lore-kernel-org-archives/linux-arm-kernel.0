From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 03 Dec 2013 13:15:50 +0100
Subject: [alsa-devel] [PATCH 1/2] ASoC: ux500_pcm: Differentiate between
 pdata and DT initialisation
In-Reply-To: <20131203120420.GC12031@lee--X1>
References: <1386066427-6862-1-git-send-email-lee.jones@linaro.org>
 <529DC6BE.3080607@metafoo.de> <20131203120420.GC12031@lee--X1>
Message-ID: <529DCB76.4070705@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/2013 01:04 PM, Lee Jones wrote:
> On Tue, 03 Dec 2013, Lars-Peter Clausen wrote:
> 
>> On 12/03/2013 11:27 AM, Lee Jones wrote:
>>> If booting with full DT support (i.e. DMA too, the last piece of the
>>> puzzle), then we don't need to use the compatible_request_channel call
>>> back or require some of the historical bumph which probably isn't
>>> required by a platform data start-up now either. This will also be
>>> ripped out in upcoming commits.
>>>
>>> Cc: alsa-devel at alsa-project.org
>>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>>
>> Strictly speaking you do not need the second config, but well considering
>> that this will all hopefully be removed soon anyway it should be fine.
> 
> That's true it will, but why don't we need the second config? I won't
> want the compat function to be called in the DT case.

It will only be called if it was not possible to request the DMA channel
from the DT.

- Lars
