Return-Path: <SRS0=mu0f=QD=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89F9C282C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 09:10:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB6742148D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 09:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Wss2+ET0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WBorixOo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB6742148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DO/v2zlC/m3xMFOEvYWeBqPP3AvUUdiYPMZ+tnrf96g=; b=Wss2+ET0zFhkO1
	2KFllLLmrFBfDUyZHehtjQ7duVZ+XlWM08PGFJbluY16oFWJip2o+/Aj1fRVNXq8iNvv4JULdKEpH
	/cOA4iRwTtZS9d780Jzu1MHXhtmTT0iWLkHrUZyCQmiURQEN74fddiKPCr6xXfXNu4+sCUY3LTuYI
	qVgVje2G/wnA3dF0jqaHxdvsy2A43zAo3LeBq4wxgXgi+4eE/j/ATeYQa8f0VZrvUpPl2k+Pi9UGJ
	uUuvCQoxjOFz7B62JkRGIRgaAX3oyRCWLjVLIsjq+ToHs2HrFzmOz99F9rkUD3OLiHL+85yhkjFN5
	5K7EBRhPdgDCrz6UQLrg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gngSd-0007mi-S1; Sun, 27 Jan 2019 09:10:39 +0000
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gngSa-0007mA-0n
 for linux-arm-kernel@lists.infradead.org; Sun, 27 Jan 2019 09:10:37 +0000
Received: by mail-it1-x143.google.com with SMTP id b5so15401183iti.2
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 27 Jan 2019 01:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LM8bj7p/lfjMdMYHTyfAr7tTR3nI20UMCrTrK0viarY=;
 b=WBorixOoN5g7truf1h3BG8owdeFxLRddNDLJaKKRbPfKXgFEYkMB7uw7ubwkzwCkyZ
 Cv5YX7wgHDFGehSGJHgK+Ymc/qs4nyldfluBoJbJUbOQGiGlKo1Pp0857JbQL6b/J+Wh
 5fiG34ZsTDtuTF2l3My59JZUriiMpa8sNy6fo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LM8bj7p/lfjMdMYHTyfAr7tTR3nI20UMCrTrK0viarY=;
 b=hJiSjh48ReZlW2rdjeSY66DB6mCiQSMJlCCfTyCk4aB/o6hca1CHBV6B4j+C5ykZ4x
 xflTXpWNIIJOHlBYgWyw2KmglUTnxUnz60eNrua42yj8yfsTUTPHgjGqLb7vdJq36ntv
 DsgDkXIz2lj938aUVIcnFV+SFyZbntiSAx4XkWzDce130eO891qLUhw04JxEMXsYV0ko
 bVWyqoOMQQzSg669Pw167UcDH0Fv+YqaPFqjAH+6nTSr/vBA3PUxBfnNNnWTfoQTiWSI
 P4bKZm6o8GuVwQCk5UQgRZKS5yazjOk/mqQlkEGnHYH0/WxQWGXswSmUew1QRyRbw+1J
 B07w==
X-Gm-Message-State: AJcUukfy826S9k8eE4Ynzw7818HkyYT+d7hYbr283kgncNWrUk8boa/p
 vO4Y3LE5PbvvBiVqcNp6mnI053dGVncyl+nu6iDXnw==
X-Google-Smtp-Source: ALg8bN7IXRD8FMzyAbxNN7PyUMyy4q08/zCiTPaUH52uziTxFwZaqQNSklyQmxJYoFKgPiE/wf/Xbmh7Ghyk+EhUzio=
X-Received: by 2002:a02:4c9:: with SMTP id 192mr10720981jab.2.1548580234791;
 Sun, 27 Jan 2019 01:10:34 -0800 (PST)
MIME-Version: 1.0
References: <20190125084915.25411-1-ard.biesheuvel@linaro.org>
 <20190127000752.GC709@sol.localdomain>
In-Reply-To: <20190127000752.GC709@sol.localdomain>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Sun, 27 Jan 2019 10:10:22 +0100
Message-ID: <CAKv+Gu-cbfgC=jtEwDB=ozxgf1cty5wzHg+ZMAnMN518jbsy0g@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] crypto: fix crct10dif for ARM and arm64
To: Eric Biggers <ebiggers@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190127_011036_073712_77E7F7E6 
X-CRM114-Status: GOOD (  12.44  )
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
Cc: "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sun, 27 Jan 2019 at 01:07, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Fri, Jan 25, 2019 at 09:49:11AM +0100, Ard Biesheuvel wrote:
> > Fix the issues in both NEON implementations of the CRC-T10DIF routines,
> > that were reported by Eric's new testing code.
> >
> > v2:
> > - keep alignment specifiers where possible (#1)
> > - clarify/fix commit log (#2)
> > - add fixes/cc-stable/etc tags
> > - add patches that drop the now unreacheable code (#3 - #4)
> >
> > Ard Biesheuvel (4):
> >   crypto: arm/crct10dif - revert to C code for short inputs
> >   crypto: arm64/crct10dif - revert to C code for short inputs
> >   crypto: arm/crct10dif - remove dead code
> >   crypto: arm64/crct10dif - remove dead code
> >
> >  arch/arm/crypto/crct10dif-ce-core.S   | 27 +++++---------------
> >  arch/arm/crypto/crct10dif-ce-glue.c   | 23 +++++------------
> >  arch/arm64/crypto/crct10dif-ce-core.S | 11 --------
> >  arch/arm64/crypto/crct10dif-ce-glue.c | 25 +++++-------------
> >  4 files changed, 19 insertions(+), 67 deletions(-)
> >
>
> In the commit message of patches 1-2, "more than 16 bytes" should be
> "at least 16 bytes".
>
> Otherwise for all 4 patches:
>
>         Reviewed-by: Eric Biggers <ebiggers@kernel.org>
>

Thanks Eric. I'll update and resend.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
