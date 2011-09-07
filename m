From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Wed, 7 Sep 2011 11:48:49 +0530
Subject: [PATCH v6 24/25] gpio/omap: restore OE only after setting the
	output level
In-Reply-To: <87ty8pusfq.fsf@ti.com>
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
	<1314798161-19523-25-git-send-email-tarun.kanti@ti.com>
	<87ty8pusfq.fsf@ti.com>
Message-ID: <CAC83ZvLgUp0-mjuNcEx3+JaX2-6-5t72CCZo93FiUssdE8m_Ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 7, 2011 at 5:36 AM, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> From: Nishanth Menon <nm@ti.com>
>>
>> Setup the dataout register before setting the GPIO to output mode
>> in restore path.
>
> Please summarize why. ?(again, it may seem obvious now, but may not be for
> those not familiar with the driver or when coming back to it after a few
> months looking at other code.
Ok.

>
> Kevin
>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>> ?drivers/gpio/gpio-omap.c | ? ?2 +-
>> ?1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>> index db22df8..a629498 100644
>> --- a/drivers/gpio/gpio-omap.c
>> +++ b/drivers/gpio/gpio-omap.c
>> @@ -1326,7 +1326,6 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
>> ? ? ? __raw_writel(bank->context.wake_en,
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? bank->base + bank->regs->wkup_en);
>> ? ? ? __raw_writel(bank->context.ctrl, bank->base + bank->regs->ctrl);
>> - ? ? __raw_writel(bank->context.oe, bank->base + bank->regs->direction);
>> ? ? ? __raw_writel(bank->context.leveldetect0,
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? bank->base + bank->regs->leveldetect0);
>> ? ? ? __raw_writel(bank->context.leveldetect1,
>> @@ -1336,6 +1335,7 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
>> ? ? ? __raw_writel(bank->context.fallingdetect,
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? bank->base + bank->regs->fallingdetect);
>> ? ? ? __raw_writel(bank->context.dataout, bank->base + bank->regs->dataout);
>> + ? ? __raw_writel(bank->context.oe, bank->base + bank->regs->direction);
>>
>> ? ? ? if (bank->dbck_enable_mask) {
>> ? ? ? ? ? ? ? __raw_writel(bank->context.debounce, bank->base +
>
