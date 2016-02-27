From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Sat, 27 Feb 2016 20:35:32 +0100
Subject: [PATCH 1/2] lib/mpi: avoid assembler warning
In-Reply-To: <1456490794-1034544-1-git-send-email-arnd@arndb.de>
References: <1456490794-1034544-1-git-send-email-arnd@arndb.de>
Message-ID: <20160227193532.GF9123@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 26, 2016 at 01:46:26PM +0100, Arnd Bergmann wrote:
> A wrapper around the umull assembly instruction might reuse
> the input register as an output, which is undefined on
> some ARM machines, as pointed out by this assembler warning:
> 
>   CC      lib/mpi/generic_mpih-mul1.o
> /tmp/ccxJuxIy.s: Assembler messages:
> /tmp/ccxJuxIy.s:53: rdhi, rdlo and rm must all be different
>   CC      lib/mpi/generic_mpih-mul2.o
> /tmp/ccI0scAD.s: Assembler messages:
> /tmp/ccI0scAD.s:53: rdhi, rdlo and rm must all be different
>   CC      lib/mpi/generic_mpih-mul3.o
> /tmp/ccMvVQcp.s: Assembler messages:
> /tmp/ccMvVQcp.s:53: rdhi, rdlo and rm must all be different
> 
> This changes the constraints to force different registers to
> be used as output.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Both applied.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
