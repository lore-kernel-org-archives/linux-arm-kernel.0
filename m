Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDDBC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 14:55:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BCCB20831
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 14:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hzu3woXh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="c462RHqa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BCCB20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aflcOEyDyu48pzs5CEOyPiPFsD26Xw/9UiTep4uylq0=; b=Hzu3woXhdHPcV3
	fSu+n/U1sXrvbEFehY3pO5zVTh2BAGFJKdmex0gLZD3/ISOJer/CjN+VuEXT6ERU2OS+bnhLdHbZT
	l6UWwaMvpJWo+8CngUd2CwkRG2ekDDnL5WMuQdgFpzdBY9nJOM1SOdd6o8qYJdrafgWdeBdO47DLF
	KdVJVQC3TkpVhy/I3fGtQuB/HlNSbtcYxwL77Z6VOGwuVAxkyyauxjDXhC+327VgsvkLiVvt5+4ag
	EoLpaVsUEDsaa0pPjgJk2vtO5VaHhBiC0Pi66TOWUCaSjje2qBA/JI3xcvMyyiELIiCHZ2kABgvSm
	WWqWyoISTj+xOuX7mzWg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gW0U1-0003rM-8s; Sun, 09 Dec 2018 14:55:01 +0000
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gW0Ty-0003qf-Hq
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 14:54:59 +0000
Received: by mail-oi1-x244.google.com with SMTP id c206so7068651oib.0
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 09 Dec 2018 06:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=8q3h34D+ijHUeMnXl1JgT1WVE0pSvnjtsDGTiKr2glA=;
 b=c462RHqaFAiIp6tR/25rD6U3kKPR4EQ4TrilxO8vggdlc9UBw2QaMC1j+54WQyOVhZ
 BWvpjE/INDonXdYnB0jXLc207GVjhScWe6BzhTuLwbBseclGB7tN/7TinEU3UHwWpgke
 DG1fpEVM45X3tvh0EZqZ2SB3/G04zNvpk4mvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8q3h34D+ijHUeMnXl1JgT1WVE0pSvnjtsDGTiKr2glA=;
 b=qBYZowMOJNirZU2q/oGszHEi5erDQdCNMvLPRHNjB+qHONKlLCoUvQORatoJyDUj34
 ugrt3s9xSf/uYwD6W4zowy5x4hD1h2n8nENC6SWWImEp5SxxHZ4XGmdvpq9CXEvE+kZT
 kkBdOZTToJYIHsuI+tJzaCL7OG64qwb1pwU6OF4jxTLPSjNXDGOoZCR+8NHJfBJo7jwr
 uy+fl9mBLGG7HQO0U0o0fk2Qp/1lPPnlBVzk7PtB+QBL43zNbDmcU04/U1OUabGi2Vgw
 V2N5Wffe3qFFj4Nw4zXJ4uuM3izQz4P0f5OjHfGc5rXm34dEzBI8ZYfNcUOdnyEmTUAd
 i3Cg==
X-Gm-Message-State: AA+aEWbtbaaVhZcZcZG5DdTNSGcy/mN9kJnCDQmWC4/zJSC2VAiCojwU
 MsjaoZeZ4et5+/D8sD+OI/Mr+g==
X-Google-Smtp-Source: AFSGD/WzLU+vINFNDjFJJGJkNgWs2B3+yXn0+sW8yHrtF0s6e+ofa422lrsI0mwHNNGwcxRUtk7MKQ==
X-Received: by 2002:aca:5641:: with SMTP id k62mr5722322oib.339.1544367287779; 
 Sun, 09 Dec 2018 06:54:47 -0800 (PST)
Received: from cloudburst.twiddle.net ([187.217.227.243])
 by smtp.gmail.com with ESMTPSA id z191sm5933824oig.3.2018.12.09.06.54.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Dec 2018 06:54:47 -0800 (PST)
Subject: Re: [PATCH v6 05/13] arm64: Don't trap host pointer auth use to EL2
To: Kristina Martsenko <kristina.martsenko@arm.com>,
 linux-arm-kernel@lists.infradead.org
References: <20181207183931.4285-1-kristina.martsenko@arm.com>
 <20181207183931.4285-6-kristina.martsenko@arm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <f2518d44-3435-394a-02d4-278a6907b96d@linaro.org>
Date: Sun, 9 Dec 2018 08:54:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181207183931.4285-6-kristina.martsenko@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_065458_590157_C4210D9A 
X-CRM114-Status: GOOD (  17.11  )
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
> To allow EL0 (and/or EL1) to use pointer authentication functionality,
> we must ensure that pointer authentication instructions and accesses to
> pointer authentication keys are not trapped to EL2.
> 
> This patch ensures that HCR_EL2 is configured appropriately when the
> kernel is booted at EL2. For non-VHE kernels we set HCR_EL2.{API,APK},
> ensuring that EL1 can access keys and permit EL0 use of instructions.
> For VHE kernels host EL0 (TGE && E2H) is unaffected by these settings,
> and it doesn't matter how we configure HCR_EL2.{API,APK}, so we don't
> bother setting them.
> 
> This does not enable support for KVM guests, since KVM manages HCR_EL2
> itself when running VMs.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
> Acked-by: Christoffer Dall <christoffer.dall@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: kvmarm@lists.cs.columbia.edu
> ---
>  arch/arm64/include/asm/kvm_arm.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
