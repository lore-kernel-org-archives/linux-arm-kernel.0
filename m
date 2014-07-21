From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 21 Jul 2014 11:38:15 +0100
Subject: [PATCH resend v2] arm64: dmi: Add SMBIOS/DMI support
In-Reply-To: <CAKv+Gu9dfw7+URK+YG6D9_gUiFn17abUk2MUw5Jj5+5BwgrVbA@mail.gmail.com>
References: <1405079210-30044-1-git-send-email-ard.biesheuvel@linaro.org>
 <20140721100304.GB12817@arm.com>
 <CAKv+Gu9dfw7+URK+YG6D9_gUiFn17abUk2MUw5Jj5+5BwgrVbA@mail.gmail.com>
Message-ID: <20140721103815.GD12817@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 21, 2014 at 11:18:37AM +0100, Ard Biesheuvel wrote:
> On 21 July 2014 12:03, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Fri, Jul 11, 2014 at 12:46:50PM +0100, Ard Biesheuvel wrote:
> >> --- /dev/null
> >> +++ b/arch/arm64/include/asm/dmi.h
> >> @@ -0,0 +1,41 @@
> > [...]
> >> +static inline void __iomem *dmi_remap(u64 phys, u64 size)
> >> +{
> >> +     void __iomem *p = efi_lookup_mapped_addr(phys);
> >
> > When are dmi_remap/dmi_early_remap() called? A quick grep through the
> > kernel shows that it is at least called once from dmi_scan_machine().
> > The latter is a device_initcall() in this patch. However, the comments
> > for efi_lookup_mapped_addr() state that it should only be called between
> > efi_enter_virtual_mode and efi_free_boot_services. The latter is invoked
> > from an early_initcall(). Could you please clarify which part is wrong
> > here?
> 
> The comment about efi_lookup_mapped_addr() is wrong. Those mappings
> are always available.
> As the comment is in shared code, I will propose a patch to Matt
> Fleming to clarify it.

Thanks for the clarification. I'll merge this patch as is.

-- 
Catalin
