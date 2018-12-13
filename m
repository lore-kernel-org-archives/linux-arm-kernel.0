Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC72C65BAE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 05:41:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D37C420870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 05:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ew+Iigqc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D37C420870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/lUZ4Pi9/LFRna+zDS9CFUgeQKO6qY4DZQh/kIR2fOg=; b=ew+IigqcIFv211
	d89cI2sTGqTKUPTNPlF814EiAkh4BlR36rC363fgUaV8HRG3J0v/7oDdYhmv/6K1HPoHFZWzffEed
	BsjXiPUDjVDcBP7AItk1WUGSU2WHl1p4drICcSVAjpYhmUZUeaoeIucR26aUBeWGxEteOc3yXj8pc
	UcDnv/HvIvy/tPUN0YaukEywZlhQB9KC7nviBCr+wHpz0ju58pGH6hjIKtM4ZUL+plONitHup4gw8
	8KMKuS98nAtQyjDhvN33N2R7cjhj6znVKdPt108u9rrsbyMd4ybQ6PavlQd8YxqcGzgvTfbcUEQiV
	EdD24y3xCnkOF8sANs4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXJkX-0005PQ-Mg; Thu, 13 Dec 2018 05:41:29 +0000
Received: from mail-lj1-f196.google.com ([209.85.208.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXJkG-0005Ac-UO
 for linux-arm-kernel@lists.infradead.org; Thu, 13 Dec 2018 05:41:15 +0000
Received: by mail-lj1-f196.google.com with SMTP id g11-v6so678708ljk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 12 Dec 2018 21:41:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RdExr9ScLXuFlHdGApBXnvCBZ6A9ybHxgm4qPwl7d2k=;
 b=psobbsvUcSKB9A9zhXdN5W0N6Zy+xTwu9BVl+aNR3LSH4cixjhgWQ/kWdbdDDJXfA1
 KkLBA7rfinfgQGdDTV6zuirDFcAPDiDV4F0n+V5bPYUEb/c6DLCcjwRdoU1GsXPCXGOc
 ESfE3hYNgvqkyQqyr3ebr7g+LYq40Gf3vCvwbg11vs0eKKhsd8pE3Ui/MYB2H2N4zBjo
 x3ZNSi3zGoUqmzD1ZUoOG0zvgT4/fJqUfFa2UJfg7pgCf2uuu/HG//LQCtptXk9JFQ4k
 7dpVjibKmjBoXSmQW4nqLwpFE0TNOEfdHzGPMSUBRNAhuB5v8ZUYCkxxtTwFXicLBHx+
 9V7g==
X-Gm-Message-State: AA+aEWYjMNU4VFlvnzkC3k2nEWUKnnlDAi0M6hbHJsmUudvcK/TfM+kj
 NJ60WWjkWuAKLqX/0RYo7fRHyrsqdCfdgmYpItkrbQ==
X-Google-Smtp-Source: AFSGD/UKbRcPqqrmjvA7OMyV7/LFdCleXnEHfprh/dgWzgLUHUUlCh9tcedPXw9uY+LV1rBfuokboFuwY5riOOR1w8g=
X-Received: by 2002:a2e:9957:: with SMTP id
 r23-v6mr13204805ljj.98.1544679660240; 
 Wed, 12 Dec 2018 21:41:00 -0800 (PST)
MIME-Version: 1.0
References: <1544654224.18411.11.camel@lca.pw>
 <20181213052259.56352-1-cai@lca.pw>
In-Reply-To: <20181213052259.56352-1-cai@lca.pw>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Thu, 13 Dec 2018 11:10:47 +0530
Message-ID: <CACi5LpP+NHa1WQg78xm1y1YM0KXnFJ72pw+YrizxR5y7yt4AiQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: invalidate TLB before turning MMU on
To: cai@lca.pw
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_214112_971647_6EA684C4 
X-CRM114-Status: GOOD (  19.95  )
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Bhupesh Sharma <bhsharma@redhat.com>, Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 James Morse <james.morse@arm.com>, Bhupesh SHARMA <bhupesh.linux@gmail.com>,
 kexec mailing list <kexec@lists.infradead.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi Qian Cai,

On Thu, Dec 13, 2018 at 10:53 AM Qian Cai <cai@lca.pw> wrote:
>
> On this HPE Apollo 70 arm64 server with 256 CPUs, triggering a crash
> dump just hung. It has 4 threads on each core. Each 2-core share a same
> L1 and L2 caches, so that is 8 CPUs shares those. All CPUs share a same
> L3 cache.
>
> It turned out that this was due to the TLB contained stale entries (or
> uninitialized junk which just happened to look valid) from the first
> kernel before turning the MMU on in the second kernel which caused this
> instruction hung,
>
> msr     sctlr_el1, x0
>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  arch/arm64/kernel/head.S | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 4471f570a295..5196f3d729de 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -771,6 +771,10 @@ ENTRY(__enable_mmu)
>         msr     ttbr0_el1, x2                   // load TTBR0
>         msr     ttbr1_el1, x1                   // load TTBR1
>         isb
> +       dsb     nshst
> +       tlbi    vmalle1                         // invalidate TLB
> +       dsb     nsh
> +       isb

This will be executed both for the primary and kdump kernel, right? I
don't think we really want to invalidate the TLB when booting the
primary kernel.
It would be too slow and considering that we need to minimize boot
timings on embedded arm64 devices, I think it would not be a good
idea.

>         msr     sctlr_el1, x0
>         isb
>         /*
> --
> 2.17.2 (Apple Git-113)
>

Also did you check this issue I reported on the HPE apollo machines
some days back with the kdump kernel boot
<https://www.spinics.net/lists/kexec/msg21750.html>.
Can you please confirm that you are not facing the same issue (as I
suspect from reading your earlier Bug Report) on the HPE apollo
machine. Also adding 'earlycon' to the bootargs being passed to the
kdump kernel you can see if you are able to atleast get some console
output from the kdump kernel.

Thanks,
Bhupesh

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
