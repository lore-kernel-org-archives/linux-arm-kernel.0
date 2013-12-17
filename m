From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 17 Dec 2013 12:12:28 +0000
Subject: [PATCH 1/4] arm64: drop redundant macros from read_cpuid()
In-Reply-To: <20131217121033.GG7602@mudshark.cambridge.arm.com>
References: <1387227878-30438-1-git-send-email-ard.biesheuvel@linaro.org>
 <1387227878-30438-2-git-send-email-ard.biesheuvel@linaro.org>
 <20131217120431.GE32118@arm.com>
 <20131217121033.GG7602@mudshark.cambridge.arm.com>
Message-ID: <20131217121227.GH32118@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 12:10:33PM +0000, Will Deacon wrote:
> On Tue, Dec 17, 2013 at 12:04:31PM +0000, Catalin Marinas wrote:
> > On Mon, Dec 16, 2013 at 09:04:35PM +0000, Ard Biesheuvel wrote:
> > >  #define read_cpuid(reg) ({						\
> > >  	u64 __val;							\
> > > -	asm("mrs	%0, " reg : "=r" (__val));			\
> > > +	asm("mrs	%0, " #reg : "=r" (__val));			\
> > >  	__val;								\
> > >  })
> > >  
> > > @@ -54,12 +44,12 @@
> > >   */
> > >  static inline u32 __attribute_const__ read_cpuid_id(void)
> > >  {
> > > -	return read_cpuid(ID_MIDR_EL1);
> > > +	return read_cpuid(MIDR_EL1);
> > >  }
> > 
> > It makes sense. Just nitpick, could you please use lowercase register
> > names for consistency?
> 
> Hmm: cputype, hw_breakpoint, perf and kvm are using upper-case names...

OK, I don't care ;). In .S we are using lower-case.

-- 
Catalin
