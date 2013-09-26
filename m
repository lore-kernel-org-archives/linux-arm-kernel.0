From: marex@denx.de (Marek Vasut)
Date: Thu, 26 Sep 2013 16:04:36 +0200
Subject: [PATCH 2/3] ARM: mxs: crypto: Add Freescale MXS DCP driver
In-Reply-To: <21060.9453.908125.71858@ipc1.ka-ro>
References: <1380194306-5243-1-git-send-email-marex@denx.de>
 <1380194306-5243-2-git-send-email-marex@denx.de>
 <21060.9453.908125.71858@ipc1.ka-ro>
Message-ID: <201309261604.37168.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Lothar Wa?mann,

> Hi Marek,
> 
> some small comments below.
> 
> Marek Vasut writes:
> > diff --git a/drivers/crypto/mxs-dcp.c b/drivers/crypto/mxs-dcp.c
> > new file mode 100644
> > index 0000000..c2b35c7
> > --- /dev/null
> > +++ b/drivers/crypto/mxs-dcp.c
> 
> [...]
> 
> > +/* AES 128 ECB and AES 128 CBC */
> > +static struct crypto_alg dcp_aes_algs[] = {
> > +	[0] = {
> > +		.cra_name		= "ecb(aes)",
> > +		.cra_driver_name	= "ecb-aes-dcp",
> > +		.cra_priority		= 400,
> > +		.cra_alignmask		= 15,
> > +		.cra_flags		= CRYPTO_ALG_TYPE_ABLKCIPHER |
> > +					  CRYPTO_ALG_ASYNC |
> > +					  CRYPTO_ALG_NEED_FALLBACK,
> > +		.cra_init		= mxs_dcp_aes_fallback_init,
> > +		.cra_exit		= mxs_dcp_aes_fallback_exit,
> > +		.cra_blocksize		= AES_BLOCK_SIZE,
> > +		.cra_ctxsize		= sizeof(struct dcp_async_ctx),
> > +		.cra_type		= &crypto_ablkcipher_type,
> > +		.cra_module		= THIS_MODULE,
> > +		.cra_u	= {
> > +			.ablkcipher = {
> > +				.min_keysize	= AES_MIN_KEY_SIZE,
> > +				.max_keysize	= AES_MAX_KEY_SIZE,
> > +				.setkey		= mxs_dcp_aes_setkey,
> > +				.encrypt	= mxs_dcp_aes_ecb_encrypt,
> > +				.decrypt	= mxs_dcp_aes_ecb_decrypt
> > +			}
> 
> missing ',' after '}'

Is this a problem? The last ',' is not needed by the C standard.

[...]


> 
> > +static const struct of_device_id mxs_dcp_dt_ids[] = {
> > +	{.compatible = "fsl,mxs-dcp", .data = NULL,},
> 
> missing spaces after '{' and before '}'

Thanks!

Best regards,
Marek Vasut
