From: robertcnelson@gmail.com (Robert Nelson)
Date: Fri, 8 Mar 2013 12:00:07 -0600
Subject: [PATCH 0/4] SAMA5D3 support
In-Reply-To: <1362755638-20092-1-git-send-email-ludovic.desroches@atmel.com>
References: <1362755638-20092-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <CAOCHtYiqkQYZukbp=xOyxT_vmRRRbbpev5R3vvtKPqEu9GttOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 8, 2013 at 9:13 AM,  <ludovic.desroches@atmel.com> wrote:
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>
> Hi,
>
> This set of patches introduces basic support for the SAMA5D3 family. It is
> based on Jean-Christophe Kconfig cleanup patch series available at:
>
>   git://github.com/at91linux/linux-at91.git delivery/at91_3.9_dt_cleanup
>
> Regards
>
> Ludovic Desroches (4):
>   ARM: at91: add AT91_SAM9_TIME entry to select at91sam926x_time.c
>     compilation
>   ARM: at91: introduce the core type choice to split ARMv4/5 and ARMv7
>     arch
>   ARM: at91: fix infinite loop in at91_irq_suspend/resume
>   ARM: at91: introduce SAMA5 support

Hi Ludovic,

Looks like something is still missing, with the 3 cleanup patches
(delivery/at91_3.9_dt_cleanup) and these 4 on top of mainline built
with "sama5_defconfig" results in:

  CC      net/wireless/ap.o
  CC      net/wireless/trace.o
  LD      net/wireless/cfg80211.o
  LD      net/wireless/built-in.o
  LD      net/built-in.o
  LINK    vmlinux
  LD      vmlinux.o
  MODPOST vmlinux.o
  GEN     .version
  CHK     include/generated/compile.h
  UPD     include/generated/compile.h
  CC      init/version.o
  LD      init/built-in.o
arch/arm/mach-at91/built-in.o: In function `soc_detect':
pm.c:(.init.text+0xa88): undefined reference to `sama5d3_soc'
make: *** [vmlinux] Error 1

Everything looks correct in:
./arch/arm/mach-at91/setup.c
./arch/arm/mach-at91/soc.h

Regards,

-- 
Robert Nelson
http://www.rcn-ee.com/
