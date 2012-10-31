From: m-karicheri2@ti.com (Murali Karicheri)
Date: Wed, 31 Oct 2012 09:23:36 -0400
Subject: [PATCH v3 02/11] clk: davinci - add PSC clock driver
In-Reply-To: <CACRpkdaNfv13xxHyA0p9M7oqRqb7j0J9gvyYvYhgCs7-z4ifhQ@mail.gmail.com>
References: <1351181518-11882-1-git-send-email-m-karicheri2@ti.com>
 <1351181518-11882-3-git-send-email-m-karicheri2@ti.com>
 <CACRpkdaNfv13xxHyA0p9M7oqRqb7j0J9gvyYvYhgCs7-z4ifhQ@mail.gmail.com>
Message-ID: <50912658.1010702@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/28/2012 03:24 PM, Linus Walleij wrote:
> On Thu, Oct 25, 2012 at 6:11 PM, Murali Karicheri <m-karicheri2@ti.com> wrote:
>
>> This is the driver for the Power Sleep Controller (PSC) hardware
>> found on DM SoCs as well Keystone SoCs (c6x). This driver borrowed
>> code from arch/arm/mach-davinci/psc.c and implemented the driver
>> as per common clock provider API. The PSC module is responsible for
>> enabling/disabling the Power Domain and Clock domain for different IPs
>> present in the SoC. The driver is configured through the clock data
>> passed to the driver through struct clk_psc_data.
>>
>> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> Here is some pedantic stuff if you're really bored:
>
>> diff --git a/drivers/clk/davinci/clk-psc.c b/drivers/clk/davinci/clk-psc.c
> (...)
>> +               ptcmd = 1 << domain;
> ptcmd = BIT(domain);
>
>> +               pdctl = readl(psc_base + PDCTL + 4 * domain);
>> +               pdctl |= 0x100;
> pdctl |= BIT(8); /* and here a comment explaing what on earth that means */
>
>> +       } else {
>> +               ptcmd = 1 << domain;
> ptcmd = BIT(domain);
>
> Yours,
> Linus Walleij
>
>
Linus,

Thanks. I will fix the above and add your Acked-by in the next revision 
of the patch.

Murali
