From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 1 Jul 2011 11:43:08 +0530
Subject: [PATCH 2/2] SPI: SAMSUNG: Bug fix for SPI with different FIFO
	level
In-Reply-To: <BANLkTim40x4X_--K0z7gdodDjor0MUam5Q@mail.gmail.com>
References: <1309437536-9315-1-git-send-email-padma.v@samsung.com>
	<1309437536-9315-2-git-send-email-padma.v@samsung.com>
	<BANLkTi=L7QeN75ebWFXdp_V5Pw1zEc-ZtA@mail.gmail.com>
	<BANLkTimeWUbD2Ej16KKmuzwSCFz8HOhyKQ@mail.gmail.com>
	<BANLkTi=9c5asfr=Jg6xwjQZW_a369UO64Q@mail.gmail.com>
	<BANLkTinFnFwBGi693JTD_iDykA2VkV+HOw@mail.gmail.com>
	<BANLkTik0LERxBHmJc5ZnRotnD4CSveR-UQ@mail.gmail.com>
	<BANLkTim9wdrqDgXVUjxzMv9cdWViLww=Bg@mail.gmail.com>
	<BANLkTim40x4X_--K0z7gdodDjor0MUam5Q@mail.gmail.com>
Message-ID: <BANLkTinf6ec1yXeaFkZjHMnqZp7yymDq-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 1, 2011 at 11:29 AM, padma venkat <padma.kvr@gmail.com> wrote:
> Hi Jassi,
>
> On Fri, Jul 1, 2011 at 11:22 AM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
>> On Fri, Jul 1, 2011 at 11:16 AM, padma venkat <padma.kvr@gmail.com> wrote:
>>> Hi Tony,
>>>
>>> On Thu, Jun 30, 2011 at 4:30 PM, Tony Nadackal <tonykn@gmail.com> wrote:
>>>> Hi Padma,
>>>> With regards to your patch, even though one can check the tx done status
>>>> using the TX_DONE bit, the present macro itself would work perfectly fine if
>>>> the 'fifo_lvl_mask' is set properly.
>>>> For example in 6450 channel 1, the fifo_lvl_mask should be 0x1ff (for 9bits,
>>>> 15:23), while even in your patch, it is wrongly set as 0x7f(only 7bits).
>>>>
>>>> Thus, if this fifo_lvl_mask was defined correctly, the existing macro would
>>>> itself have worked.
>>> Thanks for your comment.
>>> I considered changing to the fifo_lvl_mask to 1ff as you mentioned.
>>> But I ?think that the fifo_lvl_mask reflects the actual FIFO capacity
>>> in the SPI driver.
>>> For the failing channels the FIFO trigger level is 64 bytes and so i
>>> retained that value.
>>> In the driver it polls till the FIFO capacity level otherwise it goes
>>> for DMA.So if we keep
>>> the FIFO level as 1ff when the actual capacity is 7f then it fails.
>>>
>>> Jassi what do you think about this?
>>>
>>
>> 'fifo_lvl_mask' is h/w specific and can't be set for convenience.
>>
>> I don't have access to post-s3c64xx datasheets.
>> Please check and reply if TX_DONE bit is at same offset for all
>> channels of an SoC, because
>> I suspect it's otherwise.
>>
> Yes. The TX_DONE bit is at the same offset for all the channels of an SoC.
> in S5P64X0,S5PV210 and S5PV310 it is at offset 25.
>

Then, Patches-1,2

Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
