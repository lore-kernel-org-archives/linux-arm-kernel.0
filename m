From: rabin@rab.in (Rabin Vincent)
Date: Wed, 23 Feb 2011 22:55:03 +0530
Subject: [PATCH] nmk-gpio: use request_irq instead of chained handler
In-Reply-To: <-6148324460357957969@unknownmsgid>
References: <1298465690-27077-1-git-send-email-rabin.vincent@stericsson.com>
	<-6148324460357957969@unknownmsgid>
Message-ID: <AANLkTin94vzJ_RvxvydnF1ymT2hbKGHruqUMrFTZKPJ+@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 23, 2011 at 22:47, Will Deacon <will.deacon@arm.com> wrote:
>> __nmk_gpio_irq_handler doesn't do anything more that what a normal handler
>> does, so it can become one. ?This is also needed for changing the GIC
>> implementation to a different flow handler.
>>
>> Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
>
> mach-nomadik only seems to use the vic. Why does this GPIO handler
> need updating?

plat-nomadik/gpio.c is also used by mach-ux500, which uses the GIC.
