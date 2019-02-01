Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49590C282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:09:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C12A20869
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cy6x8Qof"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C12A20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=olBTI8kbB5CLk7d6Ws4BoCHnI+lomxcubd1LhwNbQfY=; b=cy6x8Qofhm2qAw
	Z7oUUbVQl+grHVCyYNNrx6qaShwjGQa0nqWKV2JUe7dy75xbxaiSYjTklvBL5U20ocL/+ttoyOe1X
	qDgKSM5SMxGtY1CX1+vphSoq+t7EGjefWgS/ylK/uvOv1uT6ha+qoxQ3m0E42aZgnfXIVps9onagz
	8xwQFCKkWr1BzmCPGl1uaVQUq46SnddQ+XrU2Z50imQ9Q7/5d1ILSDLh5QnyjPnaV1rmYCXLIFHAP
	03nJyE8M9BRv+5Qhgl4wAOLyxxO5rJZ43iESDeOMIYjMOYsae/ej6gd65dqCbmLp/G7IOd2bLcYkt
	jAbqtvm+BRS5JSQjRzMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpSx9-0003Wz-Ss; Fri, 01 Feb 2019 07:09:31 +0000
Received: from vmicros1.altlinux.org ([194.107.17.57])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpSx5-0003Vk-4h
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 07:09:29 +0000
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
 by vmicros1.altlinux.org (Postfix) with ESMTP id 4480A72CC72;
 Fri,  1 Feb 2019 10:09:23 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
 by imap.altlinux.org (Postfix) with ESMTPSA id 22EFB4A4A2A;
 Fri,  1 Feb 2019 10:09:23 +0300 (MSK)
Date: Fri, 1 Feb 2019 10:09:23 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [RFC PATCH v4] akcipher: new verify API for public key algorithms
Message-ID: <20190201070922.nvopn4kxz7jbcoey@altlinux.org>
Mail-Followup-To: Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 David Howells <dhowells@redhat.com>,
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
References: <20190125180116.13702-1-vt@altlinux.org>
 <20190201062655.hmxeqo5hprhcgtfx@gondor.apana.org.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190201062655.hmxeqo5hprhcgtfx@gondor.apana.org.au>
User-Agent: NeoMutt/20171215-106-ac61c7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_230927_366650_7EDCB89E 
X-CRM114-Status: GOOD (  12.87  )
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
 Gary Hook <gary.hook@amd.com>, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, David Howells <dhowells@redhat.com>,
 keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Herbert,

On Fri, Feb 01, 2019 at 02:26:55PM +0800, Herbert Xu wrote:
> On Fri, Jan 25, 2019 at 09:01:16PM +0300, Vitaly Chikunov wrote:
> >
> > @@ -781,36 +780,17 @@ static int tpm_key_verify_signature(const struct key *key,
> >  	if (!req)
> >  		goto error_free_tfm;
> >  
> > -	ret = -ENOMEM;
> > -	outlen = crypto_akcipher_maxsize(tfm);
> > -	output = kmalloc(outlen, GFP_KERNEL);
> > -	if (!output)
> > -		goto error_free_req;
> > -
> > -	sg_init_one(&sig_sg, sig->s, sig->s_size);
> > -	sg_init_one(&digest_sg, output, outlen);
> > -	akcipher_request_set_crypt(req, &sig_sg, &digest_sg, sig->s_size,
> > -				   outlen);
> > +	sg_init_table(&src_sg, 2);
> > +	sg_set_buf(&src_sg[0], sig->s, sig->s_size);
> > +	sg_set_buf(&src_sg[1], sig->digest, sig->digest_size);
> > +	akcipher_request_set_crypt(req, &src_sg, NULL, sig->s_size,
> > +				   sig->digest_size);
> 
> It's not clear that sig->digest is guaranteed to be kmalloc memory.
> In any case, it's best not to mix unrelated changes in a single
> patch.  So please keep the kmalloc on output and then copy
> sig->digest into it and put output into the SG list.

It is not guaranteed that sig->s will be kmalloc memory either. (Except
we know it for sure like we know the same about sig->digest).

You can see in public_key_signature_free() that both fields are kfree'd
together.

So, I don't understand why we should treat sig->digest differently than
sig->s.

I was just removing kmalloc'ed output as crypto_akcipher_verify() does
not need any output anymore. So, it's not some sort of mixing unrelated
changes, from my point of view.

Thanks,

> 
> Thanks,
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
