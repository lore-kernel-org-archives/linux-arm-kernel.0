From: bp@alien8.de (Borislav Petkov)
Date: Tue, 29 Jan 2013 18:42:49 +0100
Subject: [RFC] arm: use built-in byte swap function
In-Reply-To: <1359478014.3529.157.camel@shinybook.infradead.org>
References: <20130128193033.8a0b0a871150c99247f05a95@freescale.com>
 <20130129083522.GA14302@pd.tnic>
 <1359478014.3529.157.camel@shinybook.infradead.org>
Message-ID: <20130129174249.GB25415@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 04:46:58PM +0000, Woodhouse, David wrote:
> If we're really going to have many different architectures depending
> on different versions of GCC for this (if it wasn't sane to use
> it from 4.4/4.8 when it got introduced, and depends on some later
> arch-specific optimisation), then perhaps we'll have the arch
> provide the corresponding required GCC_VERSION for using each of
> 64/32/16 bit builtins, instead of just a yes/no flag? Or just define
> __HAVE_BUILTIN_BSWAPxx__ for itself, perhaps?

Damn, there's already the __powerpc__ thing in there.

Yeah, something like defininig __HAVE_BUILTIN_BSWAPxx__ makes sense and
can keep the header arch-agnostic without growing all those different
arch defines.

But I liked your other suggestion better to get the offending compilers
fixed.

I dunno though, how generically is stuff like that getting implemented
for every arch so probably single arches doing __HAVE* defines is
probably going to be the realizable solution in the end.

Hmmm.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
