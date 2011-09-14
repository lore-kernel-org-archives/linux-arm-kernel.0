From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Wed, 14 Sep 2011 18:38:29 +0530
Subject: [PATCH v7 14/26] gpio/omap: remove unnecessary bit-masking for
	read access
In-Reply-To: <4E708DCA.3090606@ru.mvista.com>
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
	<1315918979-26173-15-git-send-email-tarun.kanti@ti.com>
	<4E708DCA.3090606@ru.mvista.com>
Message-ID: <CAC83Zv+1qT8uL5Jc+=RA61FT=GCOKbfogpqu3xNWM9Xfp0Kk7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2011 at 4:49 PM, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> Hello.
>
> On 13-09-2011 17:02, Tarun Kanti DebBarma wrote:
>
>> Remove un-necessary bit masking. Since the register are 4 byte aligned
>> and readl would work as is. The 'enabled' mask is already taking care
>> to mask for bank width.
>
>> Signed-off-by: Charulatha V<charu@ti.com>
>> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
>> Reviewed-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>> ---
>> ?drivers/gpio/gpio-omap.c | ? ?2 --
>> ?1 files changed, 0 insertions(+), 2 deletions(-)
>
>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>> index 876e387..d614c6d 100644
>> --- a/drivers/gpio/gpio-omap.c
>> +++ b/drivers/gpio/gpio-omap.c
>> @@ -571,8 +571,6 @@ static void gpio_irq_handler(unsigned int irq, struct
>> irq_desc *desc)
>> ? ? ? ? ? ? ? ?enabled = _get_gpio_irqbank_mask(bank);
>> ? ? ? ? ? ? ? ?isr_saved = isr = __raw_readl(isr_reg)& ?enabled;
>>
>> - ? ? ? ? ? ? ? if (cpu_is_omap15xx()&& ?(bank->method == METHOD_MPUIO))
>> - ? ? ? ? ? ? ? ? ? ? ? isr&= 0x0000ffff;
>>
>
> ? Should have removed the now unneeded empty line too.
Sure... I will remove.
--
Tarun
>
>> ? ? ? ? ? ? ? ?if (bank->level_mask)
>> ? ? ? ? ? ? ? ? ? ? ? ?level_mask = bank->level_mask& ?enabled;
>
> WBR, Sergei
>
