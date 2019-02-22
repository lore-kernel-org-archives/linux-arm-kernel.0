Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30624C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:01:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01CB820818
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 12:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IV6Qy7Dv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01CB820818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pdXf0JfJWTHCqqXNkfqQ4cH1A/gj1fauI6ANbr1a+AE=; b=IV6Qy7Dv8pQYQM
	SV1NQN/ElCw5It8yqFwXcUfo4jzw2/6xiFkca0Fyfx3tIP42E7KIAOc2DqCVK0FOuXHNfSC0a6RId
	0Mpp/RohnQbzw25JdCasvZb66EDhBuMz1THYbbCvw3412u+bF7OAHnJX2EbJfa0zildpytiimtuMz
	bsGP/c0xqw5jxJia31AhGPxATb2CeTsqvyixWSl14e/WCuE1sMe16vkAbBz2zVDXxxIQIl27QeTBV
	9lTJqxf0/Gi61a/n+0RSy7ZsRoKizoO86Kf68o1m1CTpyNj1zjY3uPee2Y0TmBJyQWfRECTCwLF1S
	QdETFRalEQ07/kk5Wm9Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gx9WJ-0005BO-6K; Fri, 22 Feb 2019 12:01:35 +0000
Received: from orcrist.hmeau.com ([104.223.48.154] helo=deadmen.hmeau.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gx9WF-0005AY-PT
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 12:01:33 +0000
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
 by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
 id 1gx9W6-0000eT-78; Fri, 22 Feb 2019 20:01:22 +0800
Received: from herbert by gondobar with local (Exim 4.89)
 (envelope-from <herbert@gondor.apana.org.au>)
 id 1gx9W0-0007Er-6d; Fri, 22 Feb 2019 20:01:16 +0800
Date: Fri, 22 Feb 2019 20:01:16 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH 0/2] SHA fixes for 32-bit ARM
Message-ID: <20190222120116.wh54vvfrovyb4z4u@gondor.apana.org.au>
References: <20190216135126.17290-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190216135126.17290-1-ard.biesheuvel@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_040132_094643_FE834AA8 
X-CRM114-Status: UNSURE (   9.89  )
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
Cc: ebiggers@kernel.org, linux-crypto@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Feb 16, 2019 at 02:51:24PM +0100, Ard Biesheuvel wrote:
> A couple of fixes for a crash bugs in the scalar SHA code for ARM,
> taken from the OpenSSL project. This is triggered by a binutils
> change, and so they should probably be tagged for all stable (v4.4+) 
> 
> Ard Biesheuvel (2):
>   crypto: sha256/arm - fix crash bug in Thumb2 build
>   crypto: sha512/arm - fix crash bug in Thumb2 build
> 
>  arch/arm/crypto/sha256-armv4.pl       | 3 ++-
>  arch/arm/crypto/sha256-core.S_shipped | 3 ++-
>  arch/arm/crypto/sha512-armv4.pl       | 3 ++-
>  arch/arm/crypto/sha512-core.S_shipped | 3 ++-
>  4 files changed, 8 insertions(+), 4 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
