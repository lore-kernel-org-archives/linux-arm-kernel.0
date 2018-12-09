Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB5AC65BAF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 14:53:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7011920831
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 14:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gxYKqNwx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CvaoG/fm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7011920831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=K7pwsI1ZK9/9o1d68OkZw6ontp4gJ8n3QmvLvZTfgN4=; b=gxYKqNwxxarvpX
	12k5CqMVYK5rOk2sOd5w1KSXcyW3SV5jBzdAK+yz285DgKGGlUDtlOqm/MRjhZmNSQ4FY1wz7hHsS
	yE0xNjUms6ML3xT7iORmBMIAoDZZ2AoWbFCd/5Q/lGyPm8uqFfAYtYWFW8IhJZGwPs7Xyu33GUkXC
	Se0qlem3h9aFJxFtii6MIiod64zz58JAqsc5oK9HtR5+x5DBwdYVIHLVnW4xWmR0hWCQodz7tPvAu
	gmg5xOTltuvrQvKMd7+Dqv3mgO5yeXRMnQO40PSk6CUQy5Z+CyzH9oJqBeYsz/Zv+SWWiIvrLxAIG
	+7dhKLCj6Ht+KmED2fHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gW0Sg-0003VE-2a; Sun, 09 Dec 2018 14:53:38 +0000
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gW0Sc-0003U3-SY
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 14:53:36 +0000
Received: by mail-oi1-x244.google.com with SMTP id j21so7035676oii.8
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 09 Dec 2018 06:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=l0srbhcHbgQlVQPBg/OmvSTJKddNhV75fpIIOgujBA0=;
 b=CvaoG/fmDfncOFK6yG+4XoSdBzrF6mDuqA1riqO40E1LOhXjNhgw/07jpMbkAK/lf5
 2iiQf3q0zQZ6soCrWxBk02Kv6fQqutTGgNYFlo39WgmjvLnRnqJjDDSLcyXY4LfdqQne
 rCdFOyMj/00B+R1+9O4E3WtTNxM7QiS06iNvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=l0srbhcHbgQlVQPBg/OmvSTJKddNhV75fpIIOgujBA0=;
 b=sI9VnWYSeo5BgKnySEYZ0PuDhlJqGj269h9Ufae6vGiLPMQBVEVYCXR3zdM52U7JmG
 74TZ9+f4b+sr6eNQGK/HsMyDXDD08/x5eYJHTGiok1hczrFns6GiStcd8N8ajSArh/fh
 F6LImEq8FHqcIZ8TK2P+080EVLb4L4TMFmuEHu3rE4aYIvNi0hZB+0AZkvohY2ev9VfZ
 9Lx2qZC1Dgv40Z85xEknFwipqR0RkssZ0laF2yAjFqBzueuWihX8ihjqMd51VXy8lVw5
 JkRP8gCyXbAIlKirDITf6qD8WzXxenMaF8n/4PybYND5ww+84P5G6p+SGPRfCXH29b/t
 VB1g==
X-Gm-Message-State: AA+aEWbOEhBa7iv/aA+2ZWVVTE0seR7OewdTElXR1GQd231YSeEcdSib
 BW2248Z8uqGv/67XH3Yc3bJhIg==
X-Google-Smtp-Source: AFSGD/UVlr0Kv4PvCnMh7I/QBzCULLaJ0qmswwYgcWIcziOm7A6Pi+Hcn0bCIgEeiGGQ1rcE7uK4ag==
X-Received: by 2002:aca:915:: with SMTP id 21mr5566298oij.163.1544367203794;
 Sun, 09 Dec 2018 06:53:23 -0800 (PST)
Received: from cloudburst.twiddle.net ([187.217.227.243])
 by smtp.gmail.com with ESMTPSA id e8sm3987807otq.17.2018.12.09.06.53.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Dec 2018 06:53:23 -0800 (PST)
Subject: Re: [PATCH v6 04/13] arm64/kvm: hide ptrauth from guests
To: Kristina Martsenko <kristina.martsenko@arm.com>,
 linux-arm-kernel@lists.infradead.org
References: <20181207183931.4285-1-kristina.martsenko@arm.com>
 <20181207183931.4285-5-kristina.martsenko@arm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <57966497-d21c-5439-e4ba-d75f5552282f@linaro.org>
Date: Sun, 9 Dec 2018 08:53:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181207183931.4285-5-kristina.martsenko@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_065334_920109_462B44C5 
X-CRM114-Status: GOOD (  16.81  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Jones <drjones@redhat.com>,
 Jacob Bramley <jacob.bramley@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Adam Wallis <awallis@codeaurora.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu,
 Cyrill Gorcunov <gorcunov@gmail.com>,
 Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
 Amit Kachhap <amit.kachhap@arm.com>, Dave P Martin <dave.martin@arm.com>,
 linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/7/18 12:39 PM, Kristina Martsenko wrote:
> From: Mark Rutland <mark.rutland@arm.com>
> 
> In subsequent patches we're going to expose ptrauth to the host kernel
> and userspace, but things are a bit trickier for guest kernels. For the
> time being, let's hide ptrauth from KVM guests.
> 
> Regardless of how well-behaved the guest kernel is, guest userspace
> could attempt to use ptrauth instructions, triggering a trap to EL2,
> resulting in noise from kvm_handle_unknown_ec(). So let's write up a
> handler for the PAC trap, which silently injects an UNDEF into the
> guest, as if the feature were really missing.

Reviewing the long thread that accompanied v5, I thought we were *not* going to
trap PAuth instructions from the guest.

In particular, the OS distribution may legitimately be built to include
hint-space nops.  This includes XPACLRI, which is used by the C++ exception
unwinder and not controlled by SCTLR_EL1.EnI{A,B}.

It seems like the header comment here, and

> +/*
> + * Guest usage of a ptrauth instruction (which the guest EL1 did not turn into
> + * a NOP).
> + */
> +static int kvm_handle_ptrauth(struct kvm_vcpu *vcpu, struct kvm_run *run)
> +

here, need updating.


r~

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
