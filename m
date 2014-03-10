From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 10 Mar 2014 20:22:11 +0800
Subject: [PATCH] crypto: mxs-dcp: Optimize hashing
In-Reply-To: <1393850430-5855-1-git-send-email-marex@denx.de>
References: <1393850430-5855-1-git-send-email-marex@denx.de>
Message-ID: <20140310122211.GG10556@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 03, 2014 at 01:40:30PM +0100, Marek Vasut wrote:
> Optimize the hashing operation in the MXS-DCP by doing two adjustments:
> 1) Given that the output buffer for the hash is now always correctly aligned,
>    we can just use the buffer for the DCP DMA to store the resulting hash.
>    We thus get rid of one copying of data. Moreover, we remove an entry from
>    dcp_coherent_block{} and thus lower the memory footprint of the driver.
> 2) We map the output buffer for the hash for DMA only in case we will output
>    the hash, not always, as it was now.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>

Patch applied.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
