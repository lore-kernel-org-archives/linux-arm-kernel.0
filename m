From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Jul 2017 13:11:20 +0200
Subject: [PATCH RESEND] ARM: davinci: don't mark vpif_input structures as
 'const'
In-Reply-To: <5dc37564-2efe-d090-78a4-1702291b176d@ti.com>
References: <20170727101320.609258-1-arnd@arndb.de>
 <5dc37564-2efe-d090-78a4-1702291b176d@ti.com>
Message-ID: <CAK8P3a2-wsyKZGCFWhayPp95-7as6_6AP+FYZULBDDQsg4jPaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 27, 2017 at 12:54 PM, Sekhar Nori <nsekhar@ti.com> wrote:
> Hi Arnd,
>
> On Thursday 27 July 2017 03:42 PM, Arnd Bergmann wrote:
>> A change to the platform data definitions caused a warning in the board code:
>>
>> arch/arm/mach-davinci/board-dm646x-evm.c:680:13: error: initialization discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
>> arch/arm/mach-davinci/board-dm646x-evm.c:690:13: error: initialization discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
>
> You can replace these by:
>
> arch/arm/mach-davinci/board-da850-evm.c:1221:13: warning: initialization discards ?const? qualifier from pointer target type [-Wdiscarded-qualifiers]
> arch/arm/mach-davinci/board-da850-evm.c:1231:13: warning: initialization discards ?const? qualifier from pointer target type [-Wdiscarded-qualifiers]
>
> to match with this patch.

Ok, I thought I had fixed that, but for some reason ended up with the
previous version
of the change text.

>>
>> This is a bit unfortunate, since we generally like structure definitions to
>> be const, but as this is legacy code, the easiest way out is still to
>> remove the 'const' annotation here.
>>
>> Fixes: 4a5f8ae50b66 ("[media] davinci: vpif_capture: get subdevs from DT when available")
>> Fixes: 231ce279e6e3 ("ARM: davinci: fix const warnings")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks, applying it now.

        Arnd
