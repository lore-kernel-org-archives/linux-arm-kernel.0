From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 17 Aug 2017 17:00:21 +0800
Subject: [PATCH RESEND] lib/mpi: fix build with clang
In-Reply-To: <20170807173120.15463-1-stefan@agner.ch>
References: <20170807173120.15463-1-stefan@agner.ch>
Message-ID: <20170817090021.GC25646@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 07, 2017 at 10:31:20AM -0700, Stefan Agner wrote:
> Use just @ to denote comments which works with gcc and clang.
> Otherwise clang reports an escape sequence error:
>   error: invalid % escape in inline assembly string
> 
> Use %0-%3 as operand references, this avoids:
>   error: invalid operand in inline asm: 'umull ${1:r}, ${0:r}, ${2:r}, ${3:r}'
> 
> Also remove superfluous casts on output operands to avoid warnings
> such as:
>   warning: invalid use of a cast in an inline asm context requiring an l-value
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
