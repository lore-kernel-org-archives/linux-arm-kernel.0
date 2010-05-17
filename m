From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Mon, 17 May 2010 21:58:35 +0900
Subject: [PATCH] DMA: PL330: Add dma api driver
In-Reply-To: <AANLkTinAmHkVBii9nTZ5tNYU21whHy8awP55nGEc-8Tp@mail.gmail.com>
References: <1273641798-26579-1-git-send-email-jassi.brar@samsung.com>
	<AANLkTinAmHkVBii9nTZ5tNYU21whHy8awP55nGEc-8Tp@mail.gmail.com>
Message-ID: <AANLkTikeRmB7DdO1Nrvzz-jVV8CmISA5C_9f2kgpeLEO@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 17, 2010 at 6:55 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> On Tue, May 11, 2010 at 10:23 PM, Jassi Brar <jassi.brar@samsung.com> wrote:

>> +static void dma_pl330_rqcb(void *token, enum pl330_op_err err)
>> +{
>> + ? ? ? struct dma_pl330_desc *desc = token;
>> + ? ? ? struct dma_pl330_chan *pch = desc->pchan;
>> + ? ? ? unsigned long flags;
>> +
>> + ? ? ? /* If desc aborted */
>> + ? ? ? if (!pch)
>> + ? ? ? ? ? ? ? return;
>> +
>> + ? ? ? spin_lock_irqsave(&pch->lock, flags);
>> +
>> + ? ? ? desc->status = DONE;
>> +
>> + ? ? ? spin_unlock_irqrestore(&pch->lock, flags);
>
> I don't think you need the lock here. ?Assigning an integer is atomic,
> and you reschedule the tasklet.
yes right

> Since this patch depends on the generic bits in Russell's tree I need
> to wait until after the ARM tree is pulled to take it through the dma
> tree. ?So, for now...
>
> Acked-by: Dan Williams <dan.j.williams@intel.com>
Thanks
