From: jassisinghbrar@gmail.com (jassi brar)
Date: Tue, 15 Sep 2009 20:04:05 +0900
Subject: [PATCH 5/7] S3C64XX DMA: TC-IRQ implemented.
In-Reply-To: <20090915101355.GD22878@rakim.wolfsonmicro.main>
References: <1253008883-7624-1-git-send-email-jassi.brar@samsung.com>
	<20090915101355.GD22878@rakim.wolfsonmicro.main>
Message-ID: <1b68c6790909150404i4b3579feofa95c023ce22b204@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2009 at 7:13 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Sep 15, 2009 at 07:01:23PM +0900, Jassi wrote:
>
>> + ? ? ? ? ? ? if (errstat & bit)
>> + ? ? ? ? ? ? ? ? ? ? writel(bit, dmac->regs + PL080_ERR_CLEAR);
>
> The old code would complain in the logs on error, which seems like a
> reasonable approach if we've no better idea what to do - it at least
> tells people something about what might be going on if things break.
Yes, some debug mssg wud be better.

>> + ? ? ? ? ? ? chan = dmac->channels + offs;
>> + ? ? ? ? ? ? if(chan->curr == NULL)
>> + ? ? ? ? ? ? ? ? ? ? continue;
>
> It's probably a good idea to run your patches through
> scripts/checkpatch.pl before submitting them.
ahhhh.... my me!!
