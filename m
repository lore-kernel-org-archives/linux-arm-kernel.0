From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Wed, 24 Aug 2016 21:19:01 +0800
Subject: [PATCH] crypto: rockchip - use devm_add_action_or_reset()
In-Reply-To: <1471964334-27060-1-git-send-email-sudipm.mukherjee@gmail.com>
References: <1471964334-27060-1-git-send-email-sudipm.mukherjee@gmail.com>
Message-ID: <20160824131901.GD4039@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2016 at 08:28:54PM +0530, Sudip Mukherjee wrote:
> If devm_add_action() fails we are explicitly calling the cleanup to free
> the resources allocated.  Lets use the helper devm_add_action_or_reset()
> and return directly in case of error, as we know that the cleanup function
> has been already called by the helper if there was any error.
> 
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
