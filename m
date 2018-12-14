Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D201C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:37:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C2B520879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t997oePS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="lLUFHlMZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C2B520879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0jrIYxjgYVF6U+efawv6QJdFjnhskVe3IJwR48cySzw=; b=t997oePSs30Wp8
	nA4QT/gbinT8WAFtfyvsxgl3WNU46neCM8OCY0ZRD5BzPHhuZkMDQhuecW8E8qo2uu8dL8BaBHfg6
	0bwCxNrfYN+w7QDb0/Lzf57H2prR5S68kqWVxtnP+mHuCNVxkvtaxy7PiIT94/lmJCMIJQBAOeRLD
	8xcfszR+y+aLjJ7OK2Fb+JdGwZuhb1zMtnn3RW5VvDkm3eALqYIkMsyKY+Awh4V6eT/pLPJcyM0cn
	WUl0o8dnL60SmBf73Ek932GGt0s3J36bAMH+WjZYdtWn1m8vwlyfnnSRami0ynK4JAwwQYozju2N0
	WpEriJ41mirSlC0WtOag==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXkqO-0001rM-16; Fri, 14 Dec 2018 10:37:20 +0000
Received: from conssluserg-05.nifty.com ([210.131.2.90])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXkq5-0001Xa-Hb
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 10:37:06 +0000
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com
 [209.85.222.50]) (authenticated)
 by conssluserg-05.nifty.com with ESMTP id wBEAaYYO014088
 for <linux-arm-kernel@lists.infradead.org>; Fri, 14 Dec 2018 19:36:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com wBEAaYYO014088
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1544783794;
 bh=meTjuBm6sFTr2VERfIwVMjSI41p3Nzae54futWY6fdY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=lLUFHlMZLXkulpG57oUhSrGJ+FNwW2uAxfqmixm1eqDXg/4RIH1Vf+Y+JHHZtECVL
 B0rDXxcwhrWszDPWfa6xWt3Ph1Vkjg46GsRxRM23dWRJxcHLADBTREyUOnDPcsQHo+
 k5xaJ/1UYtQc/RH9ZnIF53tj9K2y5oztUAiGfRJFd3/Q9oa6FwTsL+25ZWhD91NWcE
 C2PYEqvCiLdLLRquGsl1a3Y/epJMo9Xz1PUj4SUrNDCxJZxo/cQ3HrIH/Uqhvx3ej1
 JtNDS7N3rBzHN9pU+17Qyxo7ZfOT5gxXfml33EQ7P+6z7TwGTSxfU00pVFb1ZwrJ8a
 p8WwK+Jh0rksg==
X-Nifty-SrcIP: [209.85.222.50]
Received: by mail-ua1-f50.google.com with SMTP id d2so1823232ual.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 02:36:34 -0800 (PST)
X-Gm-Message-State: AA+aEWZwyHQTSHn+4l6Kq91fD+cjBCsjOU2OLCN3daG2q5fymaNyQy6C
 s2FyG7K9WuMesOry/M9WJuEdsX9/zBrdsw4lXBc=
X-Google-Smtp-Source: AFSGD/XDFykXpre42kb1bxTPQh59y4OKWYd5PXGgwWwRkiJSOYH3JRQvLRspXi4VPKbwTG7lryBy4zwMkK2Z6SMj6Dg=
X-Received: by 2002:a9f:3193:: with SMTP id v19mr1056112uad.55.1544783793506; 
 Fri, 14 Dec 2018 02:36:33 -0800 (PST)
MIME-Version: 1.0
References: <1544760112-5378-1-git-send-email-yamada.masahiro@socionext.com>
 <20181214095155.GA1872@edgewater-inn.cambridge.arm.com>
In-Reply-To: <20181214095155.GA1872@edgewater-inn.cambridge.arm.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 14 Dec 2018 19:35:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNATTGxopJJsj=sakmqxwpyETgG7ToS8tm4kLcF2jekNcFw@mail.gmail.com>
Message-ID: <CAK7LNATTGxopJJsj=sakmqxwpyETgG7ToS8tm4kLcF2jekNcFw@mail.gmail.com>
Subject: Re: [PATCH] arm64: replace arm64-obj-* in Makefile with obj-*
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_023702_196775_9A199CE6 
X-CRM114-Status: GOOD (  13.73  )
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
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Will,

On Fri, Dec 14, 2018 at 6:54 PM Will Deacon <will.deacon@arm.com> wrote:
>
> Hi Masahiro,
>
> On Fri, Dec 14, 2018 at 01:01:52PM +0900, Masahiro Yamada wrote:
> > Use the standard obj-$(CONFIG_...) syntex. The behavior is still the
> > same.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> >  arch/arm64/kernel/Makefile | 59 +++++++++++++++++++++++-----------------------
> >  1 file changed, 29 insertions(+), 30 deletions(-)
>
> I'm fine with this patch, but I think I'd prefer to apply it at -rc1 so
> we don't end up with lots of silly conflicts in the Makefile for any new
> files added during the merge window.
>
> Is that ok with you?

Sure!



-- 
Best Regards
Masahiro Yamada

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
