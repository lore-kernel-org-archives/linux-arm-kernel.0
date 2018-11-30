Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76BDC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:18:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AFC620863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 10:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MNpgWZbQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LkG9mGoU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AFC620863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SOWqTJJp9UvHKYp22QhrK6quZhh6YyPR6HzlUvv2ZaU=; b=MNpgWZbQcFt9gn
	Q5bsWSzM/qARfa4LO1D05hgZ3AAkM/+CESmHJLw8yc7Fxd7nF8/TgIYFSDKquRoHZt9kgpEsuy14S
	VNRnOBBePwYQioBQLT0zFXiSZxLtLC10ISPaIXdWJx1nBB2UDVP2UBLl+2au+o9I8DrdqzzntqhzM
	fwJcdUWKE8PPwi8HELnpTlT219bD2A9e73Y2rJOfYgJK418MyRC7en0iwB9gpTdYqnQjajkk+HKJb
	EIzQG9R5CW/vg9LKt83iD6Zys8/ns8Ox69Xec5i9xa9NL2sWIc4PtlLfWHP0uVxsiIHdYkaGu3b4s
	45lXm1IakmK4lQleiMmQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSfse-0007MK-Mx; Fri, 30 Nov 2018 10:18:40 +0000
Received: from mail-it1-x132.google.com ([2607:f8b0:4864:20::132])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSfsa-0007JJ-Mk
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 10:18:38 +0000
Received: by mail-it1-x132.google.com with SMTP id x19so8406302itl.1
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 30 Nov 2018 02:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=p8jneZsagBkQHE9JwLesFrnOetb5fp1BmD72CSlp9y4=;
 b=LkG9mGoUQ83EVMEgWP4GgADxswFxSC36pWr7zBu33jxDBPc91DtU96U/SkvGatAKC1
 k3/Aw9+pPb4E4GXVO2rZdbvFLYNsmzBuPLhDnIvgB57hWLhVRA6kLuBpTw4a/F2gSKio
 pOe83bxKZXceU7tJej5b3ZLY+vv3L3BWrrC/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=p8jneZsagBkQHE9JwLesFrnOetb5fp1BmD72CSlp9y4=;
 b=d+yks6fvvTufl2r6jwEpv8o6mnY5imbv92nB0RJgvHhp5WJLbEVjEe6bgbvWYHvDxw
 VVFge/J4MPkyri1SMg4rhpXCVcwrqSA7kVvORFnkr4pNtdgG6ZP7emHD+zWHWtfN64qg
 aSkImMA3buS8d2EiO/IBzsjToIqcy0e1Ngq/hA+j6svU+xythWcls09rCFPMHwQmTCoa
 S37RkC8ojmlIzUY117ER7RitZ7gexJQgaaEmbNhJND2ewdtRwNHNb3WByRjdAf9XyiF4
 RFfBTlBVJND1MEgk2xmOLK2FBHmH5HBiPdwu/cJU7IeEqN5F5RAlsSOtBf9nw5dg9bk/
 OBYw==
X-Gm-Message-State: AA+aEWb9m4+kDnoyitnOK6kzVEEPo+MOHjIzuYl6FuBeuziloobUS46Q
 edSSbcAFesN5qnxwLRVRcbnyeHNizhiU2Hv7k5MarA==
X-Google-Smtp-Source: AFSGD/UFdCGR3a3o7eTBtZvCxmMmrk47pZzVFbowoTRkSlzAQdLElrfQobQZw+vWG26DjHts4Qqc8vOvpNZDuAxEnCk=
X-Received: by 2002:a05:660c:4b:: with SMTP id
 p11mr4788165itk.71.1543573105182; 
 Fri, 30 Nov 2018 02:18:25 -0800 (PST)
MIME-Version: 1.0
References: <CAKwvOd=uhn-PUs==kVGnXg4W6UwuGvSn+EWUzK4Q8wMr9mzFpA@mail.gmail.com>
In-Reply-To: <CAKwvOd=uhn-PUs==kVGnXg4W6UwuGvSn+EWUzK4Q8wMr9mzFpA@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 30 Nov 2018 11:18:13 +0100
Message-ID: <CAKv+Gu9OJ_N+mhdUbZ89kQT=-coqmAEWihVziWTQ3uFDOw1zzQ@mail.gmail.com>
Subject: Re: LLD and CONFIG_RELOCATABLE
To: Nick Desaulniers <ndesaulniers@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181130_021836_760816_9B3AE98C 
X-CRM114-Status: GOOD (  11.57  )
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
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 29 Nov 2018 at 21:50, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> Hi Ard,
> I'm hitting a few different issues trying to link
> CONFIG_RANDOMIZE_BASE=y (KASLR, selects CONFIG_RELOCATABLE) arm64
> kernels with LLD (LLVM's linker).  I've filed a bug:
> https://bugs.llvm.org/show_bug.cgi?id=39810, and am getting feedback
> from various LLVM folks, but thought you might be able to provide more
> insights?
>

The -pie -shared thing can be dropped, I suppose, given that it only
affects debugging of KASLR kernels, and since the patch in question
clearly shows that ld.bfd also changed from ET_DYN to ET_EXEC for PIE
targets, and so it is obviously a gdb issue. So I'll ack a patch that
reverts that.

As for the __efistub_ prefixes, I wonder if we still need that after
1212f7a16af492d59304ba3abccbcc5b5e41423e ("scripts/kallsyms: filter
arm64's __efistub_ symbols")

So i think discarding sections intended for the loader is the only
remaining issue, and that is something the LLD people will hopefully
fix?

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
