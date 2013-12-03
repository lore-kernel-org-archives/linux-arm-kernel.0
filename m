From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 03 Dec 2013 21:52:30 +0800
Subject: [RFC part3 PATCH 2/2] ARM64 / clocksource: Use
 arch_timer_acpi_init()
In-Reply-To: <CACRpkdYeMOMQzDn5=XpDg7X9L_zMZczGg-5SBA8q_WvwFPnH7A@mail.gmail.com>
References: <1386069328-22502-1-git-send-email-hanjun.guo@linaro.org>
 <1386069328-22502-3-git-send-email-hanjun.guo@linaro.org>
 <CACRpkdYeMOMQzDn5=XpDg7X9L_zMZczGg-5SBA8q_WvwFPnH7A@mail.gmail.com>
Message-ID: <529DE21E.4080707@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013?12?03? 20:27, Linus Walleij wrote:
> On Tue, Dec 3, 2013 at 12:15 PM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>
>> +       /* if can't be initialised from DT, try ACPI way */
>> +       if (!arch_timer_get_rate())
>> +               arch_timer_acpi_init();
>> +
>>          arch_timer_rate = arch_timer_get_rate();
> This looks a bit fragile. Having a call like arch_timer_get_rate()
> to check whether there is a DT node for the timer doesn't seem
> right, can you refactor the code to provide some
> has_arch_timer_node() or similar call instead, so it's a bit easier
> to understand & maintain at least?

Good point, thanks for the guidance.
I will introduce has_arch_timer_node() as you said and use
it as follows:

if (has_arch_timer_node())
clocksource_of_init();
esle
arch_timer_acpi_init(); /* try ACPI way */

Is this make sense to you?

Thanks
Hanjun
