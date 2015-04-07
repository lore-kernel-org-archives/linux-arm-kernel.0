From: valentinrothberg@gmail.com (Valentin Rothberg)
Date: Tue, 7 Apr 2015 16:12:30 +0200
Subject: ARM: Remove mach-msm: some leftovers
In-Reply-To: <CAD3Xx4JnAjrqsStPA=ELavySy0YrmWd2--w5UpJTMZtzd0Fkgg@mail.gmail.com>
References: <CAD3Xx4JnAjrqsStPA=ELavySy0YrmWd2--w5UpJTMZtzd0Fkgg@mail.gmail.com>
Message-ID: <CAD3Xx4J46RkKMPWQ_m0hqxDfR0bS=+8AiE+2h0MAXcTNbaLZtw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 7, 2015 at 4:07 PM, Valentin Rothberg
<valentinrothberg@gmail.com> wrote:
> Hi Stephen,
>
> your commit c0c89fafa289 ("ARM: Remove mach-msm and associated ARM
> architecture code") removes config ARCH_MSM from Kconfig but leaves a
> few references untouched:
>
> arch/arm/Kconfig.debug:1563:    default "debug/uncompress.h" if
> ARCH_MULTIPLATFORM || ARCH_MSM || \
> drivers/phy/Kconfig:289:        depends on OF && ARCH_MSM
> drivers/scsi/ufs/Kconfig:76:    depends on SCSI_UFSHCD_PLATFORM && ARCH_MSM
> drivers/video/fbdev/Kconfig:2331:       depends on FB && ARCH_MSM
>
> Is there a reason to keep those leftovers or is it an accident?
>
> I detected this issues with ./scripts/checkkconfigsymbols.py by
> comparing today's and the previous linux-next tree (--diff
> commit1..commit2).
>
> Kind regards,
>  Valentin

Same issue applies to the Kconfig option MSM_SMD:

drivers/char/Kconfig:596:       depends on MSM_SMD
drivers/tty/serial/Kconfig:1384:        depends on MSM_SMD
