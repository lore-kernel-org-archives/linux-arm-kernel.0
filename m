Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9291C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 14:58:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A196120865
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 14:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KwPvXp8T";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kzW+2FAO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A196120865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y9gEXeVNC11/3trygqm/SFS32AyUd5kx2chPQ5nVg20=; b=KwPvXp8TsVUYaU
	7O9XVjxfQsS+MF/atIfriaDksGPGbwYIxgA9ucICdIRvV5rPOhxWEyoLjArr1PNUnW8bw6+j+MzS1
	RYqANpUuB2lmNN+EEitmpILMv0K7Q+jxWaZKkwKa+qfvYZGzqkpUg5/kXuwXYKjc93Jdvh5WVK99d
	JpFYn34fOwGpUlF//XaBFDLvR1/rSpsYBf50V2PjLJpcupvvJdeaIeKZoaOCBbc+zNGGU8lVhGYJx
	bbWUCqfwyfxYgxD+5m5atU2g5b6W+ohrX/h2W2lViO5vTd1Ms92PjpMxYI5CrRswi/GZO2GD+4woc
	DGG2OL1FMXiiGJlmK2Pg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gW0XQ-0005cb-B2; Sun, 09 Dec 2018 14:58:32 +0000
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gW0XH-0005Q0-JQ
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 14:58:30 +0000
Received: by mail-ot1-x342.google.com with SMTP id f18so8072112otl.11
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 09 Dec 2018 06:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ltVeZ/P0fjNFoHs2uLxtUuxFtbSdGvlCvYAVu+C1jHQ=;
 b=kzW+2FAOszZhqRq21zKhBEN9yDSNxY2sefaEGTxs1W8np3y3DWg6hmnowQQATcpog9
 JLtPr1OsGWKif3CDX5741vAxicE+Hdt/4NQih1VgqVXfrFCnCKDsfgGh4pSEU/hccJEA
 Pl6MIdldNNqQNOQ/badZuT2D0iS/b5tA8uhZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ltVeZ/P0fjNFoHs2uLxtUuxFtbSdGvlCvYAVu+C1jHQ=;
 b=Wbrd5NvCpJmfUXKlfl/0h/m4ebDvohOqieQ+J2tEBQ/4hLPnBMe0SERffLG+luefZE
 hQXqqt9tnhFtFOpL2amdC8L6oHlOvhbPStWk3GBfmB8vfNydcH305HhqJ9bymmxsGIWg
 wfa5miWGa4nNSEWa9iqWG0yjJa4Hi/ImLJKwyAt8mRDD+GHV+q0sW/Xz6mx4b/aBGtuz
 iHHqA3F2Ka0Jy6NNu0afn/7jaSDbK1P1lVvBCSd2NbYCnQCmzOhZd8Y6Sd+zawEroi5e
 KFzLstcIrCFLVuZbWI7hf7AELb68/m615ZaCgVH49ZAYf0jQIs1u72MtjJFv1fd5Yibv
 19dg==
X-Gm-Message-State: AA+aEWY40TgGNdoHS/TKs+neBO4BNDMcw+47Mx1FHMOKJKdKpkHXXCH+
 k5R4zqFwdpaTwdRhRr0TjLpbZA==
X-Google-Smtp-Source: AFSGD/VdxKTolqnSzuBHpTys/odbEWXjAVQbXfqpD3xsp+21suaHSQlCcI4wkzE1zjio1lBVBEIzUQ==
X-Received: by 2002:a9d:5e8c:: with SMTP id f12mr6731220otl.343.1544367491069; 
 Sun, 09 Dec 2018 06:58:11 -0800 (PST)
Received: from cloudburst.twiddle.net ([187.217.227.243])
 by smtp.gmail.com with ESMTPSA id l204sm4570498oia.54.2018.12.09.06.58.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Dec 2018 06:58:10 -0800 (PST)
Subject: Re: [PATCH v6 06/13] arm64/cpufeature: detect pointer authentication
To: Kristina Martsenko <kristina.martsenko@arm.com>,
 linux-arm-kernel@lists.infradead.org
References: <20181207183931.4285-1-kristina.martsenko@arm.com>
 <20181207183931.4285-7-kristina.martsenko@arm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <12e20237-a6a7-bb4c-ad34-7b645a50e680@linaro.org>
Date: Sun, 9 Dec 2018 08:58:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181207183931.4285-7-kristina.martsenko@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_065824_067673_056F5B12 
X-CRM114-Status: GOOD (  16.64  )
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
> So that we can dynamically handle the presence of pointer authentication
> functionality, wire up probing code in cpufeature.c.
> 
> From ARMv8.3 onwards, ID_AA64ISAR1 is no longer entirely RES0, and now
> has four fields describing the presence of pointer authentication
> functionality:
> 
> * APA - address authentication present, using an architected algorithm
> * API - address authentication present, using an IMP DEF algorithm
> * GPA - generic authentication present, using an architected algorithm
> * GPI - generic authentication present, using an IMP DEF algorithm
> 
> This patch checks for both address and generic authentication,
> separately. It is assumed that if all CPUs support an IMP DEF algorithm,
> the same algorithm is used across all CPUs.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/cpucaps.h    |  8 +++-
>  arch/arm64/include/asm/cpufeature.h | 12 +++++
>  arch/arm64/kernel/cpufeature.c      | 90 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 109 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
