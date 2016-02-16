From: keescook@chromium.org (Kees Cook)
Date: Tue, 16 Feb 2016 15:12:24 -0800
Subject: [PATCH 1/2] ARM: mm: DEBUG_RODATA makes no sense with XIP_KERNEL
In-Reply-To: <CAGXu5jJg4SqrHdJsB-5AzcQbNR-hDZv6YsWayf7LefO+ng4Qhg@mail.gmail.com>
References: <1455638631-3326518-1-git-send-email-arnd@arndb.de>
 <CAGXu5jJg4SqrHdJsB-5AzcQbNR-hDZv6YsWayf7LefO+ng4Qhg@mail.gmail.com>
Message-ID: <CAGXu5jK0wmfiY1SANschub++bxxiL46fvxx-y24vdVzihUX5kg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 12:31 PM, Kees Cook <keescook@chromium.org> wrote:
> On Tue, Feb 16, 2016 at 8:03 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> When CONFIG_DEBUG_ALIGN_RODATA is set, we get a link error:
>>
>> arch/arm/mm/built-in.o:(.data+0x4bc): undefined reference to `__start_rodata_section_aligned'
>>
>> However, this combination is useless, as XIP_KERNEL implies that all the
>> RODATA is already marked readonly, so both CONFIG_DEBUG_RODATA and
>> CONFIG_DEBUG_ALIGN_RODATA (which depends on the other) are not
>> needed with XIP_KERNEL, and this patches enforces that using a Kconfig
>> dependency.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Fixes: 25362dc496ed ("ARM: 8501/1: mm: flip priority of CONFIG_DEBUG_RODATA")
>
> For this and the 2/2 patch:
>
> Acked-by: Kees Cook <keescook@chromium.org>
>
> I've sent follow-up to clean up the XIP linker script too, if you want
> to take that as the 3rd patch in this series of fixes.

Arnd, when you send your 2 patches to the tracker, can you also send
mine (so the ordering is correct)?

Thanks!

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
