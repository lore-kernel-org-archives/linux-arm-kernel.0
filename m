From: chander.kashyap@linaro.org (Chander Kashyap)
Date: Tue, 18 Jun 2013 09:40:51 +0530
Subject: [PATCH v3 10/10] ARM: Exynos: extend soft-reset support for
 Exynos5420
In-Reply-To: <3807303.re8cJcYGJh@wuerfel>
References: <1371466836-4111-1-git-send-email-chander.kashyap@linaro.org>
 <1371466836-4111-11-git-send-email-chander.kashyap@linaro.org>
 <3807303.re8cJcYGJh@wuerfel>
Message-ID: <CANuQgHFEO47Z0S_zELF7-aEp133dzitx=c=K_BSbckRXsGP7Qw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 June 2013 17:51, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 17 June 2013 16:30:35 Chander Kashyap wrote:
>> @@ -330,10 +330,10 @@ void exynos5_restart(char mode, const char *cmd)
>>         u32 val;
>>         void __iomem *addr;
>>
>> -       if (of_machine_is_compatible("samsung,exynos5250")) {
>> -               val = 0x1;
>> -               addr = EXYNOS_SWRESET;
>> -       } else if (of_machine_is_compatible("samsung,exynos5440")) {
>> +       val = 0x1;
>> +       addr = EXYNOS_SWRESET;
>> +
>> +       if (of_machine_is_compatible("samsung,exynos5440")) {
>>                 u32 status;
>>                 np = of_find_compatible_node(NULL, NULL, "samsung,exynos5440-clock");
>>
>
> Please try to avoid adding further uses of hardcoded MMIO addresses.
I am not adding new hard-coded address. I have simply removed the
unnecessary previously existing check.
>
Thanks.
> Can you change that to use the same logic that exynos5440 has?
>
>         Arnd



--
with warm regards,
Chander Kashyap
