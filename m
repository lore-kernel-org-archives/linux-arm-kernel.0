From: sedat.dilek@gmail.com (Sedat Dilek)
Date: Tue, 17 Jul 2012 11:47:19 +0200
Subject: linux-next: Tree for July 17 (mfd: AB3100 - ab3100_probe:
 undefined reference to `rand_initialize_irq')
Message-ID: <CA+icZUXjc+13YjoJ6FjDFboX20j3mqHNtvV2Av2-H0My8V2Mgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2012 at 7:41 AM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> Changes since 20120716:
>
> The vfs tree lost its build failure.
>
> The l2-mtd tree gained a conflict against the mtd tree.
>
> The battery tree tree lost its build failure.
>
> The regulator tree gained conflicts against the mfd tree.
>
> The tty tree lost its build failure but gained another, so I used the
> version from next-20120712.
>
> I have still reverted 3 commits from the signal tree at the request of the
> arm maintainer.
>
> The akpm tree lost a few patches that turned up elsewhere.
>

>From my today's build-log on a Ubuntu/precise AMD64 host:
[...]
  LD      drivers/video/built-in.o
  LD      drivers/built-in.o
  LINK    vmlinux
  LD      vmlinux.o
  MODPOST vmlinux.o
  GEN     .version
  CHK     include/generated/compile.h
  UPD     include/generated/compile.h
  CC      init/version.o
  LD      init/built-in.o
drivers/built-in.o: In function `ab3100_probe':
ab3100-core.c:(.devinit.text+0xbf97): undefined reference to
`rand_initialize_irq'
make[2]: *** [vmlinux] Error 1
make[1]: *** [deb-pkg] Error 2
make: *** [deb-pkg] Error 2

MFD / AB3100 kernel-config settings:

CONFIG_AB3100_CORE=y
CONFIG_AB3100_OTP=m
CONFIG_REGULATOR_AB3100=m
CONFIG_RTC_DRV_AB3100=m

If you need further informations, please let me know.

- Sedat -
