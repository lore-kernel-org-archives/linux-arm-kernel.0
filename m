From: will.deacon@arm.com (Will Deacon)
Date: Fri, 20 May 2011 10:14:15 +0100
Subject: [PATCH v2] arm: Add Cortex A5 proc info
In-Reply-To: <20110519160819.GD2431@arm.com>
References: <1305720361.17656.44.camel@hornet.cambridge.arm.com>
	<1305737066-11900-1-git-send-email-pawel.moll@arm.com>
	<000d01cc162e$723081b0$56918510$@deacon@arm.com>
	<1305819084.17656.63.camel@hornet.cambridge.arm.com>
	<20110519160819.GD2431@arm.com>
Message-ID: <001001cc16ce$4af0a260$e0d1e720$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >
> > > On top of that, I think you should take optional, additional HWCAPs as
> > > arguments to the macro which get ORd with the base v7 HWCAPs.
> >
> > Em, the "optional" bit here is a problem. I can't just do
> >
> > #define INFO(_a, _extra_hwcaps...) \
> > 	.long HWCAP | _extra_hwcaps;
> >
> >
> > Because the output would be ".long HWCAP | ;" when no _extra_hwcaps are
> > given... Unless I'm missing some preprocessor trick? :-)
> 
> You could use an assembler macro instead.
> 
> .macro blarg insert_hwcaps=0
> 	/* blah */
> 	.long HWCAP_ALICE | HWCAP_BOB | HWCAP_CHARLIE | ( \insert_hwcaps )
> 	/* blah */
> .endm
> 
> As an added bonus, this could substantially reduce the diffstat, because
> assembler macro definitions can have multiple lines, so you don't need
> all that awful semicolon-backslash line continuation stuff.
> 
> Not everyone likes assembler macros, though...

I think that looks better and we are in an assembly file after all.
 
> >
> > > This might be useful for A15 where we have integer division.
> >
> > What HWCAP would this be? I've checked Catalin's repo and the only
> > difference I've spotted between A9 and A15 proc info were the mmu
> > flags...
> 
> You could invent one, if none is defined yet.  You probably want to
> check with Catalin or Will.

This is a separate patch and not one that we should rush out until we've
spoken to the tools guys. Having the extensibility from the start makes
sense though.

Will
