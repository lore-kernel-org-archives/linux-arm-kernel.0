Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FSL_HELO_FAKE,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4EEC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:58:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2C162146D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 17:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IWPxsmbL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdz86olg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C162146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AH6PG7T4s2zanLUMvTZDIQGMr4Bb7dg2SEg92mUh8gc=; b=IWPxsmbL+rjyV2
	v6EFXK1p7O1Wef2Z11/gYsJedUWzMY9Ot6X5zC6DXDaGxFFgP1FHTaJ/UiuYID9XyOFzfPQ9rsZzL
	LzmeUKFGLPdKRcPqmMDVAoEuNVMBnLxwShauj+jIANO/vY2ZtLt/4Uw4K25ycpW2/lhSwTTtOpfY3
	VRWY8O+aVL964bp9o9SqYlTyRE/Jzr/62ouUIoLNiJdx/qvPiEXFy4kJfHVJBMKUnhtpew2eTDyAR
	FUeHCLnEHq6EnQlu6EJ/5Z1j/vGzuTQtzBw1WYKSomRj5eNP3C90JE0G+IoD7az4Eh24pU3jZSJBb
	Pkiqx6GumaG2CrIf9I4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSn3y-00053K-OE; Fri, 30 Nov 2018 17:58:50 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSn3Q-0004rY-C7
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 17:58:22 +0000
Received: from gmail.com (unknown [104.132.1.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4853620834;
 Fri, 30 Nov 2018 17:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543600685;
 bh=YUM7HXgxbQCLX+SU5jHzJJ4IAUHEHp/OdtRCPJKsd3s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mdz86olgqb9M71SDZhKF6VOHFdRrw0sGasaXR2hPtLLNmAvS06Fyu80MalgNEc97/
 mrtytNm6xwsNljiAfhBamOtR87Rdqqnwu5vkq/KdC1UM5cLL7JvYdQ8jJtM4kR56wX
 eRaJLoCn6LQ95FzreSi0ouABnsfkVQMIZLihfV50=
Date: Fri, 30 Nov 2018 09:58:03 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v4 00/14] crypto: Adiantum support
Message-ID: <20181130175802.GB135453@gmail.com>
References: <20181117012631.23528-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181117012631.23528-1-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_095816_570319_8A0896EF 
X-CRM114-Status: GOOD (  11.76  )
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
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>, Greg Kaiser <gkaiser@google.com>,
 Tomer Ashur <tomer.ashur@esat.kuleuven.be>,
 Samuel Neves <samuel.c.p.neves@gmail.com>, linux-kernel@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Paul Crowley <paulcrowley@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Nov 16, 2018 at 05:26:17PM -0800, Eric Biggers wrote:
> 
> Therefore, we (well, Paul Crowley did the real work) designed a new
> encryption mode, Adiantum.  In essence, Adiantum makes it secure to use
> the ChaCha stream cipher for disk encryption.  Adiantum is specified by
> our paper here: https://eprint.iacr.org/2018/720.pdf ("Adiantum:
> length-preserving encryption for entry-level processors").  Reference
> code and test vectors are here: https://github.com/google/adiantum.
> Most of the high-level concepts of Adiantum are not new; similar
> existing modes include XCB, HCTR, and HCH.  Adiantum and these modes are
> true wide-block modes (tweakable super-pseudorandom permutations), so
> they actually provide a stronger notion of security than XTS.
> 

In case anyone is interested: Paul and I have made some improvements to the
Adiantum paper and have updated the preprint at the above link.  The algorithm
is still the same, but explanations have been improved and the proof has been
redone using a different technique that is easier to follow.  It also matches
the version that will be published in IACR Transactions on Symmetric Cryptology
(ToSC) Volume 2018 Issue 4.

All versions of our paper can be found at https://eprint.iacr.org/2018/720, and
the .tex source is at https://github.com/google/adiantum/tree/master/specification.

- Eric

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
