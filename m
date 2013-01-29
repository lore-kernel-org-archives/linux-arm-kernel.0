From: david.woodhouse@intel.com (Woodhouse, David)
Date: Tue, 29 Jan 2013 17:55:54 +0000
Subject: [RFC] arm: use built-in byte swap function
In-Reply-To: <20130129174249.GB25415@pd.tnic>
References: <20130128193033.8a0b0a871150c99247f05a95@freescale.com>
 <20130129083522.GA14302@pd.tnic>
 <1359478014.3529.157.camel@shinybook.infradead.org>
 <20130129174249.GB25415@pd.tnic>
Message-ID: <1359482147.3529.161.camel@shinybook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-01-29 at 18:42 +0100, Borislav Petkov wrote:
> On Tue, Jan 29, 2013 at 04:46:58PM +0000, Woodhouse, David wrote:
> > If we're really going to have many different architectures depending
> > on different versions of GCC for this (if it wasn't sane to use
> > it from 4.4/4.8 when it got introduced, and depends on some later
> > arch-specific optimisation), then perhaps we'll have the arch
> > provide the corresponding required GCC_VERSION for using each of
> > 64/32/16 bit builtins, instead of just a yes/no flag? Or just define
> > __HAVE_BUILTIN_BSWAPxx__ for itself, perhaps?
> 
> Damn, there's already the __powerpc__ thing in there.

That's different though. That's because GCC didn't have a generic
__builtin_bswap16() until 4.8, while PowerPC got it in 4.6.

That's a relatively simple and manageable one-off arch-dependency. But
once we get into a mass of "well, it wasn't actually *usable* for ARM
until 4.9", we start wanting to push it into arch code.

> But I liked your other suggestion better to get the offending
> compilers fixed.

That wasn't an *alternative*. It's required if the compiler is doing
something suboptimal, whatever happens. And then we start to *use* the
compiler from the first version that's known to be fixed.

-- 
                   Sent with MeeGo's ActiveSync support.

David Woodhouse                            Open Source Technology Centre
David.Woodhouse at intel.com                              Intel Corporation



-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 4370 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130129/f29c0f6f/attachment.bin>
