From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 20 Aug 2012 20:47:07 +0000
Subject: [PATCH v2 08/31] arm64: CPU support
In-Reply-To: <20120820155740.GA912@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <20120815001043.GD19607@quad.lixom.net> <20120820155740.GA912@arm.com>
Message-ID: <201208202047.07991.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 20 August 2012, Catalin Marinas wrote:
> > > --- /dev/null
> > > +++ b/arch/arm64/mm/proc-syms.c
> ...
> > > +EXPORT_SYMBOL(__cpuc_flush_kern_all);
> > > +EXPORT_SYMBOL(__cpuc_flush_user_all);
> > > +EXPORT_SYMBOL(__cpuc_flush_user_range);
> > > +EXPORT_SYMBOL(__cpuc_coherent_kern_range);
> > > +EXPORT_SYMBOL(__cpuc_flush_dcache_area);
> > 
> > See comment on other email about putting function pointers in a struct
> > instead.
> 
> There is no need to support multiple CPU architectures with different
> implementations, so allowing these functions to be called without
> indirection is better.

What is the __cpuc prefix about then? Could you just drop it?

	Arnd
