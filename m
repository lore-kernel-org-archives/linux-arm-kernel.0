From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 28 Nov 2018 10:02:24 +0900
Subject: [PATCH v4 0/2] dmaengine: add UniPhier MIO DMAC driver
In-Reply-To: <20181127145911.GC3175@vkoul-mobl.Dlink>
References: <1539276063-5103-1-git-send-email-yamada.masahiro@socionext.com>
 <20181124141616.GH3175@vkoul-mobl.Dlink>
 <CAK7LNAR8Tk9iXPLnv4XDM0E=kTWwv2+UGz+xmtA-eJyjRFjFRw@mail.gmail.com>
 <20181127145911.GC3175@vkoul-mobl.Dlink>
Message-ID: <CAK7LNAT1wxdpp7qUAf9YgJu8MfzqrgnWkXA-032nnpSBZR9o6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 12:01 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 25-11-18, 22:53, Masahiro Yamada wrote:
> > On Sat, Nov 24, 2018 at 11:16 PM Vinod Koul <vkoul@kernel.org> wrote:
> > >
> > > On 12-10-18, 01:41, Masahiro Yamada wrote:
> > > > 1/2: DT-binding
> > > > 2/2: driver
> > >
> > > Applied this series, thanks
> >
> >
> > Thanks.
> >
> >
> > > While building I noticed that we get few warns when compiling with
> > > C=1, I would prefer you fix them. Please send fixes on top of the
> > > applied patches.
> >
> > My code is fine.
>
> Lets see..
>
> > If you are talking about the following, your sparse is too old.
> > Upgrade your sparse.
>
> Not really!!
>
> $ sparse --version
> 0.5.2
>
> .. is the last released version!
>
> Do you use from git?


Yes.

My version is v0.5.2-853-g06a4545


I only see './include/linux/slab.h:332:43: warning: dubious: x & !y'
in linux-next.


The warning in slab.h is already on the way in mm subsystem.



masahiro at pug:~/ref/linux-next$ git log --oneline -1
9d52999 Add linux-next specific files for 20181127
masahiro at pug:~/ref/linux-next$ make ARCH=arm64
CROSS_COMPILE=aarch64-linux-gnu- C=2 defconfig
drivers/dma/uniphier-mdmac.o
*** Default configuration is based on 'defconfig'
#
# configuration written to .config
#
scripts/kconfig/conf  --syncconfig Kconfig
  CHECK   scripts/mod/empty.c
  CC      scripts/mod/empty.o
  MKELF   scripts/mod/elfconfig.h
  HOSTCC  scripts/mod/modpost.o
  CC      scripts/mod/devicetable-offsets.s
  HOSTCC  scripts/mod/file2alias.o
  HOSTCC  scripts/mod/sumversion.o
  HOSTLD  scripts/mod/modpost
  CC      kernel/bounds.s
  UPD     include/generated/bounds.h
  UPD     include/generated/timeconst.h
  CC      arch/arm64/kernel/asm-offsets.s
  UPD     include/generated/asm-offsets.h
  CALL    scripts/checksyscalls.sh
<stdin>:1338:2: warning: #warning syscall open_tree not implemented [-Wcpp]
<stdin>:1341:2: warning: #warning syscall move_mount not implemented [-Wcpp]
<stdin>:1344:2: warning: #warning syscall fsopen not implemented [-Wcpp]
<stdin>:1347:2: warning: #warning syscall fsconfig not implemented [-Wcpp]
<stdin>:1350:2: warning: #warning syscall fsmount not implemented [-Wcpp]
<stdin>:1353:2: warning: #warning syscall fspick not implemented [-Wcpp]
<stdin>:1356:2: warning: #warning syscall fsinfo not implemented [-Wcpp]
  CALL    scripts/atomic/check-atomics.sh
  LDS     arch/arm64/kernel/vdso/vdso.lds
  VDSOA   arch/arm64/kernel/vdso/gettimeofday.o
  VDSOA   arch/arm64/kernel/vdso/sigreturn.o
  VDSOL   arch/arm64/kernel/vdso/vdso.so.dbg
  VDSOSYM include/generated/vdso-offsets.h
  CHECK   drivers/dma/uniphier-mdmac.c
./include/linux/slab.h:332:43: warning: dubious: x & !y
  CC      drivers/dma/uniphier-mdmac.o




> > ./include/linux/overflow.h:285:13: error: undefined identifier
> > '__builtin_mul_overflow'
> > ./include/linux/overflow.h:285:13: error: incorrect type in conditional
> > ./include/linux/overflow.h:285:13:    got void
> > ./include/linux/overflow.h:287:13: error: undefined identifier
> > '__builtin_add_overflow'
> > ./include/linux/overflow.h:287:13: error: incorrect type in conditional
> > ./include/linux/overflow.h:287:13:    got void
> > ./include/linux/overflow.h:285:13: warning: call with no type!
> > ./include/linux/overflow.h:287:13: warning: call with no type!
>
> and I was also talking about:
>
> arch/arm64/include/asm/sysreg.h:471:42: warning: constant 0xffffffffffffffff is so big it is unsigned long
> arch/arm64/include/asm/sysreg.h:512:42: warning: constant 0xffffffffffffffff is so big it is unsigned long
> include/linux/slab.h:332:43: warning: dubious: x & !y
>
> --
> ~Vinod



-- 
Best Regards
Masahiro Yamada
