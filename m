Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E38C282DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 06:51:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A94C20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 06:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="URLTbIVn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A94C20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cC8mw5g3kU7NN8BPTZZqJm3Vol9SihJ75PQCFMwNFyA=; b=URLTbIVneNX/Jt
	grPvZxrWBo82LTtBBtdIHxpsC8DI6vR1niryKx5o5/p9DPmUlag5mU44cS2EYZy9FYWkWkKMdyWFA
	T2X0pDRC+jcyo3oNIvnEDpyiW0tSbnqTM3XsaQQneBQ1i36KGAEgbzt5Z4Iwqr+T/TbkKBxU4kq9m
	UX+JMZx3Z2PMmktvt726jwo7phYURg0+j+p/WDRLY7yzAYvFUetbmsF02hMzHYmMaDJxqNm/D3LDN
	vFZR9TgJjCyYqoAcA3n+V5/r+9w6YbbFymVXkM7V2Xz00Hk1EVk3VosH2v1VHmkJo1Ge9khnsCORx
	dvUuquI6GUGkBbT72Z6Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpSfv-0005JW-PQ; Fri, 01 Feb 2019 06:51:43 +0000
Received: from orcrist.hmeau.com ([104.223.48.154] helo=deadmen.hmeau.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpSfr-0005J1-CP
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 06:51:41 +0000
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
 by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
 id 1gpSfo-0000FR-4O; Fri, 01 Feb 2019 14:51:36 +0800
Received: from herbert by gondobar with local (Exim 4.89)
 (envelope-from <herbert@gondor.apana.org.au>)
 id 1gpSfo-0005om-0T; Fri, 01 Feb 2019 14:51:36 +0800
Date: Fri, 1 Feb 2019 14:51:36 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH 0/2] crypto: arm64 - expose PMULL variants as separate
 algos
Message-ID: <20190201065135.q2exeugeks3rano2@gondor.apana.org.au>
References: <20190125093627.14288-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190125093627.14288-1-ard.biesheuvel@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_225139_617388_ACFB44F0 
X-CRM114-Status: GOOD (  10.82  )
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
Cc: ebiggers@kernel.org, linux-crypto@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 25, 2019 at 10:36:25AM +0100, Ard Biesheuvel wrote:
> Both the GHASH and the CRC-T10DIF SIMD routines are based on 64-bit
> polynomial multiplication, but fall back to the slower 8-bit polynomial
> instructions if the optional 64-bit PMULL instruction is not implemented.
> 
> This means we can only ever test one of the two on a single system,
> which is unfortunate. So instead, register both versions on hardware
> that supports them, and let the crypto API decide which is the preferred
> one based on priorities. That way, both will be tested, but only the
> fastest available one will be used.
> 
> Ard Biesheuvel (2):
>   crypto: arm64/crct10dif - register PMULL variants as separate algos
>   crypto: arm64/ghash - register PMULL variants as separate algos
> 
>  arch/arm64/crypto/crct10dif-ce-glue.c |  54 +++++++--
>  arch/arm64/crypto/ghash-ce-glue.c     | 118 +++++++++++++++-----
>  2 files changed, 132 insertions(+), 40 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
