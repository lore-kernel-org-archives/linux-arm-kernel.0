From: eric.miao@canonical.com (Eric Miao)
Date: Thu, 3 Jun 2010 15:43:30 +0800
Subject: [PATCH 0/5] Makefile.boot cleanup
In-Reply-To: <1275550613-9553-1-git-send-email-eric.miao@canonical.com>
References: <1275550613-9553-1-git-send-email-eric.miao@canonical.com>
Message-ID: <AANLkTim-U76fy_N6bfhJ0BFihDrW1YEcJXDyEqtajc8c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 3, 2010 at 3:36 PM, Eric Miao <eric.miao@canonical.com> wrote:
> Several facts:
>
> 1. ZRELADDR in most cases can be auto detected by maksing PC with
> ? 0xf000_0000 if the zImage is placed within the first 256MiB from
> ? the memory start, which is a sane assumption except for:
>
> ? - when ARCH_MX1 or ARCH_SHARK is defined
> ? - when ARCH_U300 is defined (U300 really is strange when defining
> ? ? PHYS_OFFSET and ZRELADDR)
> ? - or when ZBOOT_ROM is defined
>

And maybe we could restrict the assumption to 128MB, so that MX1
and SHARK can be included as well.

> 2. For the exceptions above or those situations where ZRELADDR still
> ? needs to be specified, an option CONFIG_ZRELADDR is provided. So
> ? if there is conflict when mutliple machines are selected (in the
> ? near future), things can be manually fixed by menuconfig, instead
> ? of playing tricks with Makefile.
>
> 3. INITRD_PHYS and PARAMS_PHYS are really used only for bootpImage,
> ? and references in arch/arm/boot/compressed can be safely removed
>
> I've listed most of the zreladdr-y found in each Makefile.boot and
> made them default value in CONFIG_ZRELADDR, but still there could be
> mistakes. Please kindly try and report back, thanks.
>
>
