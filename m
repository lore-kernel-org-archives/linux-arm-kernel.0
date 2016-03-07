From: emilio@elopez.com.ar (=?UTF-8?Q?Emilio_L=c3=b3pez?=)
Date: Mon, 7 Mar 2016 14:15:07 -0300
Subject: [linux-sunxi] [PATCH] dma: sun4i: expose block size and wait
 cycle configuration to DMA users
In-Reply-To: <20160307164702.59f5d9d1@bbrezillon>
References: <1457344771-12946-1-git-send-email-boris.brezillon@free-electrons.com>
 <1457364641.20836.5.camel@plaes.org> <20160307164702.59f5d9d1@bbrezillon>
Message-ID: <56DDB71B.5050801@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

El 07/03/16 a las 12:47, Boris Brezillon escribi?:
(...)
>> Does SPI refer the Serial Peripheral Interface?
>>
>> If yes, then I would point out that current sun4i SPI driver doesn't
>> actually use DMA [1]
>>
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2016-February/411
>> 722.html
> 
> I just moved this assignment and the associated comment in the driver,
> so maybe we should ask Emilio why he thinks SPI config should be the
> default one, and how he tested it...

When I was working on the dmaengine driver, I needed a way to test
mem<->dev and mem<->mem transfers. I used dmatest.ko for the latter, and
SPI was a good fit for the former as I had a logic analyzer. That's why
there's patches to support DMA on it (but, as Priit pointed out, are not
in mainline yet).

At first SPI was acting weird when using DMA, but the problems went away
when configuring the timings with these magic values you see on the
driver today. These timings turned out to also work for audio, so there
was no need for a mechanism to configure them.

And that's basically the story behind SUN4I_DDMA_MAGIC_SPI_PARAMETERS :)

Cheers,
Emilio
