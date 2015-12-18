From: keescook@chromium.org (Kees Cook)
Date: Fri, 18 Dec 2015 13:26:24 -0800
Subject: [PATCH] ARM: fix atags_to_fdt with stack-protector-strong
In-Reply-To: <2005828.pC3KGx5clE@wuerfel>
References: <20151218210459.GA23293@www.outflux.net>
 <2005828.pC3KGx5clE@wuerfel>
Message-ID: <CAGXu5j+xgvQu5-=F33TfQye9O96O+DhzxBq0x3M_sZGhQJxPOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2015 at 1:09 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 18 December 2015 13:04:59 Kees Cook wrote:
>> +ifeq ($(CONFIG_ARM_ATAG_DTB_COMPAT),y)
>> +CFLAGS_atags_to_fdt.o := -fno-stack-protector
>> +CFLAGS_fdt.o := -fno-stack-protector
>> +CFLAGS_fdt_ro.o := -fno-stack-protector
>> +CFLAGS_fdt_rw.o := -fno-stack-protector
>> +CFLAGS_fdt_wip.o := -fno-stack-protector
>> +endif
>
> I'm pretty sure you don't need the ifeq there, you can simply define those
> flags unconditionally.
>
> You can't just add -fno-stack-protector unconditionally, because that
> breaks building the kernel with toolchains that are older than stack-protector,
> so this should be
>
> CFLAGS_obj.o += $(call cc-option, -fno-stack-protector)
>
> Other than that, the patch looks ok.

Ah, yes, all excellent points. I'll resend. Thanks!

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
