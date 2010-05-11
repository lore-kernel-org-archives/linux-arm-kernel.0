From: dan.j.williams@intel.com (Dan Williams)
Date: Tue, 11 May 2010 09:53:23 -0700
Subject: [PATCH 1/7] DMAENGINE: add generic PrimeCell interface to COH 901
	318 v6
In-Reply-To: <AANLkTinAVhnpjgVTtbZYYKb1t_DInVwTKkkJRzcO97RX@mail.gmail.com>
References: <1272848076-28315-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTinAVhnpjgVTtbZYYKb1t_DInVwTKkkJRzcO97RX@mail.gmail.com>
Message-ID: <AANLkTim7Tp8lCwMbQwW5QiQ49j7idFFUWdU3x8azIlok@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 11, 2010 at 9:37 AM, Dan Williams <dan.j.williams@intel.com> wrote:
> On Sun, May 2, 2010 at 5:54 PM, Linus Walleij
> <linus.walleij@stericsson.com> wrote:
>> This extends the DMA engine driver for the COH 901 318 used in the
>> U300 platform with the generic PrimeCell interface.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
>> ---
>> ?drivers/dma/coh901318.c | ?146 +++++++++++++++++++++++++++++++++++++++++++++++
>> ?1 files changed, 146 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/dma/coh901318.c b/drivers/dma/coh901318.c
>> index 4233440..1d5ed16 100644
>> --- a/drivers/dma/coh901318.c
>> +++ b/drivers/dma/coh901318.c
> [..]
>> +void dma_set_ambaconfig(struct dma_chan *chan,
>> + ? ? ? ? ? ? ? ? ? ? ? struct amba_dma_channel_config *config)
>
> What happens when two primecell dma devices are present on one soc?
> Can that happen? ?In that case we'll have conflicting providers of
> dma_set_ambaconfig().
>

...the ->device_control() method is already approaching an ioctl()
let's just add the argument parameter to complete the capability,
i.e.:

int (*device_control)(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
unsigned long arg);

This might also be useful be useful for the mux case to change that
configuration at runtime.

--
Dan
