From: bp@alien8.de (Borislav Petkov)
Date: Tue, 29 Jan 2013 19:10:46 +0100
Subject: [RFC] arm: use built-in byte swap function
In-Reply-To: <1359482147.3529.161.camel@shinybook.infradead.org>
References: <20130128193033.8a0b0a871150c99247f05a95@freescale.com>
 <20130129083522.GA14302@pd.tnic>
 <1359478014.3529.157.camel@shinybook.infradead.org>
 <20130129174249.GB25415@pd.tnic>
 <1359482147.3529.161.camel@shinybook.infradead.org>
Message-ID: <20130129181046.GC25415@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 05:55:54PM +0000, Woodhouse, David wrote:
> That's different though. That's because GCC didn't have a generic
> __builtin_bswap16() until 4.8, while PowerPC got it in 4.6.
> 
> That's a relatively simple and manageable one-off arch-dependency. But
> once we get into a mass of "well, it wasn't actually *usable* for ARM
> until 4.9", we start wanting to push it into arch code.

Yeah, and once people see one arch mentioned, all of a sudden they think
it is ok to add just one more ...

> > But I liked your other suggestion better to get the offending
> > compilers fixed.
> 
> That wasn't an *alternative*. It's required if the compiler is doing
> something suboptimal, whatever happens. And then we start to *use* the
> compiler from the first version that's known to be fixed.

So, IMHO it sounds to me like we want to explicitly state for each arch
separately that it is ok to use the __builtin_bswapXX things. This also
takes care of the case where the compiler is doing something suboptimal
by excluding the affected versions.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
