From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 8 Mar 2012 00:14:52 +0530
Subject: [PATCH v2 0/9] DMA engine cookie handling cleanups
In-Reply-To: <20120307182155.GD18787@n2100.arm.linux.org.uk>
References: <20120306223321.GD15201@n2100.arm.linux.org.uk>
 <CABb+yY0A9=XKuw=N1fFXCB507zR3U=wofqATVcO_wtnnVrgXzQ@mail.gmail.com>
 <20120307182155.GD18787@n2100.arm.linux.org.uk>
Message-ID: <CABb+yY0SpuOqFP396Q7me3Em=1OYD9Ndt47EXAs6Aem0q-goQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 7, 2012 at 11:51 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Mar 07, 2012 at 11:39:25PM +0530, Jassi Brar wrote:
>> Compilation is broken without the following minor fix.
>> After that you may add
>> ? ? ? ?Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
>>
>> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
>> index 49c123f..abf35a3 100644
>> --- a/drivers/dma/pl330.c
>> +++ b/drivers/dma/pl330.c
>> @@ -339,7 +339,6 @@ static int pl330_control(struct dma_chan *chan,
>> enum dma_ctrl_cmd cmd, unsigned
>> ? ? ? ? ? ? ? /* Mark all desc done */
>> ? ? ? ? ? ? ? list_for_each_entry_safe(desc, _dt, &pch->work_list , node) {
>> ? ? ? ? ? ? ? ? ? ? ? desc->status = DONE;
>> - ? ? ? ? ? ? ? ? ? ? pch->completed = desc->txd.cookie;
>
> I'm not sure just removing this is sufficient. ?Presumably it's
> there for some reason - maybe it needs replacing with a call to
> dma_cookie_complete() to preserve existing behaviour?
>
That was anyway a redundant save in DMA_TERMINATE_ALL, so it should be ok.
