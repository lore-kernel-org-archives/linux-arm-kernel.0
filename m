From: ratbert.chuang@gmail.com (Po-Yu Chuang)
Date: Thu, 23 Jun 2011 14:17:48 +0800
Subject: [PATCH] arm: add Faraday SoC A320
In-Reply-To: <1308212578-1615-1-git-send-email-ratbert.chuang@gmail.com>
References: <1308212578-1615-1-git-send-email-ratbert.chuang@gmail.com>
Message-ID: <BANLkTi=VOF=428hU_TZf7FmGZv8AiUpHbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On Thu, Jun 16, 2011 at 4:22 PM, Po-Yu Chuang <ratbert.chuang@gmail.com> wrote:
> From: Po-Yu Chuang <ratbert@faraday-tech.com>
>
>
> Signed-off-by: Po-Yu Chuang <ratbert@faraday-tech.com>
> ---
> ?arch/arm/Kconfig ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? | ? 10 +
> ?arch/arm/Makefile ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| ? ?1 +
> ?arch/arm/include/asm/serial.h ? ? ? ? ? ? ? ? ? ?| ? ?6 +
> ?arch/arm/mach-faraday/Kconfig ? ? ? ? ? ? ? ? ? ?| ? 31 ++
> ?arch/arm/mach-faraday/Makefile ? ? ? ? ? ? ? ? ? | ? 11 +
> ?arch/arm/mach-faraday/Makefile.boot ? ? ? ? ? ? ?| ? ?4 +
> ?arch/arm/mach-faraday/board-a320.c ? ? ? ? ? ? ? | ?239 +++++++++++
> ?arch/arm/mach-faraday/clock.c ? ? ? ? ? ? ? ? ? ?| ? 92 +++++
> ?arch/arm/mach-faraday/clock.h ? ? ? ? ? ? ? ? ? ?| ? 40 ++
> ?arch/arm/mach-faraday/ftintc010.c ? ? ? ? ? ? ? ?| ?458 ++++++++++++++++++++++
> ?arch/arm/mach-faraday/ftpmu010.c ? ? ? ? ? ? ? ? | ?296 ++++++++++++++
> ?arch/arm/mach-faraday/fttmr010.c ? ? ? ? ? ? ? ? | ?283 +++++++++++++
> ?arch/arm/mach-faraday/include/mach/board-a320.h ?| ? 66 +++
> ?arch/arm/mach-faraday/include/mach/clkdev.h ? ? ?| ? 26 ++
> ?arch/arm/mach-faraday/include/mach/debug-macro.S | ? 44 ++
> ?arch/arm/mach-faraday/include/mach/entry-macro.S | ? 87 ++++
> ?arch/arm/mach-faraday/include/mach/ftintc010.h ? | ? 57 +++
> ?arch/arm/mach-faraday/include/mach/ftpmu010.h ? ?| ?166 ++++++++
> ?arch/arm/mach-faraday/include/mach/fttmr010.h ? ?| ? 86 ++++
> ?arch/arm/mach-faraday/include/mach/hardware.h ? ?| ? 24 ++
> ?arch/arm/mach-faraday/include/mach/io.h ? ? ? ? ?| ? 27 ++
> ?arch/arm/mach-faraday/include/mach/irqs-a320.h ? | ? 59 +++
> ?arch/arm/mach-faraday/include/mach/irqs.h ? ? ? ?| ? 28 ++
> ?arch/arm/mach-faraday/include/mach/memory.h ? ? ?| ? 27 ++
> ?arch/arm/mach-faraday/include/mach/serial-a320.h | ? 53 +++
> ?arch/arm/mach-faraday/include/mach/serial.h ? ? ?| ? 34 ++
> ?arch/arm/mach-faraday/include/mach/system.h ? ? ?| ? 34 ++
> ?arch/arm/mach-faraday/include/mach/timex.h ? ? ? | ? 25 ++
> ?arch/arm/mach-faraday/include/mach/uncompress.h ?| ? 47 +++
> ?arch/arm/mach-faraday/include/mach/vmalloc.h ? ? | ? 24 ++
> ?arch/arm/mm/Kconfig ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| ? ?4 +-
> ?arch/arm/tools/mach-types ? ? ? ? ? ? ? ? ? ? ? ?| ? ?1 +
> ?32 files changed, 2388 insertions(+), 2 deletions(-)
> ?create mode 100644 arch/arm/mach-faraday/Kconfig
> ?create mode 100644 arch/arm/mach-faraday/Makefile
> ?create mode 100644 arch/arm/mach-faraday/Makefile.boot
> ?create mode 100644 arch/arm/mach-faraday/board-a320.c
> ?create mode 100644 arch/arm/mach-faraday/clock.c
> ?create mode 100644 arch/arm/mach-faraday/clock.h
> ?create mode 100644 arch/arm/mach-faraday/ftintc010.c
> ?create mode 100644 arch/arm/mach-faraday/ftpmu010.c
> ?create mode 100644 arch/arm/mach-faraday/fttmr010.c
> ?create mode 100644 arch/arm/mach-faraday/include/mach/board-a320.h
> ?create mode 100644 arch/arm/mach-faraday/include/mach/clkdev.h
> ?create mode 100644 arch/arm/mach-faraday/include/mach/debug-macro.S
> ?create mode 100644 arch/arm/mach-faraday/include/mach/entry-macro.S
> ?create mode 100644 arch/arm/mach-faraday/include/mach/ftintc010.h
> ?create mode 100644 arch/arm/mach-faraday/include/mach/ftpmu010.h
> ?create mode 100644 arch/arm/mach-faraday/include/mach/fttmr010.h
> ?create mode 100644 arch/arm/mach-faraday/include/mach/hardware.h
> ?create mode 100644 arch/arm/mach-faraday/include/mach/io.h
> ?create mode 100644 arch/arm/mach-faraday/include/mach/irqs-a320.h
> ?create mode 100644 arch/arm/mach-faraday/include/mach/irqs.h
> ?create mode 100644 arch/arm/mach-faraday/include/mach/memory.h
> ?create mode 100644 arch/arm/mach-faraday/include/mach/serial-a320.h
> ?create mode 100644 arch/arm/mach-faraday/include/mach/serial.h
> ?create mode 100644 arch/arm/mach-faraday/include/mach/system.h
> ?create mode 100644 arch/arm/mach-faraday/include/mach/timex.h
> ?create mode 100644 arch/arm/mach-faraday/include/mach/uncompress.h
> ?create mode 100644 arch/arm/mach-faraday/include/mach/vmalloc.h
>

Any comments are appreciated.

Best regards,
Po-Yu Chuang
