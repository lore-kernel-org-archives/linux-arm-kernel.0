Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E33C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 15:04:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D071220865
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 15:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qMIyiSwA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kMkXSqWg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D071220865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=X5Gzc3GcgbhzAvlScE/ORtduMMUuyNA0DULYSN0OVqg=; b=qMIyiSwAUIo9x3
	9JZbeXC2M7qXaXTN1uBZ3t+1GIX2JR6ZYDaITMhCK1TgD4mnRNAvfZeD+dHHlR4UVtdlIIV/tRPXm
	Pm1ssrjt3ZDtfx/NpZKGNsi2p9eoP1qJfXTHlOBFhH1UAUeWk9Zxfq9mqNlYsR7ZzM2iPFB9gXXhJ
	oXu9KklDZCM9Virva6hZduyCwvLy7ddJ6i71q9gD8NRK7LNO3pw8qkadg8ByG6XV4wfiTALSakCvg
	n61k9rqxHKPsEEfnA/LNGvtBHD9kwMR0yieC1wMfwB2JHmYCskMNpGvhEboLr4uB5S8xiQcj2uxM+
	NXwi9qQiE0FrQRoxpruw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gW0cv-00015L-JV; Sun, 09 Dec 2018 15:04:13 +0000
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gW0cs-00014a-Dp
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 15:04:11 +0000
Received: by mail-oi1-x243.google.com with SMTP id y23so7057369oia.4
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 09 Dec 2018 07:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6wAro+aQhZQfz7d2P5D1XHhlS8lnf90w3dPGgeqlEDM=;
 b=kMkXSqWgHQuo0bBX8k6M+WmACOk4S/y836UcpbETC1siw5Gvz4lYQC1WoH1Q6WqPt3
 gMeS2C2ABBNR0lwuIrQpErrPhXKtUDW8q4hWY1DSUj+Sc3lIs0fGlxpTfSw5DwoT2Tb+
 yRz3I6oahNSSReMM8oxQKpFLlt224lNPCRvPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6wAro+aQhZQfz7d2P5D1XHhlS8lnf90w3dPGgeqlEDM=;
 b=qBOU2MmQd3kxh6NAKKjMKiTsQ98gpHzvbXP4FEZMUArtsNR0YhN9iAMDn1cX9b6Cgq
 ElQr9dG6p2NGOGTdYz1YaSIG4joal7yaRybRRw5EpsC6IV5SDdguNN9UAfxpQnH2FNnZ
 375Y7SAOpQRiX5fUHoN+XJY3cZmnsBh6vZEVyKT5KKoV00AJr6EdEL/IY0Kr73FjW/3z
 9e1ha6GPtWpcqR95kjuzMG9uPTTGO0WJcMv/0K5ACrpfvSfva1Val10NnCxVONzi5c0r
 P9nQPHZPQjB/ZvEpMNNYdaVU/2kgJqbn6WldPhF/LRThVhQXpYGKZuj3Lbz/wWBx05Yl
 CA7w==
X-Gm-Message-State: AA+aEWYUI9hG3SxENwacjg6srfReu0o33QQMlVWCYA3YRZvy8uBLsWl1
 ATG8XJoO+90vDN3vJ4AUsAyRow==
X-Google-Smtp-Source: AFSGD/UMwVL2bYP11A0hVnkgJnJKzGhrlVmn4rQIQJv6ICbBTR/l3acLYizkrMaqQvgb7sXR7mBIuA==
X-Received: by 2002:aca:a90f:: with SMTP id s15mr5698057oie.137.1544367839569; 
 Sun, 09 Dec 2018 07:03:59 -0800 (PST)
Received: from cloudburst.twiddle.net ([187.217.227.243])
 by smtp.gmail.com with ESMTPSA id z191sm5945690oig.3.2018.12.09.07.03.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Dec 2018 07:03:58 -0800 (PST)
Subject: Re: [PATCH v6 08/13] arm64: expose user PAC bit positions via ptrace
To: Kristina Martsenko <kristina.martsenko@arm.com>,
 linux-arm-kernel@lists.infradead.org
References: <20181207183931.4285-1-kristina.martsenko@arm.com>
 <20181207183931.4285-9-kristina.martsenko@arm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <2957cf52-498d-ba62-3be7-33c2e9a2f518@linaro.org>
Date: Sun, 9 Dec 2018 09:03:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181207183931.4285-9-kristina.martsenko@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_070410_469311_FD2E405F 
X-CRM114-Status: GOOD (  19.28  )
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
> When pointer authentication is in use, data/instruction pointers have a
> number of PAC bits inserted into them. The number and position of these
> bits depends on the configured TCR_ELx.TxSZ and whether tagging is
> enabled. ARMv8.3 allows tagging to differ for instruction and data
> pointers.
> 
> For userspace debuggers to unwind the stack and/or to follow pointer
> chains, they need to be able to remove the PAC bits before attempting to
> use a pointer.
> 
> This patch adds a new structure with masks describing the location of
> the PAC bits in userspace instruction and data pointers (i.e. those
> addressable via TTBR0), which userspace can query via PTRACE_GETREGSET.
> By clearing these bits from pointers (and replacing them with the value
> of bit 55), userspace can acquire the PAC-less versions.
> 
> This new regset is exposed when the kernel is built with (user) pointer
> authentication support, and the address authentication feature is
> enabled. Otherwise, the regset is hidden.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/pointer_auth.h |  8 ++++++++
>  arch/arm64/include/uapi/asm/ptrace.h  |  7 +++++++
>  arch/arm64/kernel/ptrace.c            | 38 +++++++++++++++++++++++++++++++++++
>  include/uapi/linux/elf.h              |  1 +
>  4 files changed, 54 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
