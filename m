From: jassisinghbrar@gmail.com (jassi brar)
Date: Sat, 24 Apr 2010 08:20:48 +0900
Subject: [PATCH 1/7] PL330: Add common core driver
In-Reply-To: <j2x63386a3d1004231449ta90046b5pc29622b58a87b99a@mail.gmail.com>
References: <1271834848-29179-1-git-send-email-jassisinghbrar@gmail.com>
	<j2x63386a3d1004231449ta90046b5pc29622b58a87b99a@mail.gmail.com>
Message-ID: <n2y1b68c6791004231620lcd670271u3a9d33bb52c10e37@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 24, 2010 at 6:49 AM, Linus Walleij
<linus.ml.walleij@gmail.com> wrote:
> 2010/4/21 ?<jassisinghbrar@gmail.com>:
>
>> PL330 is a configurable DMA controller PrimeCell device.
>> The register map of the device is well defined.
>> The configuration of a particular implementation can be
>> read from the six configuration registers CR0-4,Dn.
>
> I think this looks better for every iteration and is definately ripe
> for merge, so FWIW:
> Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Thanks.

>> The exported interface should be sufficient to implement
>> a driver for any DMA API.
>
> Will you make an attempt at doing this in time for the next
> merge window as well? That would be perfect.
Actually I said "any DMA API" i.e, some platform, like S3C,
may choose to implement their own API.

You mean the DMA engine driver for PL330, right?
Since Joonyoung's driver was pre-empted by these patches,
he might want to re-write parts of his driver for this backend.
If he doesn't show any interest in a few days, I'll do it.

Btw, I think that driver should be divided in two files
drivers/dma/api-pl330.c with common code and
drivers/dma/<soc>-pl330.c for platform specific stuff like IRQ,
registers base mapping and other quirks(if any). Any opinions?
