From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Thu, 12 Aug 2010 17:58:23 +0200
Subject: [PATCH] ARM: add PrimeCell generic DMA to MMCI/PL180 v10
In-Reply-To: <20100812143002.GA31982@n2100.arm.linux.org.uk>
References: <1281454328-22805-1-git-send-email-linus.walleij@stericsson.com>
	<20100811144859.GC5846@debian>
	<AANLkTimriY-NerBUBeuPf_qX_01iZvntH3TMVdkn7wJv@mail.gmail.com>
	<20100812143002.GA31982@n2100.arm.linux.org.uk>
Message-ID: <AANLkTike7O_JDXdURqi1186WW26ShD3UutEGSYneRo88@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/8/12 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Thu, Aug 12, 2010 at 03:58:08PM +0200, Linus Walleij wrote:
>> In arch/arm/mm/dma-mapping.c
>> dma_map_sg() returns 0 on a mapping error, and the same as
>> passed in the third parameter on success.
>
> Rabin is right - dma_map_sg() is allowed to return fewer entries than
> was passed as it is allowed to coalesce entries together. ?Please don't
> use the implementation as a source of how things should behave, instead
> read the documentation in Documentation/DMA-API.txt:

Aha yeah I get it now, I will take that as tonights reading excercise,
And it makes perfect sense too.

I seem to be in bad company, a quick search in LXR reveals
numerous instances of this error throughout the kernel tree I'll
put it on my TODO list to fix a few of them up.

Yours,
Linus Walleij
