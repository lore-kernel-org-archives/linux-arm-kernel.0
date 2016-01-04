From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 4 Jan 2016 14:51:51 +0000
Subject: [Xen-devel] [PATCH v3 20/62] arm/acpi: Add ACPI support for SMP
 initialization
In-Reply-To: <56834B4C.40409@huawei.com>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-21-git-send-email-shannon.zhao@linaro.org>
 <565C63F1.5070303@citrix.com> <56834B4C.40409@huawei.com>
Message-ID: <alpine.DEB.2.02.1601041451210.19710@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Dec 2015, Shannon Zhao wrote:
> On 2015/11/30 22:57, Julien Grall wrote:
> > Hi Shannon,
> > 
> > On 17/11/15 09:40, shannon.zhao at linaro.org wrote:
> >> > diff --git a/xen/arch/arm/psci.c b/xen/arch/arm/psci.c
> >> > index d800cb6..dede0e1 100644
> >> > --- a/xen/arch/arm/psci.c
> >> > +++ b/xen/arch/arm/psci.c
> >> > @@ -22,6 +22,7 @@
> >> >  #include <xen/mm.h>
> >> >  #include <xen/smp.h>
> >> >  #include <asm/psci.h>
> >> > +#include <asm/acpi.h>
> >> >  
> >> >  /*
> >> >   * While a 64-bit OS can make calls with SMC32 calling conventions, for
> >> > @@ -86,6 +87,9 @@ int __init psci_init_0_1(void)
> >> >      int ret;
> >> >      const struct dt_device_node *psci;
> >> >  
> >> > +    if ( !acpi_disabled )
> >> > +        return -EINVAL;
> > Please explain in the commit message why PSCI 0.1 is not supported on ACPI.
> 
> Hi,
> 
> I check this again. There are not limitations of supporting PSCI version
> in ACPI SPEC. It should support PSCI 0.1 as well. But look at the code
> of linux kernel, it says it only supports PSCI 0.2+.
> 
> #define ACPI_FADT_PSCI_COMPLIANT    (1)	/* 00: [V5+] PSCI 0.2+ is
> implemented */
> 
> So does it need to be consistent with Linux or support PSCI 0.1 in Xen
> as well?

I don't think it needs to be consistent with Linux. I would support PSCI
0.1 too.
