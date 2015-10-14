From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Wed, 14 Oct 2015 22:28:42 +0800
Subject: [PATCH] crypto: mxs-dcp is an stmp device
In-Reply-To: <6543300.PJNp8A08gY@wuerfel>
References: <6543300.PJNp8A08gY@wuerfel>
Message-ID: <20151014142842.GG17455@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 12, 2015 at 03:52:34PM +0200, Arnd Bergmann wrote:
> The mxs-dcp driver relies on the stmp_reset_block() helper function, which
> is provided by CONFIG_STMP_DEVICE. This symbol is always set on MXS,
> but the driver can now also be built for MXC (i.MX6), which results
> in a built error if no other driver selects STMP_DEVICE:
> 
> drivers/built-in.o: In function `mxs_dcp_probe':
> vf610-ocotp.c:(.text+0x3df302): undefined reference to `stmp_reset_block'
> 
> This adds the 'select', like all other stmp drivers have it.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: a2712e6c75f ("crypto: mxs-dcp - Allow MXS_DCP to be used on MX6SL")

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
