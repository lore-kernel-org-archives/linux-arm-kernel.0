From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 17 Jun 2015 11:33:50 +0200
Subject: [PATCH v4] ARM: early fixmap support for earlycon
In-Reply-To: <5580AFD0.1030606@codeaurora.org>
References: <1434491507-6208-1-git-send-email-stefan@agner.ch>
 <5580AFD0.1030606@codeaurora.org>
Message-ID: <CAKv+Gu_7UrOkDBUhZdnKY4bMuw9+jLY0vjeG_PZ3y7cB+rooBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 June 2015 at 01:22, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 06/16/2015 02:51 PM, Stefan Agner wrote:
>> Add early fixmap support, initially to support permanent, fixed
>> mapping support for early console. A temporary, early pte is
>> created which is migrated to a permanent mapping in paging_init.
>> This is also needed since the attributes may change as the memory
>> types are initialized. The 3MiB range of fixmap spans two pte
>> tables, but currently only one pte is created for early fixmap
>> support.
>>
>> Re-add FIX_KMAP_BEGIN to the index calculation in highmem.c since
>> the index for kmap does not start at zero anymore. This reverts
>> 4221e2e6b316 ("ARM: 8031/1: fixmap: remove FIX_KMAP_BEGIN and
>> FIX_KMAP_END") to some extent.
>>
>> Cc: Mark Salter <msalter@redhat.com>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Laura Abbott <lauraa@codeaurora.org>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>>
>
> Works on msm_serial.
>
> Tested-by: Stephen Boyd <sboyd@codeaurora.org>
>

I gave this a spin as well, on Arndale, with /chosen/stdout-path set
to &serial_2  and just 'earlycon' (without value) passed on the
command line, and it works fine.

Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
