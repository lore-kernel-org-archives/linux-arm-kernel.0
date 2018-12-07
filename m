Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D3DC64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:40:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17E0720868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UjhXcJSw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W/XTNOIQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E0720868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bc3i0PGcIIW6U8XMW7keNFGJkIRttFaA4pBn7kwFEFU=; b=UjhXcJSwEDELp4
	yvsc3xeaI1Tf+05n3hAOEpsb8EUM+OH7WmhTMkUPo3lm4vbVtonU5QUdwkgfhR/642/T5uAvFpWIi
	uJJBeBi4VLTUGD4aNaaM9IiIHvysedBfKJskDuvXBVdSJgdsNLnFs6e3Idx+/AuzQU1DonkOeXNuG
	zc5KaplUciWVM03BgclCLL5/DKfL50FLjkmnOtUYewaAnQb2fFK+d2ZEi2aJE38fiEWhlgQkqwF+W
	B038kWwLRogvukLzpgAkTIuo4hjZiq6A1mgy08jS7th3AHvYPq5xwYkP2tDxBRwQlQaT9K74NbGAT
	FZAU9u1gc6om3HQJmhMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVFQW-00085t-IE; Fri, 07 Dec 2018 12:40:16 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVFQS-0006nY-IA
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 12:40:13 +0000
Received: by mail-lf1-x144.google.com with SMTP id i26so2940214lfc.0
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 04:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wzt3ti5tXkWTxZxjywBygWxo7yIsI+D4X+mLAkTLH9w=;
 b=W/XTNOIQl+bsqceahhepp8wUSGiMw164P6me0NkHYN7yXciAgKTtFOOQsjZabRii4O
 urwPHj46z804GUL+/To7fLtU32x5LDTOmv79QJAueT053E22hNkVC1yuWETw+J7ZZxui
 TgaDFQFrxYeVDLDdKsKWvwJVYpEqx52VHVF1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wzt3ti5tXkWTxZxjywBygWxo7yIsI+D4X+mLAkTLH9w=;
 b=RxNPnaYuk7l1igcNAzlq7wdJHxbqZ4JSDdEHhrRhkYZGM76kWXuQ14geIlPn91D+fl
 ExsWNwEw7v/tIY5Wkoy+rMArvJJSpT5SkKBzQtE9SNlwgqqCzUhq5BgX0TNapRUI5w7L
 ZUPACtAO5/jq2kPavz+n8CVZlECN5fFEMDDhIzTPGVWyphgM7dTZDrM/TtYid3eV8Haz
 mp7+ChNdJDVJATuywtlSmGZsL7g1/Iaw+BZXteFrvwvOJ6MQ5Be9pX+gIeQlmApQLcyB
 I4bpTstH1jlyDpbxQ6GDEHOgiX00sGOIgWKaIZyGfW98ghVOdc+kw2c0nVMbsG5534ud
 Ollw==
X-Gm-Message-State: AA+aEWYBWcIMXN55w2WvgDjrJT8WuqxcFHFLVgLiuPuzaWdbl8HHLMym
 VxrBj+rdfQ8ImTe5IWekZtSszsNRvvX/wB4j1gB+Ww==
X-Google-Smtp-Source: AFSGD/WlWY2IyFk7hYAwfeM5/GRYheDnnV5W4vb8yprhxYigAMLXRGkjZ75GEb7eT/FN9sBpOzeet80WxnL6cbfRyts=
X-Received: by 2002:a19:8d01:: with SMTP id p1mr1156549lfd.149.1544186400410; 
 Fri, 07 Dec 2018 04:40:00 -0800 (PST)
MIME-Version: 1.0
References: <1544014419-5028-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1544014419-5028-1-git-send-email-yamada.masahiro@socionext.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 7 Dec 2018 13:39:48 +0100
Message-ID: <CACRpkdZ=0meoCt6LojLj6LRx9n+W1NaJYCk7LVv-6Pxn1UpJoA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: uniphier: convert to SPDX License Identifier
To: Masahiro Yamada <yamada.masahiro@socionext.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_044012_599582_C4EEB26D 
X-CRM114-Status: UNSURE (   8.17  )
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
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, Dec 5, 2018 at 1:54 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> checkpatch.pl suggests to use SPDX license tag. I am happy to
> follow it.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
