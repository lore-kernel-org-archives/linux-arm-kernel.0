Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCB8C282C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:01:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BC0E218D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TZt2eEDg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BC0E218D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=X9kN8tysqlhwSsz5KwyinrRYsAUWPOkflO2+GYsOQ88=; b=TZt2eEDg3wB+XI
	ajiSwUb8sDtXzpgOV8U9wSFtI4Rq+ckF/4GFqN5VM7Hp3YxV9W8pGQCxnZSlAcZmSf2G+4DerY2em
	ygR69F9+3z2KZl+dqUAZXfJZzwXZq5Ic1qYzgobGEqrEVg9eR4Ld6wwXsAFpXJeLpDoDTGcaiCb8Y
	O30puQhCi7mlIN9YowH30LKzeXLVZW8f16gwQAffB34CM7GidruAQ66y1USD4Eg49Qtmpzqje/and
	8xnoaVZ85k8nCDox9pyx5x+SCn0YSh4dEg1x7qjmdL5q/et+pZKnkjqYWmTNHoRkBVLoa3xLv5an7
	UgjE7wLwDsFqHIpfeEqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmyIH-0003ov-5k; Fri, 25 Jan 2019 10:01:01 +0000
Received: from orcrist.hmeau.com ([104.223.48.154] helo=deadmen.hmeau.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmyI8-0003o5-TN
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 10:00:59 +0000
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
 by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
 id 1gmyHi-0004lp-GK; Fri, 25 Jan 2019 18:00:26 +0800
Received: from herbert by gondobar with local (Exim 4.89)
 (envelope-from <herbert@gondor.apana.org.au>)
 id 1gmyHR-0007Vp-TN; Fri, 25 Jan 2019 18:00:09 +0800
Date: Fri, 25 Jan 2019 18:00:09 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: David Howells <dhowells@redhat.com>,
 Tudor Ambarus <tudor-dan.ambarus@nxp.com>,
 "David S. Miller" <davem@davemloft.net>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@st.com>,
 Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
 Aymen Sghaier <aymen.sghaier@nxp.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Gary Hook <gary.hook@amd.com>,
 Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 keyrings@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, qat-linux@intel.com
Subject: Re: [RFC PATCH v2] akcipher: Introduce verify_rsa/verify for public
 key algorithms
Message-ID: <20190125100009.i2ggpc7k7qvzayvj@gondor.apana.org.au>
References: <20190116164703.9267-1-vt@altlinux.org>
 <24887.1547658740@warthog.procyon.org.uk>
 <20190116182719.j6ii6nmn4ciiurqr@altlinux.org>
 <20190118204100.6o3ovctanb62nvd2@altlinux.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190118204100.6o3ovctanb62nvd2@altlinux.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_020053_273825_F224A212 
X-CRM114-Status: UNSURE (   9.35  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 18, 2019 at 11:41:00PM +0300, Vitaly Chikunov wrote:
>
> a) RSA verify works differently (is it just disguised encrypt),
> b) We have separate wrapper module for it (pkcs1pad). Thus:
> 
> Old API can not be removed. In other words, we can not replace
> .verify_rsa with .verify in these drivers or PKCS1 will not work.
> 
> We can replace .verify_rsa with .verify in pkcs1pad, but there is no
> need for that if we stay with two API calls, which we can't avoid.

I think having two API calls during a transition period is fine.
But it must not be the long-term outcome.

In order to keep existing drivers working, I think we should make
the API wrap the legacy verify_rsa and implement verify directly
on top of it.  IOW the driver remains unchanged for now but the
crypto API code should provide a verify API that is implemented
on top of the driver's verify_rsa call.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
