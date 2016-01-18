From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 18 Jan 2016 23:24:57 +0800
Subject: lib: sw842: select crc32
In-Reply-To: <4168537.6I1FVkp3DA@wuerfel>
References: <4168537.6I1FVkp3DA@wuerfel>
Message-ID: <20160118152457.GD717@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 13, 2016 at 11:24:02PM +0100, Arnd Bergmann wrote:
> The sw842 library code was merged in linux-4.1 and causes a very rare randconfig
> failure when CONFIG_CRC32 is not set:
>     
>     lib/built-in.o: In function `sw842_compress':
>     oid_registry.c:(.text+0x12ddc): undefined reference to `crc32_be'
>     lib/built-in.o: In function `sw842_decompress':
>     oid_registry.c:(.text+0x137e4): undefined reference to `crc32_be'
> 
> This adds an explict 'select CRC32' statement, similar to what the other users
> of the crc32 code have. In practice, CRC32 is always enabled anyway because
> over 100 other symbols select it.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 2da572c959dd ("lib: add software 842 compression/decompression")

Patch applied.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
