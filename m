Return-Path: <SRS0=5Xh4=OS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB55C07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 14:24:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDD8E20672
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 14:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MMkXLh7K";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MyV8C+8s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDD8E20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=p1kl0NsOUSaZUTcaCu64W0PjaFkUl3wRUGhFJOmME78=; b=MMkXLh7Kd6LZWK
	tpxTuXdHVzYSzSHL7rSWkyRaKzyWgZ+mR7UIa9xMq+GfZrgDNt8hT23mYn2rIv9HNwOMYWrJI/xMR
	3hxmprild5QqcJ8Q54gDmlHDQnL59W8eH9Tdvn5r2FMGzXOiTEhL4me24tw/V68NMvxgWDvPZ0kE3
	M+h2bO99A010EoRGinC7HaBD9+UtAuoTmycO8Kc7k9Q73/SQgmWIsMTdObtx/wDj5PBkMEUJfu3J5
	DFzoCzjp0VQm8kSfzzbMKSnJ1QzA1SsqtnWj5XJdjYzdwtyW27Tq91Xg+trNy/aAXK2JFF2e6K8Gj
	vsRuMhw8q7IbzUOxmDUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gW00e-0008KX-4n; Sun, 09 Dec 2018 14:24:40 +0000
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gW00a-0008Jk-Fe
 for linux-arm-kernel@lists.infradead.org; Sun, 09 Dec 2018 14:24:38 +0000
Received: by mail-oi1-x241.google.com with SMTP id t204so7004925oie.7
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 09 Dec 2018 06:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9l2Ypt9it1UDSDOXpZ8XxjCJ6XtWGFaSCksFQ49eel8=;
 b=MyV8C+8sTmfKiz7RQ8OsBqnzfBuNdICDzWnBYP8uQv2gjGWsr84kk/NIw1vBVUyedr
 BKdGOHG7SK4IBDJ8ytpTKATqusn9xkRLvUUWK5LECcRpY3pqaXGFYKye+uaSnYe2ihY4
 fEfpJdUMeOttjTEXq3Fk9WwUqWPQSdymDDkHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9l2Ypt9it1UDSDOXpZ8XxjCJ6XtWGFaSCksFQ49eel8=;
 b=aupnsJjmXCPZbd1dYmd1iNZDLmy4cxq4gUPEgLDYJCttuzMyGeQTxP7O19qGXcLQVK
 xomogOfm7OjI6Uz3bKIlaMrxe8m881WLTounwaONzTnKBzUqU4FA9hB//GFUbSZs3nUG
 U+tbz++zWM6a5l1VPdbGCzGGrLgxaPNLVHIW5rT1cvFFvbo5mni9VH7YBkdvRyx45OHZ
 dCUFy/pW5YkHqAW3dTsWtU4T6eyrMLOuLz+144771RcGTm+dfq4HtuGZ2QpYkTjp78Kr
 nGTbgOEa6S20Kii5mthzbevAUWaNAZqa2ItzS0r4w7voHcxei4YF0eKbR0XvS3PQOU9K
 8piQ==
X-Gm-Message-State: AA+aEWaLW6IEF9cUo5sWoPtSUuq+9+7pb9e6iv9pJMnAKdZu6gUxHTqj
 +fIPbGhkZsEKpz5YDAMjYRaIcQ==
X-Google-Smtp-Source: AFSGD/VYALGX6L0Twx1Cq1MRI0tuiC4ASvupfvYxumOh6Y1MHK6mUC97yxWYrc7p3hhIlAcobqXj9A==
X-Received: by 2002:aca:d509:: with SMTP id m9mr5338204oig.82.1544365464753;
 Sun, 09 Dec 2018 06:24:24 -0800 (PST)
Received: from cloudburst.twiddle.net ([187.217.227.243])
 by smtp.gmail.com with ESMTPSA id r203sm4148551oih.11.2018.12.09.06.24.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 09 Dec 2018 06:24:24 -0800 (PST)
Subject: Re: [PATCH v6 02/13] arm64: add pointer authentication register bits
To: Kristina Martsenko <kristina.martsenko@arm.com>,
 linux-arm-kernel@lists.infradead.org
References: <20181207183931.4285-1-kristina.martsenko@arm.com>
 <20181207183931.4285-3-kristina.martsenko@arm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ef051a9b-d58f-07af-a446-4b7326ff9311@linaro.org>
Date: Sun, 9 Dec 2018 08:24:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181207183931.4285-3-kristina.martsenko@arm.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_062436_520398_37AD6141 
X-CRM114-Status: UNSURE (   9.85  )
X-CRM114-Notice: Please train this message.
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
>  #define SCTLR_ELx_DSSBS	(1UL << 44)
> +#define SCTLR_ELx_ENIA	(1 << 31)

1U or 1UL lest you produce signed -0x80000000.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
