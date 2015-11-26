From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 26 Nov 2015 17:06:43 +0000
Subject: [Xen-devel] [PATCH v3 37/62] arm/acpi: Define a enum for reserved
 tables
In-Reply-To: <alpine.DEB.2.02.1511261649080.8984@kaball.uk.xensource.com>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-38-git-send-email-shannon.zhao@linaro.org>
 <alpine.DEB.2.02.1511261649080.8984@kaball.uk.xensource.com>
Message-ID: <alpine.DEB.2.02.1511261703400.8984@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 Nov 2015, Stefano Stabellini wrote:
> On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
> > From: Shannon Zhao <shannon.zhao@linaro.org>
> > 
> > It needs to copy and change the contents of some ACPI and EFI tables for
> > Dom0. Here define a enum for those tables.
> > 
> > Signed-off-by: Parth Dixit <parth.dixit@linaro.org>
> > Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> > ---
> >  xen/include/asm-arm/acpi.h | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/xen/include/asm-arm/acpi.h b/xen/include/asm-arm/acpi.h
> > index 214fc4e..f159d51 100644
> > --- a/xen/include/asm-arm/acpi.h
> > +++ b/xen/include/asm-arm/acpi.h
> > @@ -30,6 +30,18 @@
> >  
> >  extern bool_t acpi_disabled;
> >  
> > +/* Tables marked as reserved in efi table */
> > +typedef enum {
> > +    TBL_FADT,
> > +    TBL_MADT,
> > +    TBL_STAO,
> > +    TBL_XSDT,
> > +    TBL_RSDP,
> > +    TBL_EFIT,
> > +    TBL_MMAP,
> > +    TBL_MMAX,
> > +} EFI_MEM_RES;
> 
> Given that in later patches you are using the enum as integer, you
> should initialize each value explicitly.

It turns out that actually enums are guaranteed to start from 0, so
there is no need for an explicit initialization.


> >  #ifdef CONFIG_ACPI
> >  bool_t __init acpi_psci_present(void);
> >  bool_t __init acpi_psci_hvc_present(void);
> > -- 
> > 2.1.0
> > 
> > 
> > _______________________________________________
> > Xen-devel mailing list
> > Xen-devel at lists.xen.org
> > http://lists.xen.org/xen-devel
> > 
> 
