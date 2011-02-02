From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 2 Feb 2011 10:34:32 +0100
Subject: [PATCH] mmci: restrict DMA usage to large,
	even multiblock transfers
In-Reply-To: <20110201150542.GM31216@n2100.arm.linux.org.uk>
References: <1296556873-2730-1-git-send-email-linus.walleij@linaro.org>
	<20110201105408.GA31216@n2100.arm.linux.org.uk>
	<4D47EFB6.5090509@stericsson.com>
	<20110201114522.GD31216@n2100.arm.linux.org.uk>
	<20110201115832.GF31216@n2100.arm.linux.org.uk>
	<AANLkTimN=bxJzGFDc50-ZUMmCtXaGxVUd9-Zg1+QGfNf@mail.gmail.com>
	<20110201150542.GM31216@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinE+v88NP8ZzNPSfhiBpV+=h+WcxQr+i-z1Rx4e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/2/1 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Tue, Feb 01, 2011 at 03:07:12PM +0100, Linus Walleij wrote:
>> 2011/2/1 Russell King - ARM Linux <linux@arm.linux.org.uk>:
>>
>> > So... I think this patch will work fine on ST variants, returning the
>> > DMA request signals back to their classic meaning. ?That being LSREQ
>> > is only activated on the _final_ transfer rather than the last 8
>> > transfers, which as Linus describes makes your DMA controller complete
>> > on the 8th-to-last transfer.
>>
>> I've tested this patch on MMC and SD on U8500 and it works
>> fine, so
>> Tested-by: Linus Walleij <linus.walleij@linaro.org>
>
> Thanks. ?Can I apply that to the DMA patch too (and combine this with the
> main MMCI DMA patch) ?

Yes I've tested it and it works for MMC/SD cards with the above additions.
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
