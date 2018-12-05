Return-Path: <SRS0=T5WJ=OO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C0AC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:48:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60D962081B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SCyUBFrS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RH8qHN55"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60D962081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nx99PGDJFuXbon5B9+eSKx6b/pysZyw4atb0H4m/uJE=; b=SCyUBFrSlD8dl7
	pTk6AhMWV/nujFN6tCx2qu00weTmXOSKptwCqBlO7XBKZNDjvGSrxarg4u4FWamdx0VPUByKwLmdX
	chLipDdMz88DMRDCg61crbdZ7eA90Q0NKwz2m+SlQgJwMaXOzj0fQfZwX8f03k4ijgFjrGEl6s5Bq
	AgzFR3bKZnnxEEf0IGkJ9rBkSNpi/2JThQ8DCUgzeG9bh/4AwX04fk/fFjKMb5F60+Vr8jiVCBvl2
	Y0eWxXL9cBlwzVHjWX2/HkYmuH/YjpqOWyVbaeMepbD2LTD2kh0H7jUGaKO+xuWfEGeD5qhIblKDY
	AihnmsX9yXzP5SNiQnfg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUcDf-0001LQ-4S; Wed, 05 Dec 2018 18:48:23 +0000
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUcDb-0001KC-2k
 for linux-arm-kernel@lists.infradead.org; Wed, 05 Dec 2018 18:48:20 +0000
Received: by mail-yb1-xb43.google.com with SMTP id a67-v6so9029977ybg.1
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 05 Dec 2018 10:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ha+30CfXR6OA1TXPF7n76doZ96fWpsm/eqhYl1bsGMs=;
 b=RH8qHN55Z6d5WPGNRQY1ALJUOt/E1QkcjsZZzHq953iOX4uLhOar7+sPH6Ov98AhmD
 n9krux3dwJzhpYTUwMof6HC1+sCqB9hW02RuayYc+b/qVSV/E8tHlME7ptaQxK5IqPFN
 UaD8GafqS6jPvPVw6AL6MXeslIstP7DduKEAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ha+30CfXR6OA1TXPF7n76doZ96fWpsm/eqhYl1bsGMs=;
 b=T+D2l6k0HdQC/6W5Xil1Xpfc8K7NvNZ+RjsXJCc3GQ6KEbCL9AFBUmznqiPAVBXmjd
 eWwbnMrs8d5oMFQ1xRjAEt5yCg9yAWNsIS7mptI9cCeICXXlQOEUOEdfTX3uKlF0VZVE
 5+hb2C+pJ4IMLClyYc7zJQxh4NceLWw6V4tGZozRQaTcXt8l6UyFaQLwIKZIO1VZ3jXM
 TzJayb6pDlOuC/M7FLL+XYqfTwUm8Uu2fMdBKwItA3AAGMH6vxyreFqdjJ8gU1wLephc
 DJDUuVlkoOSsQnztxVnoxpd/igvWRJPKCxSar9PDMLx35L8Byjt9BBYLww+734hdzZ2i
 gQlw==
X-Gm-Message-State: AA+aEWZdUjZAvi9k9Q/nQfxpsmizmcTfokcvM/Wbr/DkqOlJ0HOvMzG3
 QOScAMpxA8QSOVb1i3EY4jkryEJaJRynNfpuoWLWmw==
X-Google-Smtp-Source: AFSGD/UXhZYeY9L2Q8/xhsm2qJcLkvGFqVeF6Lw6Qyt1UDocGOdo+Dt7Relwvx9M8ujitUCW+0UuEFUTV1/iGdyWuzo=
X-Received: by 2002:a25:ff01:: with SMTP id
 c1-v6mr25241774ybe.325.1544035687437; 
 Wed, 05 Dec 2018 10:48:07 -0800 (PST)
MIME-Version: 1.0
References: <20181205174852.435233070@goodmis.org>
In-Reply-To: <20181205174852.435233070@goodmis.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Wed, 5 Dec 2018 19:47:56 +0100
Message-ID: <CADYN=9KcqcwVc+pzPPEUdFuMuPB9_Xo6FVUJ7tooyvH5aCVqCA@mail.gmail.com>
Subject: Re: [PATCH 0/2] tracing: arm64: Make ftrace_replace_code()
 schedulable for arm64
To: rostedt@goodmis.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_104819_119272_47CEC309 
X-CRM114-Status: GOOD (  14.42  )
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
Cc: Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mingo@kernel.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Wed, 5 Dec 2018 at 19:33, Steven Rostedt <rostedt@goodmis.org> wrote:
>
>
> This is a little more involved, and I would like to push this through my
> tree. Can I get a reviewed-by/ack for the second (arm64) patch?
>
> Anders, can you also test this to make sure that it fixes the issue you
> see?

Yes of course, I'll try them.

Cheers,
Anders

>
> Thanks!
>
> -- Steve
>
>
> Steven Rostedt (VMware) (2):
>       ftrace: Allow ftrace_replace_code() to be schedulable
>       arm64: ftrace: Set FTRACE_SCHEDULABLE before ftrace_modify_all_code()
>
> ----
>  arch/arm64/kernel/ftrace.c |  1 +
>  include/linux/ftrace.h     |  1 +
>  kernel/trace/ftrace.c      | 19 ++++++++++++++++---
>  3 files changed, 18 insertions(+), 3 deletions(-)

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
