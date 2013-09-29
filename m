From: marex@denx.de (Marek Vasut)
Date: Mon, 30 Sep 2013 00:05:43 +0200
Subject: [PATCH 2/3] ARM: mxs: crypto: Add Freescale MXS DCP driver
In-Reply-To: <21060.16409.341402.552996@ipc1.ka-ro>
References: <1380194306-5243-1-git-send-email-marex@denx.de>
 <201309261604.37168.marex@denx.de> <21060.16409.341402.552996@ipc1.ka-ro>
Message-ID: <201309300005.43296.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Lothar Wa?mann,

> Hi,
> 
> Marek Vasut writes:
> > Dear Lothar Wa?mann,
> > 
> > > Hi Marek,
> > > 
> > > some small comments below.
> > > 
> > > Marek Vasut writes:
> > > > diff --git a/drivers/crypto/mxs-dcp.c b/drivers/crypto/mxs-dcp.c
> > > > new file mode 100644
> > > > index 0000000..c2b35c7
> > > > --- /dev/null
> > > > +++ b/drivers/crypto/mxs-dcp.c
> > > 
> > > [...]
> > > 
> > > > +/* AES 128 ECB and AES 128 CBC */
> > > > +static struct crypto_alg dcp_aes_algs[] = {
> > > > +	[0] = {
> > > > +		.cra_name		= "ecb(aes)",
> > > > +		.cra_driver_name	= "ecb-aes-dcp",
> > > > +		.cra_priority		= 400,
> > > > +		.cra_alignmask		= 15,
> > > > +		.cra_flags		= CRYPTO_ALG_TYPE_ABLKCIPHER |
> > > > +					  CRYPTO_ALG_ASYNC |
> > > > +					  CRYPTO_ALG_NEED_FALLBACK,
> > > > +		.cra_init		= mxs_dcp_aes_fallback_init,
> > > > +		.cra_exit		= mxs_dcp_aes_fallback_exit,
> > > > +		.cra_blocksize		= AES_BLOCK_SIZE,
> > > > +		.cra_ctxsize		= sizeof(struct dcp_async_ctx),
> > > > +		.cra_type		= &crypto_ablkcipher_type,
> > > > +		.cra_module		= THIS_MODULE,
> > > > +		.cra_u	= {
> > > > +			.ablkcipher = {
> > > > +				.min_keysize	= AES_MIN_KEY_SIZE,
> > > > +				.max_keysize	= AES_MAX_KEY_SIZE,
> > > > +				.setkey		= mxs_dcp_aes_setkey,
> > > > +				.encrypt	= 
mxs_dcp_aes_ecb_encrypt,
> > > > +				.decrypt	= 
mxs_dcp_aes_ecb_decrypt
> > > > +			}
> > > 
> > > missing ',' after '}'
> > 
> > Is this a problem? The last ',' is not needed by the C standard.
> 
> The problem arises when someone wants to append another item to the
> list. Without the comma he has to change two lines which may cause
> merge conflicts if two people add different items to the same struct.
> 
> That's why we usually have (unnecessary) commas on the last element of
> a struct initializer (except when they are meant to be the last
> element of course).

Good point.

Best regards,
Marek Vasut
