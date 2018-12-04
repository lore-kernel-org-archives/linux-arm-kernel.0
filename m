Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31FEC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:18:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74C8D20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CYcJCCR9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QfnSE5jT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C8D20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Rc+bp+rot/iu9+uip64Hg3XEUj61r6ArxjJtqIW4dVY=; b=CYcJCCR9iymLv6
	gEelaPw/dBfC5bv4o9coenf2gLdqvXPZzSRYWuWDkSobb81DvPkC6yD2wgecCjqaXOI3KLaqDR90y
	RcQSCH3buTLnxJYqItmK464QXEf9nWKWrmMOk7SAeqGbBn2cTEt9rzWPGokFLs+OU9sXpbHaBMzj1
	Q31lfCB3aqVr6N5kq6u3iggOWqVFWVpxosRkJvh92DSo4cAyEPEtBhulNTHCXXCMLLMgwNy1qfYhL
	OJ8gJfHDFyj5mPLv+Qk6L3b5kmbl17vFzTLHCNdl9YxaD7Jx6nH3a56L5jW93pNSgsCZHsMrbKJoX
	fTAGzJy9a4n45ZtipTrg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUEKx-0006iq-1N; Tue, 04 Dec 2018 17:18:19 +0000
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUEKu-0006SA-78
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 17:18:17 +0000
Received: by mail-it1-x141.google.com with SMTP id h65so15618630ith.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 04 Dec 2018 09:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lF6VDoK3e3izNfqqoHtafJuDqd2WvJPbzL8DwZfzL60=;
 b=QfnSE5jTQANr5AIKuk/OATbVgeAeyRJxEh7piMuDR816Y7FxA7NfP7d3/XVaRAXxJG
 JJAXreJNvmAqGspEZM5qT8LEj76RKDqCFgRQFB4DuTCrMddVpH6/k7x7yiNnA5ZU6Av7
 JTBjHob96bO2oF65Zzb/eJFzq+YWFUAHQnPRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lF6VDoK3e3izNfqqoHtafJuDqd2WvJPbzL8DwZfzL60=;
 b=Co5GPATqYfJOCFToJif296vfMVXdxXVjxVMPApj/6Agdi7p9GGr9+MCK0fYOxqtj46
 PRL5kW2Xp8paCbU8HaNl3NKdHrtPxeH2MvVq8UmhXPECpdEeOup7/PwPREBvLiufUG25
 szitYuqjP7HTZC+B3IQjS2b+P3pPXFAx6r+XBPVQV/zEC8c4mr/jF/Rb9AThKPr/hC+w
 evyKNse5F7WGzYAMgrl+laD12Cth6rd9ByCb8qLDdZIzvH9pULeBS5/D+xyYUqq+An6C
 xY2jlUVn1npZd1ImEGZXWO4UjPzSLBZrkA1G93Mgt9K1eUeXioW7lKmXw5R9paPC42t/
 CImw==
X-Gm-Message-State: AA+aEWZZsBaiDwBTncCwgPAYuxRSwAzF3pfRBWR6UGF5qUoAvMxJiKKB
 JR5cfH6uG2M+4CmsbamhYE/BwXpYA4f6s1EhYYMLTg==
X-Google-Smtp-Source: AFSGD/WgbXiHSw1BchE/jS6TpfmTAt0rSjvgyVN4qZcckLOOYOVAWAYagBvFYw7d9XgDyY4rcIJaQPQZkCQQGWjCfks=
X-Received: by 2002:a02:734b:: with SMTP id a11mr18007924jae.62.1543943884705; 
 Tue, 04 Dec 2018 09:18:04 -0800 (PST)
MIME-Version: 1.0
References: <1543347887-21101-1-git-send-email-will.deacon@arm.com>
 <1543347887-21101-5-git-send-email-will.deacon@arm.com>
In-Reply-To: <1543347887-21101-5-git-send-email-will.deacon@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 4 Dec 2018 18:17:53 +0100
Message-ID: <CAKv+Gu8+GMkZFk88=x12F5h9yS49bDZMf=FCsOftbihGZjv1MQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: cmpxchg: Use "K" instead of "L" for ll/sc
 immediate constraint
To: Will Deacon <will.deacon@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_091816_271227_8A2FA267 
X-CRM114-Status: GOOD (  17.48  )
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
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, 27 Nov 2018 at 20:44, Will Deacon <will.deacon@arm.com> wrote:
>
> The "L" AArch64 machine constraint, which we use for the "old" value in
> an LL/SC cmpxchg(), generates an immediate that is suitable for a 64-bit
> logical instruction. However, for cmpxchg() operations on types smaller
> than 64 bits, this constraint can result in an invalid instruction which
> is correctly rejected by GAS, such as EOR W1, W1, #0xffffffff.
>
> Whilst we could special-case the constraint based on the cmpxchg size,
> it's far easier to change the constraint to "K" and put up with using
> a register for large 64-bit immediates. For out-of-line LL/SC atomics,
> this is all moot anyway.
>
> Reported-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  arch/arm64/include/asm/atomic_ll_sc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/atomic_ll_sc.h b/arch/arm64/include/asm/atomic_ll_sc.h
> index b53f70dd6e10..af7b99005453 100644
> --- a/arch/arm64/include/asm/atomic_ll_sc.h
> +++ b/arch/arm64/include/asm/atomic_ll_sc.h
> @@ -276,7 +276,7 @@ __LL_SC_PREFIX(__cmpxchg_case_##name##sz(volatile void *ptr,                \
>         "2:"                                                            \
>         : [tmp] "=&r" (tmp), [oldval] "=&r" (oldval),                   \
>           [v] "+Q" (*(u##sz *)ptr)                                      \
> -       : [old] "Lr" (old), [new] "r" (new)                             \
> +       : [old] "Kr" (old), [new] "r" (new)                             \
>         : cl);                                                          \
>                                                                         \
>         return oldval;                                                  \
> --
> 2.1.4
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
