From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 2 Oct 2018 15:53:55 +0200
Subject: [PATCH] ARM: makefile: use ARMv3M mode for RiscPC
In-Reply-To: <CAKv+Gu_mwu+TFrbRPqDZ8i5csSqS26a534yzJ_wAQL_Y+W6F7w@mail.gmail.com>
References: <CAKv+Gu8NXyfNAzk4Fe=J0QHEEV-txbRAoEcQmjG-6PgCyW5SZg@mail.gmail.com>
 <20181002132026.14931-1-Jason@zx2c4.com>
 <CAKv+Gu_mwu+TFrbRPqDZ8i5csSqS26a534yzJ_wAQL_Y+W6F7w@mail.gmail.com>
Message-ID: <CAK8P3a06uOvGcju7MppqqhsR5dwPKUBawrDbGYNXURqxGsZOKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 2, 2018 at 3:28 PM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> On 2 October 2018 at 15:20, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > The purpose of CONFIG_CPU_32v3 is to avoid ldrh/strh on the RiscPC,
> > which is pretty much an ARMv4 device, except its bus will choke on the
> > half-words. The way to make the C compiler not output ldrh/strh is with
> > -march=armv3, which doesn't support them in the ISA. However, this
> > prevents certain cryptography code from working that uses instructions
> > like umull. Fortunately there's also -march=armv3m that does support
> > those, making it possible to continue assembling optimized cryptography
> > routines for our beloved RiscPC.
> >
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: Arnd Bergmann <arnd@arndb.de>
>
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Please add this to Russell's patch tracker for inclusion at
http://www.arm.linux.org.uk/developer/patches/

      Arnd
