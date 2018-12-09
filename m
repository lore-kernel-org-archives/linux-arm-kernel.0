Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2E9C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 14:35:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D00232081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 14:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G8WQl0n8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W8SJymKR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D00232081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UBJAQexE0wGszeTHbehJPA15uELDscvOTt6gye1f4KM=; b=G8WQl0n8tTh5mn
	MyL+HlN5lsVPRtQ/YSf/h70VtutkYG2pGzQ40MCCphmA7E53jU2V5vpSMsvH+mCq9vxNErhBxieyf
	kVoObChwZX0d96xWpIe6dIdAXRhFxMmFNGnEYw1ItJFNS1RBFCcMwGEZpj8teYyffQQG27mlA+X0w
	t6ckt4dOvHO3Ux0hYpBs5o8L9571NpZfPsuAiAyr03HxjHuh/DfQNuu69/DjbpMXC5X3Zcopr39X2
	d3yo0YF7vCuglinjitqOevkaW2spbJ3p2yjIGayGxhzIlGCsExSql1BRfvVgq9DXt0uZIF0WVW2+Y
	WmwcoL7kV+QQbJC9O8Iw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gW0Ao-0006RC-Oi; Sun, 09 Dec 2018 14:35:10 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gW0Al-0005BF-Fv
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 14:35:09 +0000
Received: by mail-ot1-x343.google.com with SMTP id k98so8085177otk.3
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 09 Dec 2018 06:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7rY/0nb46pp/FAfdQSNBw+IP1tJlV9Urwj6W0rS+3VU=;
 b=W8SJymKR8wzUZHmt6VneN3iabkj3BUW2S6Z4UuXpePNROkI3DEp7/cgw5hTzuO11oD
 HXI8LbipMwfHLnZM1t0oecDFiHmBZWxCTtR1k/tiql0bs2FHwdvfOIMDgwkqpjY8zgWi
 +CZsFSts+pRm5g08OAxorZjjQMnxosCtvOHWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7rY/0nb46pp/FAfdQSNBw+IP1tJlV9Urwj6W0rS+3VU=;
 b=cafDyX9Tks2pHQuz1nN4wahiA49T3z3JKt0dkwyjES9g1cOktIUeoSVH7kdfHW3ycC
 9xEqZoLd3/9LoEmIo23115iPxfZIB6QYIYcZ92Hd/yksOypYlGs81yTGHV1MtP6A8H7a
 Bfxz0DZz3JEPLzZ6sPJrI4RzMIeiaJJQUIKKWU4pWVZ3YEkzY+30nARgmdMsr717sSQM
 whyzxFE8bHEic92jFz5fVxNOtKQLHosf/z/YqmjgojocELv33wEiOg5lMEnTO0kzlvO7
 dAjTEXlBc0KIpBnKttBr8TO/dlemuO+fRf7uhqCn0Wye9AAWoSIXwgTv3WDJjeB6o/4i
 RlnA==
X-Gm-Message-State: AA+aEWb/k8eVRLCabMBr0aLAND/D0TWSVaoXvllFwphihq1PhSoJFw24
 DNYWG7qHqUzKYkUAAT4TBNbK6w==
X-Google-Smtp-Source: AFSGD/W4Vcts2PYofm1A2YqiibU9ClUXwfNPG+jqw6+cnYhNdPIBM8haWn0TiPK1C4bXklnG9HKDtw==
X-Received: by 2002:a05:6830:165a:: with SMTP id
 h26mr1204576otr.299.1544366095349; 
 Sun, 09 Dec 2018 06:34:55 -0800 (PST)
Received: from cloudburst.twiddle.net ([187.217.227.243])
 by smtp.gmail.com with ESMTPSA id s13sm4431607otc.40.2018.12.09.06.34.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Dec 2018 06:34:54 -0800 (PST)
Subject: Re: [PATCH v6 01/13] arm64: add comments about EC exception levels
To: Kristina Martsenko <kristina.martsenko@arm.com>,
 linux-arm-kernel@lists.infradead.org
References: <20181207183931.4285-1-kristina.martsenko@arm.com>
 <20181207183931.4285-2-kristina.martsenko@arm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <73743377-b3d2-6f9f-654d-cbb00a7c70f9@linaro.org>
Date: Sun, 9 Dec 2018 08:34:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181207183931.4285-2-kristina.martsenko@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_063507_786368_834FAAE3 
X-CRM114-Status: GOOD (  12.94  )
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
> To make it clear which exceptions can't be taken to EL1 or EL2, add
> comments next to the ESR_ELx_EC_* macro definitions.
> 
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
> ---
>  arch/arm64/include/asm/esr.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
