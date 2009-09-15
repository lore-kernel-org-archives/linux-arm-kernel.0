From: jassisinghbrar@gmail.com (jassi brar)
Date: Tue, 15 Sep 2009 20:01:39 +0900
Subject: [PATCH 4/7] S3C64XX DMA: S3C2410_DMAF_CIRCULAR disable
In-Reply-To: <20090915100751.GC22878@rakim.wolfsonmicro.main>
References: <1253008882-7587-1-git-send-email-jassi.brar@samsung.com>
	<20090915100751.GC22878@rakim.wolfsonmicro.main>
Message-ID: <1b68c6790909150401k4bc958edl7eea0062a4d4fd38@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2009 at 7:07 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Sep 15, 2009 at 07:01:22PM +0900, Jassi wrote:
>
>> +#if 0
>> ? ? ? ? ? ? ? if (chan->flags & S3C2410_DMAF_CIRCULAR) {
>> ? ? ? ? ? ? ? ? ? ? ? struct s3c64xx_dma_buff *curr = chan->curr;
>> ? ? ? ? ? ? ? ? ? ? ? lli->next_lli = curr->lli_dma;
>> ? ? ? ? ? ? ? }
>> +#endif
>
> If you're doing something like this you should remove the code rather
> than if 0 it out, or at least insert a comment explaining why the code
> is sitting around.
Yes, infact the comment in changelog was moved from here.
I wanted to remove it altogether, but ....

> ?Though I'm a bit concerned that if something has
> actually tried to set up circular DMA it might get upset if that's
> ignored (not that I've looked in detail).
That shudn't be an issue.
S3C64xx dma isn't used by any code other than I2S which doesn't
have any machine driver.

If the decision to disable CIRCULAR flag is acceptable, i will resend the patch.
