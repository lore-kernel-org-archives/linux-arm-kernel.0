From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 19 May 2015 10:18:56 +0100
Subject: [PATCHv2 08/12] arm64: psci: remove ACPI coupling
In-Reply-To: <555AF703.4050702@linaro.org>
References: <1431945503-6939-1-git-send-email-mark.rutland@arm.com>
 <1431945503-6939-9-git-send-email-mark.rutland@arm.com>
 <555AF703.4050702@linaro.org>
Message-ID: <20150519091856.GA1035@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 09:40:35AM +0100, Hanjun Guo wrote:
> > diff --git a/arch/arm64/include/asm/psci.h b/arch/arm64/include/asm/psci.h
> > index 2454bc5..b5d4c1d 100644
> > --- a/arch/arm64/include/asm/psci.h
> > +++ b/arch/arm64/include/asm/psci.h
> > @@ -14,7 +14,14 @@
> >   #ifndef __ASM_PSCI_H
> >   #define __ASM_PSCI_H
> >
> > -int psci_dt_init(void);
> > -int psci_acpi_init(void);
> > +int __init psci_dt_init(void);
> > +
> > +#ifdef CONFIG_ACPI
> > +int __init psci_acpi_init(void);
> > +bool __init acpi_psci_present(void);
> > +bool __init acpi_psci_use_hvc(void);
> 
> really some nit, do we need __init for function declaration?

Given that it's used for function declarations in init.h and other
places, I believe it is best practice. Even if not strictly necessary it
makes clear to the casual read when a function may be called.

> 
> other than that,
> 
> Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

Cheers!

Mark.
