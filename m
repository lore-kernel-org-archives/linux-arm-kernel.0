From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 Aug 2017 16:26:32 +0200
Subject: [PATCH 01/30] asm-generic: add .data.rel.ro sections to
 __ro_after_init
In-Reply-To: <20170814125411.22604-2-ard.biesheuvel@linaro.org>
References: <20170814125411.22604-1-ard.biesheuvel@linaro.org>
 <20170814125411.22604-2-ard.biesheuvel@linaro.org>
Message-ID: <CAK8P3a3EArx1gEE=1WigMpBXHOKDkiBz+qudkyEKeO13jxxJ0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 14, 2017 at 2:53 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> When running in PIC mode, the compiler will emit const structures
> containing runtime relocatable quantities into .data.rel.ro.* sections,
> so that the linker can be smart about placing them together in a segment
> that is read-write initially, and is remapped read-only afterwards. This
> is exactly what __ro_after_init aims to provide, so move these sections
> together.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
