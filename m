From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Tue, 15 Jun 2010 13:17:28 +0200
Subject: [PATCH 06/13] DMAENGINE: driver for the ARM PL080/PL081 PrimeCells
In-Reply-To: <AANLkTil7gb7SjrYPrHPfSomwxLlHpowXOZd_Qr125jvr@mail.gmail.com>
References: <1276270031-1607-1-git-send-email-linus.walleij@stericsson.com>	<002001cb0c75$0a54fd00$1efef700$%kim@samsung.com>
	<AANLkTil7gb7SjrYPrHPfSomwxLlHpowXOZd_Qr125jvr@mail.gmail.com>
Message-ID: <4C176148.4020507@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Op 15-06-10 12:45, Jassi Brar schreef:
> On Tue, Jun 15, 2010 at 7:25 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
>> Linus Walleij wrote:
>>>
>>> This creates a DMAengine driver for the ARM PL080/PL081 PrimeCells
>>> based on the implementation earlier submitted by Peter Pearse.
>>> This is working like a charm for memcpy on the PB11MPCore, but
>>> slave DMA to devices is still not working.
>>>
>>> This DMA controller is used in mostly unmodified form in the ARM
>>> RealView and Versatile platforms, in the ST-Ericsson Nomadik, and
>>> in the ST SPEAr platform.
>>>
>>> It has been converted to use the header from the Samsung PL080
>>> derivate instead of its own defintions, and can potentially support
>>> several controllers in the same system.
>>>
>>> Cc: Peter Pearse <peter.pearse@arm.com>
>>> Cc: Ben Dooks <ben-linux@fluff.org>
>>> Cc: Kukjin Kim <kgene.kim@samsung.com>
>>
>> Looks good, but please give me some time to test on the board(SMDK6410).
>> If any problem, let you know. Of course no problem, will ack.
> Samsung doesn't use the DMA API, so this driver is unlikely to work.

It doesn't indeed, but it could be adapted to be a wrapper around the DMA engine API.
Or even better, the drivers could be adapted to use that API.
