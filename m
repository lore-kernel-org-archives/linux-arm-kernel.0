From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 12 Feb 2016 09:08:12 +0100
Subject: [PATCH v2 1/3] of/fdt: factor out assignment of
 initrd_start/initrd_end
In-Reply-To: <3591081.dypcHcG82d@wuerfel>
References: <1455209282-9596-1-git-send-email-ard.biesheuvel@linaro.org>
 <1455209282-9596-2-git-send-email-ard.biesheuvel@linaro.org>
 <3591081.dypcHcG82d@wuerfel>
Message-ID: <CAKv+Gu9azpBo=Z12vvf044OBvHGNkF17tfkqe6+G=3C-nAdQTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 February 2016 at 23:12, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 11 February 2016 17:48:00 Ard Biesheuvel wrote:
>>
>>  #ifdef CONFIG_BLK_DEV_INITRD
>> +void __weak __early_init_dt_declare_initrd(unsigned long start,
>> +                                          unsigned long end)
>> +{
>> +       initrd_start = (unsigned long)__va(start);
>> +       initrd_end = (unsigned long)__va(end);
>> +       initrd_below_start_ok = 1;
>> +}
>> +
>>
>
> I find __weak functions particularly hard to follow, I think a Kconfig
> symbols or a function you can override by defining a macro in asm/memory.h
> would be nicer.
>

OK, that makes sense.

I will give Catalin a chance to comment before respinning, though.
