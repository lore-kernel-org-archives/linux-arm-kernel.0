Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4B2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:27:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD48020866
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L/ZHfPpS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD48020866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6rqSq37FaYc9cv0Qp9yrEvmPSU5s+fYLZGyhLGGE+yY=; b=L/ZHfPpSY94n4b
	4D5kW4P6KGOXPBTYSK7tGlBo25w7XJsmRksvCqXhFhjqq0ddHgD7IN/zSOHW5g8cXlRlqiOq6CIGc
	jsN3Wb3hWdisrC3Ex1A9tWrAVkmpkaDcMcm3BWCjQ0Qz/GG4/c2yRVGp2Vy28ke0X2HV8kG2q0Yoe
	01DEEnSCYMBQovfiIoZcdJRRcgfI3kTuTTX3qKTzmOOGnZgvtyyzq8uA+Y4rxPlQBTqQ5MRPR2T/E
	hpHhRNPSUNCEj6d6wkLxOyQ4RnrcJqvlgpSd1/JK+yI8/7ZdGeOovBcBwJgjpetqkvAEAswbeYIb3
	tpifcEk9FROpYou6Aqng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjpuR-0000Ay-Ga; Wed, 16 Jan 2019 18:27:27 +0000
Received: from vmicros1.altlinux.org ([194.107.17.57])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjpuN-0000AI-IU
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 18:27:25 +0000
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
 by vmicros1.altlinux.org (Postfix) with ESMTP id 4316872CC71;
 Wed, 16 Jan 2019 21:27:20 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
 by imap.altlinux.org (Postfix) with ESMTPSA id 2791B4A4A14;
 Wed, 16 Jan 2019 21:27:20 +0300 (MSK)
Date: Wed, 16 Jan 2019 21:27:19 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: David Howells <dhowells@redhat.com>
Subject: Re: [RFC PATCH v2] akcipher: Introduce verify_rsa/verify for public
 key algorithms
Message-ID: <20190116182719.j6ii6nmn4ciiurqr@altlinux.org>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
 Tudor Ambarus <tudor-dan.ambarus@nxp.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@st.com>,
 Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
 Aymen Sghaier <aymen.sghaier@nxp.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Gary Hook <gary.hook@amd.com>,
 Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 keyrings@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, qat-linux@intel.com
References: <20190116164703.9267-1-vt@altlinux.org>
 <24887.1547658740@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <24887.1547658740@warthog.procyon.org.uk>
User-Agent: NeoMutt/20171215-106-ac61c7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_102723_988960_2B4C008F 
X-CRM114-Status: GOOD (  20.83  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Aymen Sghaier <aymen.sghaier@nxp.com>,
 Alexandre Torgue <alexandre.torgue@st.com>,
 Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>, qat-linux@intel.com,
 linux-stm32@st-md-mailman.stormreply.com, Gary Hook <gary.hook@amd.com>,
 linux-kernel@vger.kernel.org, Tudor Ambarus <tudor-dan.ambarus@nxp.com>,
 keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org,
 Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

David,

On Wed, Jan 16, 2019 at 05:12:20PM +0000, David Howells wrote:
> Umm...  What do I apply this patch to?

This should go over "crypto: testmgr - split akcipher tests by a key type"
which I sent at 20190107 to linux-crypto. Sorry for the mess.

> In your modified public_key_verify_signature():
> 
> > -	sg_init_one(&digest_sg, output, outlen);
> > -	akcipher_request_set_crypt(req, &sig_sg, &digest_sg, sig->s_size,
> > +	sg_init_one(&output_sg, output, outlen);
> > +	akcipher_request_set_crypt(req, &sig_sg, &output_sg, sig->s_size,
> >  				   outlen);
> 
> Why is the output necessary?  It was there for the decoded hash to be placed
> in prior to comparison - but now that's not necessary.

Agreed.

> > -	ret = crypto_wait_req(crypto_akcipher_verify(req), &cwait);
> > +	ret = crypto_wait_req(crypto_akcipher_verify(req, sig->digest,
> > +						     sig->digest_size), &cwait);
> 
> I see sig->digest is passed in here.  Should it be passed in in place of
> output_sg above?

(I tried different approaches such as passing additional arguments to
`akcipher_request_set_crypt' or having additional setter like
`akcipher_request_set_aux' just to set value of digest and that should
be used just for verify op.)

I thought passing input parameter in `struct akcipher_request' in the
field called 'dst' could be confusing for users. So this should be an
additional parameter in the request which is never used by any other caller.
Also, it was unknown if this should be scatterlist or not (I choose that
it should not). When it's separate argument to crypto_akcipher_verify()
call user is forced to set it, and there is no cluttering of `struct
akcipher_request' (which is designed to handle just encryption/decryption)
with not needed auxiliary parameters, and because it's very separated
from request parameters which all scatterlists and all other calls
arguments usually are not scatterlists, so this looked like similar
approach to what others do.

> > -	inst->alg.verify = pkcs1pad_verify;
> > +	inst->alg.verify_rsa = pkcs1pad_verify;
> 
> Is there a reason that pkcs1pad_verify() can't do the comparison?

If you agree that we have two callbacks for a full and a partial
verification (I assume you do), why should pkcs1pad_verify do a full
verification if it's allowed to do just partial one, and it's RSA
cipher which have special partial verification designed for them.

So I decided that pkcs1pad_verify should implement verify_rsa api only
and this is beneficial for having minimal code change and somewhat
backward compatible.

> > -	.verify = rsa_verify,
> > +	.verify_rsa = rsa_verify,
> 
> Likewise verify_rsa()?
> 
> Granted, this might involve pkcs1pad_verify() dressing up the signature in the
> appropriate wrappings and passing it along to verify_rsa() to do the actual
> comparison there (ie. what pkcs1pad_verify_complete() does).

If we stay with the two api calls (verify and verify_rsa) pkcs1pad_verify
does not need to do any verification leaving it to the akcipher core.

There is only potential "problem" that pkcs1pad code will not be able to
use other akciphers besides rsa family (implementing only verify_rsa),
but I assumed this is not needed (since only RSA is actually using
PKCS1) and maybe even beneficial restriction.

> > -	.verify = caam_rsa_enc,
> > +	.verify_rsa = caam_rsa_enc,
> 
> I presume this is the reason - because this reuses its encrypt operation
> directly.  But could this instead perform the comparison upon completion, say
> in rsa_pub_done()?
> 
> > -	.verify = qat_rsa_enc,
> > +	.verify_rsa = qat_rsa_enc,
> 
> Again, this could do the comparison, say, in qat_rsa_cb().

Abandoning idea with two api calls (full verify and partial verify_rsa)
will require me to modify code for all these drivers for devices that I
don't have and can't test. So, I choose approach with less new code.

If you think that partial verify api should be completely removed that
change will require much bigger rework. Please tell if you would prefer
that.

Thanks,


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
