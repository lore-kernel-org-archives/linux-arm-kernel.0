From: james.hogan@imgtec.com (James Hogan)
Date: Fri, 28 Feb 2014 22:52:56 +0000
Subject: [PATCH] irq: Changed the return type of irq_chip.irq_startup()
 from unsigned int to int
In-Reply-To: <1393521679-32331-1-git-send-email-jjhiblot@traphandler.com>
References: <CACh+v5Nkuct0J65OHcnSd6Dfq4EyfafY8RpTvdwKXUA7A8_+Xw@mail.gmail.com>
 <1393521679-32331-1-git-send-email-jjhiblot@traphandler.com>
Message-ID: <7150036.UpHTd1PK1K@radagast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 February 2014 18:21:19 Jean-Jacques Hiblot wrote:
>  arch/arm/mach-omap2/gpmc.c                | 2 +-
>  arch/blackfin/mach-common/ints-priority.c | 2 +-
>  arch/ia64/hp/sim/hpsim_irq.c              | 2 +-
>  arch/ia64/kernel/iosapic.c                | 4 ++--
>  arch/ia64/kernel/irq_lsapic.c             | 2 +-
>  arch/ia64/sn/kernel/irq.c                 | 2 +-
>  arch/m68k/apollo/dn_ints.c                | 2 +-
>  arch/m68k/atari/ataints.c                 | 4 ++--
>  arch/m68k/include/asm/irq.h               | 4 ++--
>  arch/m68k/kernel/ints.c                   | 4 ++--
>  arch/m68k/mac/macints.c                   | 4 ++--
>  arch/m68k/platform/coldfire/intc-2.c      | 2 +-
>  arch/m68k/platform/coldfire/intc-simr.c   | 2 +-
>  arch/m68k/q40/q40ints.c                   | 2 +-
>  arch/metag/kernel/irq.c                   | 2 +-
>  arch/mips/jz4740/gpio.c                   | 2 +-
>  arch/mips/kernel/irq_cpu.c                | 2 +-
>  arch/mips/lantiq/irq.c                    | 2 +-
>  arch/mips/sgi-ip27/ip27-irq-pci.c         | 2 +-
>  arch/powerpc/platforms/powermac/pic.c     | 2 +-
>  arch/powerpc/platforms/wsp/ics.c          | 4 ++--
>  arch/powerpc/sysdev/mpic.c                | 2 +-
>  arch/powerpc/sysdev/xics/ics-opal.c       | 2 +-
>  arch/powerpc/sysdev/xics/ics-rtas.c       | 2 +-
>  arch/sparc/kernel/leon_kernel.c           | 2 +-
>  arch/sparc/kernel/leon_pci_grpci1.c       | 2 +-
>  arch/sparc/kernel/leon_pci_grpci2.c       | 2 +-
>  arch/sparc/kernel/pcic.c                  | 2 +-
>  arch/sparc/kernel/sun4d_irq.c             | 2 +-
>  arch/sparc/kernel/sun4m_irq.c             | 2 +-
>  arch/tile/kernel/pci_gx.c                 | 2 +-
>  arch/x86/kernel/apic/io_apic.c            | 2 +-
>  arch/x86/platform/visws/visws_quirks.c    | 2 +-
>  drivers/gpio/gpio-adnp.c                  | 2 +-
>  drivers/gpio/gpio-bcm-kona.c              | 2 +-
>  drivers/gpio/gpio-em.c                    | 2 +-
>  drivers/gpio/gpio-intel-mid.c             | 2 +-
>  drivers/gpio/gpio-lynxpoint.c             | 2 +-
>  drivers/gpio/gpio-mcp23s08.c              | 2 +-
>  drivers/gpio/gpio-tz1090.c                | 2 +-
>  drivers/irqchip/irq-metag.c               | 4 ++--

I think you've missed out drivers/irqchip/irq-metag-ext.c

Thanks
James

>  drivers/pinctrl/pinctrl-adi2.c            | 2 +-
>  drivers/pinctrl/pinctrl-baytrail.c        | 2 +-
>  drivers/pinctrl/pinctrl-msm.c             | 2 +-
>  drivers/pinctrl/pinctrl-nomadik.c         | 2 +-
>  drivers/pinctrl/sirf/pinctrl-sirf.c       | 2 +-
>  drivers/xen/events/events_base.c          | 4 ++--
>  include/linux/irq.h                       | 2 +-
>  kernel/irq/dummychip.c                    | 2 +-
>  49 files changed, 57 insertions(+), 57 deletions(-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140228/94a1cf09/attachment.sig>
