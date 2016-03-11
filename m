From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 11 Mar 2016 21:16:40 +0800
Subject: [PATCH v3 3/3] crypto: add basic driver for the MXC SCC
In-Reply-To: <1457352005-17457-3-git-send-email-s.trumtrar@pengutronix.de>
References: <1457352005-17457-1-git-send-email-s.trumtrar@pengutronix.de>
 <1457352005-17457-3-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <20160311131640.GA23963@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 07, 2016 at 01:00:05PM +0100, Steffen Trumtrar wrote:
>
> +	if (ctx->ctrl & SCC_SCM_CTRL_CBC_MODE && req->info)
> +		memcpy(scc->base + SCC_SCM_INIT_VECTOR_0, req->info,
> +		       scc->block_size_bytes);

Please ensure that the IV is copied back on exit.  I know many
other drivers currently also don't do this but I'm trying to fix
this so I'd rather not add more work for myself down the track :)

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
