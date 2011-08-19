From: ijc@hellion.org.uk (Ian Campbell)
Date: Fri, 19 Aug 2011 12:47:44 +0100
Subject: [PATCH v7 09/16] ARM: LPAE: MMU setup for the 3-level page
	table format
In-Reply-To: <20110819111054.GC6558@e102109-lin.cambridge.arm.com>
References: <1312988619-16804-1-git-send-email-catalin.marinas@arm.com>
	<1312988619-16804-10-git-send-email-catalin.marinas@arm.com>
	<1313749557.5010.345.camel@zakaz.uk.xensource.com>
	<20110819111054.GC6558@e102109-lin.cambridge.arm.com>
Message-ID: <1313754464.5010.348.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-08-19 at 12:10 +0100, Catalin Marinas wrote:
> 
> > > + */
> > > +ENTRY(cpu_v7_set_pte_ext)
> > > +#ifdef CONFIG_MMU
> > > +       tst     r2, #L_PTE_PRESENT
> > > +       beq     1f
> > > +       tst     r3, #1 << (55 - 32)             @ L_PTE_DIRTY
> > > +       orreq   r2, #L_PTE_RDONLY
> > > +1:     strd    r2, r3, [r0]
> > 
> > AIUI this 64-bit store is not atomic. Is there something about the
> ARM
> > architecture which would prevent the MMU prefetching the half
> written
> > entry and caching it in the TLB?
> 
> CPU implementations that include LPAE guarantee the atomicity of a
> double-word store (STRD) if the alignment is correct. 

Ah, I was looking at the standard v7 docs and not the LPAE extensions, I
see it now.

Thanks,
Ian.

-- 
Ian Campbell

The disks are getting full; purge a file today.
