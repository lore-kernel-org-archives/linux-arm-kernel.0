From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 5 Apr 2018 13:18:48 +0200
Subject: [PATCH] arm: decompressor: mark error() as __noreturn
In-Reply-To: <20180404223843.GL16141@n2100.armlinux.org.uk>
References: <20180404123117.3575773-1-arnd@arndb.de>
 <CAGXu5jK1abgzQCJ+9ysTZHvxPo4vG6dfwPFs_CuXdP=0_Qib_g@mail.gmail.com>
 <20180404223843.GL16141@n2100.armlinux.org.uk>
Message-ID: <CAK8P3a3PcP4rpmw2gAO7GhxwaeHeZPTrtONuqUjFvu1rfKjgpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 5, 2018 at 12:38 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Wed, Apr 04, 2018 at 03:34:06PM -0700, Kees Cook wrote:
>> On Wed, Apr 4, 2018 at 5:30 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > gcc complains about fortify_panic() possibly returning:
>> >
>> > arch/arm/boot/compressed/misc.c: In function 'fortify_panic':
>> > arch/arm/boot/compressed/misc.c:167:1: error: 'noreturn' function does return [-Werror]
>> >
>> > This annotates the error() function as __noreturn, which lets gcc
>> > see in all configurations that it fortify_panic() cannot return either.
>> >
>> > Fixes: ee333554fed5 ("ARM: 8749/1: Kconfig: Add ARCH_HAS_FORTIFY_SOURCE")
>> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>
>> Acked-by: Kees Cook <keescook@chromium.org>
>
> I'd actually prefer a more robust solution to this - error() is used
> in different files, each with their own separate prototype, which is
> error-prone.  The same goes for a few other variables.  The following
> is IMHO a more complete (and thus larger) patch:

Right, much better.

Acked-by: Arnd Bergmann <arnd@arndb.de>

I assume you'll just fold it into the original patch if you can, or apply it
on top yourself.
