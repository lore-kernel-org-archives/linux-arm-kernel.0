From: anton@enomsg.org (Anton Vorontsov)
Date: Sat, 16 Mar 2013 09:50:37 -0700
Subject: [PATCH 0/5] cns3xxx multiplatform support
In-Reply-To: <1363299271-8283-1-git-send-email-arnd@arndb.de>
References: <1363299271-8283-1-git-send-email-arnd@arndb.de>
Message-ID: <20130316165037.GA2522@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thu, Mar 14, 2013 at 11:14:26PM +0100, Arnd Bergmann wrote:
> I've looked at all the platforms recently to see what their
> state is. cns3xxx seems quite clean but not very actively
> maintained. Since it is really easy to convert to multiplatform,
> that's what I did here. I'd like to apply this for linux-3.9
> unless there are objections or other comments.

I might have some old self-made QEMU emulator for CNS3xxx boards, but I am
not sure if I could revive it quickly. Maybe Cavium folks could test it
faster than me though (some Cc'ed, some Bcc'ed).

But the patches themselves look great, so:

Acked-by: Anton Vorontsov <anton@enomsg.org>

Thanks a lot!

Anton

> Arnd Bergmann (5):
>   ARM: cns3xxx: make mach header files local
>   ARM: cns3xxx: enable sparse IRQ support
>   ARM: cns3xxx: move debug_ll code to include/debug/
>   ARM: cns3xxx: enable multiplatform support
>   ARM: cns3xxx: initial DT support
> 
>  arch/arm/Kconfig                                   |  11 --
>  arch/arm/Kconfig.debug                             |   8 ++
>  arch/arm/configs/cns3420vb_defconfig               |   3 +
>  .../mach/debug-macro.S => include/debug/cns3xxx.S} |   0
>  arch/arm/mach-cns3xxx/Kconfig                      |  12 ++
>  arch/arm/mach-cns3xxx/Makefile                     |   8 +-
>  arch/arm/mach-cns3xxx/cns3420vb.c                  |   6 +-
>  arch/arm/mach-cns3xxx/{include/mach => }/cns3xxx.h |   7 +-
>  arch/arm/mach-cns3xxx/core.c                       | 121 ++++++++++++++++++++-
>  arch/arm/mach-cns3xxx/devices.c                    |   5 +-
>  arch/arm/mach-cns3xxx/include/mach/irqs.h          |  24 ----
>  arch/arm/mach-cns3xxx/include/mach/timex.h         |  12 --
>  arch/arm/mach-cns3xxx/include/mach/uncompress.h    |  53 ---------
>  arch/arm/mach-cns3xxx/pcie.c                       |   2 +-
>  arch/arm/mach-cns3xxx/pm.c                         |   4 +-
>  arch/arm/mach-cns3xxx/{include/mach => }/pm.h      |   0
>  drivers/mmc/host/sdhci-cns3xxx.c                   |   1 -
>  17 files changed, 158 insertions(+), 119 deletions(-)
>  rename arch/arm/{mach-cns3xxx/include/mach/debug-macro.S => include/debug/cns3xxx.S} (100%)
>  rename arch/arm/mach-cns3xxx/{include/mach => }/cns3xxx.h (99%)
>  delete mode 100644 arch/arm/mach-cns3xxx/include/mach/irqs.h
>  delete mode 100644 arch/arm/mach-cns3xxx/include/mach/timex.h
>  delete mode 100644 arch/arm/mach-cns3xxx/include/mach/uncompress.h
>  rename arch/arm/mach-cns3xxx/{include/mach => }/pm.h (100%)
