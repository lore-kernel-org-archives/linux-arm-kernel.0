From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 17 Nov 2010 17:30:33 +0000
Subject: [PATCH v2 05/20] ARM: LPAE: Introduce L_PTE_NOEXEC and
	L_PTE_NOWRITE
In-Reply-To: <20101117172425.GE5308@n2100.arm.linux.org.uk>
References: <1289584840-18097-1-git-send-email-catalin.marinas@arm.com>
	<1289584840-18097-6-git-send-email-catalin.marinas@arm.com>
	<20101115183014.GD31421@n2100.arm.linux.org.uk>
	<AANLkTik5FcZ3rNtiwN8kYP0LZh+YqGtKP_RteoFiWa16@mail.gmail.com>
	<20101117171613.GB5308@n2100.arm.linux.org.uk>
	<AANLkTincmfqXmNQznd1fdSRYd4Vc+p47cgTfEwQoXdFm@mail.gmail.com>
	<20101117172425.GE5308@n2100.arm.linux.org.uk>
Message-ID: <1290015033.2351.69.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-11-17 at 17:24 +0000, Russell King - ARM Linux wrote:
> On Wed, Nov 17, 2010 at 05:22:12PM +0000, Catalin Marinas wrote:
> > Ah, good point, that was the mask.
> >
> > So for dmacoherent we make sure that L_PTE_EXEC is cleared. I suspect
> > we should now make sure that L_PTE_NOEXEC is set. For the other two,
> > just leave them as they are.
> 
> Already done:
> 
>  #define pgprot_dmacoherent(prot) \
> -       __pgprot_modify(prot, L_PTE_MT_MASK|L_PTE_EXEC, L_PTE_MT_BUFFERABLE)
> +       __pgprot_modify(prot, L_PTE_MT_MASK, L_PTE_MT_BUFFERABLE|L_PTE_XN)
> ...
>  #define pgprot_dmacoherent(prot) \
> -       __pgprot_modify(prot, L_PTE_MT_MASK|L_PTE_EXEC, L_PTE_MT_UNCACHED)
> +       __pgprot_modify(prot, L_PTE_MT_MASK, L_PTE_MT_UNCACHED|L_PTE_XN)

Are you already doing such changes? Just to avoid duplicating effort
(and use common naming scheme).

-- 
Catalin
