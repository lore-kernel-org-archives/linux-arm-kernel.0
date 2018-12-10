Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F66C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:22:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6C832084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nqmIydDu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TMywv58c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C832084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AwyT3Na9scYab4RO/CL8kncAvsrvejkLRhEx/cX9YuA=; b=nqmIydDu5cIWbQ
	YQUthaEL1nyOwsI9WRYeYvMJixNHa5d6RYAmcFeRfBsxyZ0EKvRcyFlIm2e9Ck7iNVcpxEksV7OjX
	hVbx1veoQaC/E9b02lPAIzBkwFLDl7gZlRiyb3pdf774zbmtNQWFQYGgAN2EY9L4ZXk2QUfV92Tee
	BfjIA10ydXpv40BsD9BG7PTxaRQQsAOmLOA8B29LgtYmtFrce5Z0zcrpgQZT2KYOczXP3tCPwH3nB
	Q+NX+Lt5RhDS5X79bcew9frWHSWORct7miN77waFvwluVWpMTrVIhjFN/gpOdXPUESDKkLReXO/Aa
	gxrkWLOdu5YwukADHp2Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWS4J-0005GU-HL; Mon, 10 Dec 2018 20:22:19 +0000
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWS4G-0005FK-Nm
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 20:22:18 +0000
Received: by mail-oi1-x242.google.com with SMTP id y23so10107746oia.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 10 Dec 2018 12:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ITwyA1ilb+xLe3ITBXhrAEwj01XyjVw7cJczqLzd8aM=;
 b=TMywv58cDbyz74X2fVktWd9KNCIRxRjGMPZmKnDO798MrBSj6XII/IBrgxmHv14eAW
 yHUfciBPAIKUi9mvcUWWhEQOAR841wLQnXntoCktGmT5IGKVf9WTcpmsKOu2MozV37u8
 EBs1tGzyidWTJ0Qt4j+g0NfHREb+gA0TQw9UQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ITwyA1ilb+xLe3ITBXhrAEwj01XyjVw7cJczqLzd8aM=;
 b=Eu0uQHgxicVwXRYL/FDue/btXsBooiY7w9244aNiuVR0yhw+lwr8v3RJZi9rwmK/9+
 rqf7MF/aHu0DsiVDCEYOhGpM68WzQrmTEAuPo3cAWKsLQOgKMaG3P4g7UsM81rtK2vgR
 zte2ql0S5Yw2Sg5A31ZlJFZCdjWc+Gpx4CWNJBmXNylzxNCHl15YMZqBWRDeVd8CB2w9
 yQP40VZ43azoNBmIzofKl0mFCpgqOvfoqSYuPAgRgI6hV7iDo7UCFtvS78CqUYSNfwDY
 hAQkjCr8yU04420J2J92FITA4b3Vhsgrz6BN0R5m4a5oY2f888ktxbPXiztUOH0JupZO
 pLXg==
X-Gm-Message-State: AA+aEWZn+bn2yWYxS0GIIl5qaCk/vPWdWEL69oc0uhEaEqVVXJrISxQn
 iuRKVTRW/+Qyt6jhtkDIfglk7Q==
X-Google-Smtp-Source: AFSGD/XIhsFJ2ATcmbuiOaS801akNcbIUkx/pmV001ZKV9jnbnfOH/yiKG6qYpcgprUKOxz6/N2A6Q==
X-Received: by 2002:aca:4a56:: with SMTP id x83mr7843904oia.11.1544473325046; 
 Mon, 10 Dec 2018 12:22:05 -0800 (PST)
Received: from cloudburst.twiddle.net ([187.217.227.243])
 by smtp.gmail.com with ESMTPSA id l1sm5864845oib.10.2018.12.10.12.22.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 12:22:04 -0800 (PST)
Subject: Re: [PATCH v6 04/13] arm64/kvm: hide ptrauth from guests
To: Kristina Martsenko <kristina.martsenko@arm.com>
References: <20181207183931.4285-1-kristina.martsenko@arm.com>
 <20181207183931.4285-5-kristina.martsenko@arm.com>
 <57966497-d21c-5439-e4ba-d75f5552282f@linaro.org>
 <a2eb07e5-6663-aede-fb75-cc91cf3fffa5@arm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <1f179017-4237-0d36-7adc-0a1470b5fd46@linaro.org>
Date: Mon, 10 Dec 2018 14:22:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <a2eb07e5-6663-aede-fb75-cc91cf3fffa5@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_122216_774759_A2E39FA6 
X-CRM114-Status: GOOD (  13.73  )
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
 linux-kernel@vger.kernel.org, Jacob Bramley <jacob.bramley@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Adam Wallis <awallis@codeaurora.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu,
 Cyrill Gorcunov <gorcunov@gmail.com>,
 Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
 Amit Kachhap <amit.kachhap@arm.com>, Dave P Martin <dave.martin@arm.com>,
 linux-arm-kernel@lists.infradead.org, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 12/10/18 2:12 PM, Kristina Martsenko wrote:
> The plan was to disable trapping, yes. However, after that thread there
> was a retrospective change applied to the architecture, such that the
> XPACLRI (and XPACD/XPACI) instructions are no longer trapped by
> HCR_EL2.API. (The public documentation on this has not been updated
> yet.) This means that no HINT-space instructions should trap anymore.

Ah, thanks for the update.  I'll update my QEMU patch set.

>> It seems like the header comment here, and
> Sorry, which header comment?

Sorry, the patch commit message.


r~

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
