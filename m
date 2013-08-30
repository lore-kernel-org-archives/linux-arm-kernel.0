From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 30 Aug 2013 12:17:10 +0100
Subject: [PATCH 16/16] Add config EFI_STUB for ARM to Kconfig
In-Reply-To: <CAFECyb8m=5kExhusmepcebyUyBN5R9f7Kjah8NzXJ26Pmo=MNA@mail.gmail.com>
References: <1376090777-20090-1-git-send-email-roy.franz@linaro.org>
 <1376090777-20090-17-git-send-email-roy.franz@linaro.org>
 <20130813131857.GE2823@localhost.localdomain>
 <CAFECyb8m=5kExhusmepcebyUyBN5R9f7Kjah8NzXJ26Pmo=MNA@mail.gmail.com>
Message-ID: <20130830111710.911FC3E102A@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Aug 2013 10:37:13 -0700, Roy Franz <roy.franz@linaro.org> wrote:
> On Tue, Aug 13, 2013 at 6:18 AM, Dave Martin <Dave.Martin@arm.com> wrote:
> > On Fri, Aug 09, 2013 at 04:26:17PM -0700, Roy Franz wrote:
> >> Signed-off-by: Roy Franz <roy.franz@linaro.org>
> >> ---
> >>  arch/arm/Kconfig |   11 +++++++++++
> >>  1 file changed, 11 insertions(+)
> >>
> >> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> >> index 43594d5..8607d03 100644
> >> --- a/arch/arm/Kconfig
> >> +++ b/arch/arm/Kconfig
> >> @@ -1805,6 +1805,17 @@ config UACCESS_WITH_MEMCPY
> >>         However, if the CPU data cache is using a write-allocate mode,
> >>         this option is unlikely to provide any performance gain.
> >>
> >> +config EFI_STUB
> >> +     bool "EFI stub support"
> >> +     depends on EFI
> >
> > && !CPU_BIG_ENDIAN, in case you didn't get around to that.
> >
> > Sooner or later, someone may try to fix that, so there should be a
> > comment somewhere explaining what is broken for BE.
> >
> > Either in efi-stub.c or in the commit message accompanying this patch, I
> > guess.
> >
> EFI will be !CPU_BIG_ENDIAN, so we will get the dependency
> transitively through EFI.
> That said, I think it may be better to have both be explicitly
> !CPU_BIG_ENDIAN, as even
> though the underlying reasons are the same (EFI services calls being
> little endian), both
> the stub and runtime services would need to be fixed to enable the
> stub to run in BE mode.
> I'll make this explicit in the stub Kconfig, and add a comment by the
> PE/COFF magic number
> regarding the LE requirement.

Actually, not true! Steve McIntyre is currently doing some of the BE
porting work on TC2 running UEFI. Eventually he will need this.

g.
