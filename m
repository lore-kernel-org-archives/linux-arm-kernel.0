Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD16C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 06:27:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 295BB20857
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 06:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sIuPKviG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 295BB20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=koNbcppzu2UNPhc3Ujn6glMKMGZR4lmVYg5Nxp69x84=; b=sIuPKviGxFxCpI
	uFAaZwuq7WUnMIj9iqzJIspvjQ7+SDbCMvZ3oQSFrP543uLk2IfVwBzgLepwL5KkOCPfrAZ+EHWYv
	euvGUK0TDCAb2T/GMYL+jHDlbLaSEgwpeT2rdUW34Np87n+v81DTAgCQBRM6CNX2edMtZNJSQVAB2
	GIw451Y7skS9KzC+fDosB4TPzWSIRFO8IoOtZoubBblo55gp7ACAjs8NVscjx2kYAceJQhoboPQ4g
	+WuZ2+wdqwrqkglySVmTEyVHUpm7jC5mYFLSIQUiQ5ruHthCVixyv3eloDTAp0hbx0I6R97TA9B9h
	tWPc1PcyZhL3NcnoCVlg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpSIX-0005E0-V6; Fri, 01 Feb 2019 06:27:33 +0000
Received: from orcrist.hmeau.com ([104.223.48.154] helo=deadmen.hmeau.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpSIV-0005Dc-3l
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 06:27:32 +0000
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
 by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
 id 1gpSI8-0008Kg-27; Fri, 01 Feb 2019 14:27:08 +0800
Received: from herbert by gondobar with local (Exim 4.89)
 (envelope-from <herbert@gondor.apana.org.au>)
 id 1gpSHw-00053z-00; Fri, 01 Feb 2019 14:26:56 +0800
Date: Fri, 1 Feb 2019 14:26:55 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Vitaly Chikunov <vt@altlinux.org>
Subject: Re: [RFC PATCH v4] akcipher: new verify API for public key algorithms
Message-ID: <20190201062655.hmxeqo5hprhcgtfx@gondor.apana.org.au>
References: <20190125180116.13702-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190125180116.13702-1-vt@altlinux.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_222731_340500_D66666E2 
X-CRM114-Status: UNSURE (   9.92  )
X-CRM114-Notice: Please train this message.
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

On Fri, Jan 25, 2019 at 09:01:16PM +0300, Vitaly Chikunov wrote:
>
> @@ -781,36 +780,17 @@ static int tpm_key_verify_signature(const struct key *key,
>  	if (!req)
>  		goto error_free_tfm;
>  
> -	ret = -ENOMEM;
> -	outlen = crypto_akcipher_maxsize(tfm);
> -	output = kmalloc(outlen, GFP_KERNEL);
> -	if (!output)
> -		goto error_free_req;
> -
> -	sg_init_one(&sig_sg, sig->s, sig->s_size);
> -	sg_init_one(&digest_sg, output, outlen);
> -	akcipher_request_set_crypt(req, &sig_sg, &digest_sg, sig->s_size,
> -				   outlen);
> +	sg_init_table(&src_sg, 2);
> +	sg_set_buf(&src_sg[0], sig->s, sig->s_size);
> +	sg_set_buf(&src_sg[1], sig->digest, sig->digest_size);
> +	akcipher_request_set_crypt(req, &src_sg, NULL, sig->s_size,
> +				   sig->digest_size);

It's not clear that sig->digest is guaranteed to be kmalloc memory.
In any case, it's best not to mix unrelated changes in a single
patch.  So please keep the kmalloc on output and then copy
sig->digest into it and put output into the SG list.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
