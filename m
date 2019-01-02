Return-Path: <SRS0=RmN+=PK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77ADC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:29:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88D2F206C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CehIcAGq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MD7dpVjV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88D2F206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ATHe5Vq8ANDiObEIJDtCQSBAREx1tm0z7sy1TL3g/Os=; b=CehIcAGq4T+KV7
	T6jiKj6XpIhSqTHEPpHZruPVDsexVK4FjPiXbODFL0TOEXLLnTXrfc8VMMmzurnTq1zb1douNsp9Y
	03oVRQC7ZQ1NUIYHKkwAABBfvDRL49g1w8kcemXaHUhHYFb3GBT7y7kPjMIKU76uykHCLsVVcRKio
	g11Ig8owG1MdE8uchoA2NGssTOwFJobLTfpgWaEPDt7cW3pRdCqe0ObMu7YgqXJGngKpyoJTrTi3j
	jJthWyQS1lCIcjYVc+rnl8yLByElM8spNV4zDw4tVp+otnqz4uyAcOhUGu0UwxzwYem11CzSVkU2X
	6oXhWTXZDtD3rjMFhA6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gep0S-0008NF-2n; Wed, 02 Jan 2019 22:28:56 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gep0O-0008Mu-T8
 for linux-arm-kernel@lists.infradead.org; Wed, 02 Jan 2019 22:28:54 +0000
Received: by mail-wm1-x344.google.com with SMTP id n190so27872202wmd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 02 Jan 2019 14:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fwZRbyaviN93IY7nXuKOUQFrYgp48RlcS0RKnbjTMNk=;
 b=MD7dpVjVLeH/vmBis/Ah1M3oCdppp636zsMf0ujqsfzjqRJw8tTL9RDOmCGXO1Yswz
 2aadjy3F4UfBrx4QU3bfxV6yME9OOeLxP6wxnnNBBUPyK1QcI1nP+jM6cLLaAlA+TabT
 tKQVwxQosvz/T2GANa1VMW5WyuesN3mwbchUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fwZRbyaviN93IY7nXuKOUQFrYgp48RlcS0RKnbjTMNk=;
 b=t7lzXvbh/Is9QQD/NyQiyi3YIr3Z/m3idjkBwEZTmruPL6oiMv+fbLufM3QwF1m9Wc
 8/c+xG45RJTtIVwsYzhTvLiK/wpOE+5X6j8plASD9ZYPOjNcpeIN5wpZYPfkBTeh476Z
 Wm/zwy7qB8xTVVWL8GYM9xYMHHOLC9GSoparfWw1a8iAzUmYPfzSVAJjQlqs6Lr5Ciu8
 BMEH0XUOMOHct/HoLcbXlPqtPDFoZbddOahVuZJdQrk5+GKlB52JVi920woSkXM24a6R
 6cT5SNxKyqu9GF85EoJO1RUULFJE/S/za0aISWIZQrquBmUpDxXX7qXyiBiS/xqsjY4q
 fUCQ==
X-Gm-Message-State: AJcUukeMOOowM6v1c5hnEQU7KjCNmpizfsSdNXeeaxdi1HwWO9p5GCRS
 mMxjlsU8eljD2rO/MqkNsQhasF7rbmUX9Yhdx/AFJJ5+
X-Google-Smtp-Source: AFSGD/WcJsR2MD+3nsXKqRtNWx8PP1/wogzsuKyM3VmmG6AAAacC5Cr91XSB5x04DdkdtG5CsWYO82EfYVRqwUgx1gE=
X-Received: by 2002:a1c:e088:: with SMTP id x130mr34046914wmg.23.1546468130973; 
 Wed, 02 Jan 2019 14:28:50 -0800 (PST)
MIME-Version: 1.0
References: <1546047797-48275-1-git-send-email-zhangshaokun@hisilicon.com>
In-Reply-To: <1546047797-48275-1-git-send-email-zhangshaokun@hisilicon.com>
From: John Stultz <john.stultz@linaro.org>
Date: Wed, 2 Jan 2019 14:28:38 -0800
Message-ID: <CALAqxLWVBjRSihoVH=5rBtX5q7H37-4NFFfy4=MYcKqGtBG2qQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: smp: Fix compilation error
To: Shaokun Zhang <zhangshaokun@hisilicon.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190102_142852_951513_90CDFE73 
X-CRM114-Status: GOOD (  10.10  )
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
 Will Deacon <will.deacon@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 28, 2018 at 5:44 PM Shaokun Zhang
<zhangshaokun@hisilicon.com> wrote:
>
> For arm64: updates for 4.21, there is a compilation error:
> arch/arm64/kernel/head.S: Assembler messages:
> arch/arm64/kernel/head.S:824: Error: missing ')'
> arch/arm64/kernel/head.S:824: Error: missing ')'
> arch/arm64/kernel/head.S:824: Error: missing ')'
> arch/arm64/kernel/head.S:824: Error: unexpected characters following instruction at operand 2 -- `mov x2,#(2)|(2U<<(8))'
> scripts/Makefile.build:391: recipe for target 'arch/arm64/kernel/head.o' failed
> make[1]: *** [arch/arm64/kernel/head.o] Error 1
> GCC version is gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.10) 5.4.0 20160609

I hit this as well this morning!  Thanks for sending this out!

> Let's fix it using the UL() macro.
>
> Fixes: 66f16a24512f ("arm64: smp: Rework early feature mismatched detection")
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>

Looks like this fixes the build issue!

Tested-by: John Stultz <john.stultz@linaro.org>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
