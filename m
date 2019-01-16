Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371BFC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:12:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06E4820651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U1HSSlHK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06E4820651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-ID:Date:Content-ID:MIME-Version
	:Subject:To:References:In-Reply-To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Jk7OFV1AxRj6D9bKNVFCbFs1L/aKDoW04P5zdLP0ww0=; b=U1HSSlHKW/06++
	YnSgijCOl2G9l8jZ/0kmlaRnpLMON5NRarl+abs3FeIZusVDhgoyvtVWR5ioX8VPYtkNltbQS/dbS
	4GlZIr45rr1sYBBw8Sd29O1vZ++vjnPYjaNZ7UEus6dnDUoT/OhjNqPiVZIHXtE/LnoL6hUQb1zrP
	NU3xDjXY3jdHIYzFYdHJ2jIhfo7bfCSZeH5rH/HAvwyJvZhKoOZFEj5AfZNcXvClwd9swvpPc3D4f
	8DT0lLhnizGEIMrYjUZSODS9Xl+288M4tRHK+wxbeVhSUvvmHJvDTnnoLRyJzfVezPVhFI7mn8Yj1
	1emMRLHJguU88P1labUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjoju-0001QI-SO; Wed, 16 Jan 2019 17:12:30 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjojs-0001Pu-C8
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 17:12:29 +0000
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F40755C9;
 Wed, 16 Jan 2019 17:12:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-244.rdu2.redhat.com
 [10.10.120.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B63405C228;
 Wed, 16 Jan 2019 17:12:21 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20190116164703.9267-1-vt@altlinux.org>
References: <20190116164703.9267-1-vt@altlinux.org>
To: Vitaly Chikunov <vt@altlinux.org>
Subject: Re: [RFC PATCH v2] akcipher: Introduce verify_rsa/verify for public
 key algorithms
MIME-Version: 1.0
Content-ID: <24886.1547658740.1@warthog.procyon.org.uk>
Date: Wed, 16 Jan 2019 17:12:20 +0000
Message-ID: <24887.1547658740@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Wed, 16 Jan 2019 17:12:27 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_091228_430242_0C1D694B 
X-CRM114-Status: GOOD (  14.61  )
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
 =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>, qat-linux@intel.com,
 linux-stm32@st-md-mailman.stormreply.com, Gary Hook <gary.hook@amd.com>,
 linux-kernel@vger.kernel.org, Tudor Ambarus <tudor-dan.ambarus@nxp.com>,
 dhowells@redhat.com, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org,
 Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Umm...  What do I apply this patch to?

In your modified public_key_verify_signature():

> -	sg_init_one(&digest_sg, output, outlen);
> -	akcipher_request_set_crypt(req, &sig_sg, &digest_sg, sig->s_size,
> +	sg_init_one(&output_sg, output, outlen);
> +	akcipher_request_set_crypt(req, &sig_sg, &output_sg, sig->s_size,
>  				   outlen);

Why is the output necessary?  It was there for the decoded hash to be placed
in prior to comparison - but now that's not necessary.

> -	ret = crypto_wait_req(crypto_akcipher_verify(req), &cwait);
> +	ret = crypto_wait_req(crypto_akcipher_verify(req, sig->digest,
> +						     sig->digest_size), &cwait);

I see sig->digest is passed in here.  Should it be passed in in place of
output_sg above?

> -	inst->alg.verify = pkcs1pad_verify;
> +	inst->alg.verify_rsa = pkcs1pad_verify;

Is there a reason that pkcs1pad_verify() can't do the comparison?

> -	.verify = rsa_verify,
> +	.verify_rsa = rsa_verify,

Likewise verify_rsa()?

Granted, this might involve pkcs1pad_verify() dressing up the signature in the
appropriate wrappings and passing it along to verify_rsa() to do the actual
comparison there (ie. what pkcs1pad_verify_complete() does).

> -	.verify = caam_rsa_enc,
> +	.verify_rsa = caam_rsa_enc,

I presume this is the reason - because this reuses its encrypt operation
directly.  But could this instead perform the comparison upon completion, say
in rsa_pub_done()?

> -	.verify = qat_rsa_enc,
> +	.verify_rsa = qat_rsa_enc,

Again, this could do the comparison, say, in qat_rsa_cb().

David

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
