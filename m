Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23D9C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:45:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DAC221850
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GHpLhA/h";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="G5UP1RTL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DAC221850
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6lPYNavv3wX0FkXUB4BSNAP2vzneloXL/6KeVSEvarQ=; b=GHpLhA/hpgmwT9
	9nqSYZ+6K0qPKmCqc2DiL9T+RY/TPHWfpdno8QNVM4NTI9zyaC9bAhIztxZkMprZ2aqUkn1oE7IxE
	zAhnIkAElf+MNKh0ix3llJH5XEGIYQ5eCfu1YY4keYuTfdqC7opnuXOXgtwek95I7EyOO1isyLr1K
	9QuYak5rBiruPK3a/0h68kJC/adRcW3+deVMtnfBxUG/FTyNfd4XMg8LbgoR0LRrnziKQfca4Ondq
	j3NS7I9AXJvUGrDa9DDF6cgN/eX10ngGygY5+zW+eYrhOnRhkEYDtEbegqhH71ze2qec/uGCxiyQW
	Or9YuqULm9vAEIbmUcKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyjb6-0005sP-D2; Tue, 26 Feb 2019 20:45:04 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyjb2-0005ZO-1l
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 20:45:01 +0000
Received: by mail-pl1-x641.google.com with SMTP id p19so6803764plo.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 26 Feb 2019 12:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0X8cSYKGmFW0u9F0JjUTNH83/4979FA9fPZEq9ViBiY=;
 b=G5UP1RTLPOXQAR+BvC3a+DybgKcQ6vRPqihPWCSDwt6QQecjUSMXeDyXQ8pdYEBWV6
 kSKe2u73y5ysD5TfJ31iUQBIbngmTJfV3E+/a6yDHVKWBsZ9lOnZH5r+DGh7Oeczfag6
 vXsSyH7DuzTJz1rCShkBQ0G9Vmy70IEpLa9Ls/lyYotXZm8QMpuSiKI18XDjdBB9D0Cq
 BEGrBJHo7kNwc/PlioQ1ZN2XBdDjKzuTdRFMPsQNcRGS9EX3cqX2BV7iL93jN/XwV/TS
 C+t/jLVEjQM2BF5KDPbTlwt5CIu9u6EzhdjQ2Bwyf3fNwlcxmvG3dfIwWPxzbfueB4zT
 IGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0X8cSYKGmFW0u9F0JjUTNH83/4979FA9fPZEq9ViBiY=;
 b=ryoQfAnkM8zLFvUKkid949IcxdNuzraxCLOqnMIZYhW646bsT/QGTdG+KPlOcDUnUU
 Q5O+i7OGnGSGlO7Hy5GJjGZ2y49jzqGDg4EYvb/aukHuNN2f7r+xFs/VOe1CNW1jWr77
 /Qu1lbxU7IgKrnh4jS1PBswfb1pWxFVM3aUlxyMQndFTWhSG3W8IDdAZ3tYEfYOfuU4E
 Ud/rqXOfegigcZk8yoA2zrTKiavXSSZQpcCy4Kg8X1V/pMJFrurMJHyOCEII1LlH6K5e
 xmoOJrUPOGXuXW/USDSX2XuJwGrAcvjEyuY8WFx08c1D67mFxfjWDX0xq+QoQof7eNAP
 8hMA==
X-Gm-Message-State: AHQUAuYotbwqpyQLldFpiKs9gL5US7FQy69fTq0UCBbq8lZa0lA2AKJ3
 Kf7sd2QqgIPUiaqr8ivbBogG8GebhkhA8xYpM9+52w==
X-Google-Smtp-Source: AHgI3Ib3KLull6qPH/TbFZUvMpO7HReopqC+gm/Txs9vUuqy65YewyPIeJ9h1evXEkY7vAgEDPJZfaUFk9kk2kqPe3A=
X-Received: by 2002:a17:902:bb89:: with SMTP id
 m9mr27853522pls.320.1551213895133; 
 Tue, 26 Feb 2019 12:44:55 -0800 (PST)
MIME-Version: 1.0
References: <20190226040345.202047-1-ndesaulniers@google.com>
 <CAKv+Gu-5DvWZL6ogLVNDEvgKe6TENX+5sF1U7QxiyYC8Wx0nXw@mail.gmail.com>
In-Reply-To: <CAKv+Gu-5DvWZL6ogLVNDEvgKe6TENX+5sF1U7QxiyYC8Wx0nXw@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 26 Feb 2019 12:44:44 -0800
Message-ID: <CAKwvOdmzb1WF6NU5LYWGXK_O2cbqwMjbWGAa5xk5x+EMz7A1yw@mail.gmail.com>
Subject: Re: [PATCH] lib/raid6: use vdupq_n_u8 to avoid endianness warnings
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_124500_094117_6F0BC83F 
X-CRM114-Status: GOOD (  17.79  )
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
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, Nathan Chancellor <natechancellor@gmail.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Feb 25, 2019 at 11:19 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Tue, 26 Feb 2019 at 05:03, <ndesaulniers@google.com> wrote:
> >
> > Clang warns: vector initializers are not compatible with NEON intrinsics
> > in big endian mode [-Wnonportable-vector-initialization]
> >
> > While this is usually the case, it's not an issue for this case since
> > we're initializing the uint8x16_t (16x uint8_t's) with the same value.
> >
> > Instead, use vdupq_n_u8 which both compilers lower into a single movi
> > instruction: https://godbolt.org/z/vBrgzt
> >
> > This avoids the static storage for a constant value.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/214
> > Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
> Much better, thanks,
>
> Did you double check that the intrinsic exists on 32-bit ARM as well?
> I assume it does, but please make sure if you haven't yet.

Thanks for the review!
Looking through Clang's generated arm_neon.h, vdupq_n_u8 seems to have
2 definitions predicated on __LITTLE_ENDIAN__ (not __arch64__ or
__ARM_ARCH >= 8 like some of the other types and functions).

So NEON got some additions in v8?  Is there a doc that lists them?
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0491g/BABDBBJB.html
is where I found vdupq_n_u8, but it doesn't seem to mention
compatibility (so I assume it's been around since the introduction of
NEON?).
-- 
Thanks,
~Nick Desaulniers

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
