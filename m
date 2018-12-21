Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94237C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:41:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61E8F218E2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U0czVqUI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="F4vCTfCj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E8F218E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XwIxbiXF6wNREl9t0pMdoQ9TNrpX1t+qkaL3aQZObLo=; b=U0czVqUIF+EMu0
	2jvr1hJtsWxJebFEe723m8Bhnzo4A9/daGhQE0D00fCjVW30xUXJQh62bregDdhHlvxZRN/u+gsCB
	ItG9yHOksV1GjZyp8MhuDWBuB5u9zRXnO3Y3qKkv9hx2X6t91KM+6o/QriDYTvJziINa0beDYX2O9
	DfNWKdQ/lQhlGMMqCV7J8EwzvL+98A//ASSuRVnfW3gjUSPere8O1zJCVusYvu9Cy0qkfQ5A6EmLO
	3FMa7YOR01A9qxavHLBIHCSpEDMgA14nsSrtjC1FUtopZbM+/leMNBeISiKTG+V2nVHmTwauzMquT
	VYrhhA3cWx/kHDG9rCQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaFQu-0003cO-Au; Fri, 21 Dec 2018 07:41:20 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaFQr-0003be-Sd
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 07:41:19 +0000
Received: by mail-wm1-x342.google.com with SMTP id d15so4334522wmb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 23:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=wXL5f8n1srKsQxmGBFauSfHPgXgwfmcCSAYDei6qN7Y=;
 b=F4vCTfCjg7hklY95hmB97lF/cUrfPxUEXMD1Q+NyFAVsV6epkaCJUZTNeH0gszy2hH
 oiY6zuhvyK3ZINVDN1BlQWEtUB6L/XIqlaLjUKTAP3uur+zPog6a35efTsvs4t+6YN28
 v0uviWHi0/FZRB95o/kXLhZF4XEJ2zycnSvhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=wXL5f8n1srKsQxmGBFauSfHPgXgwfmcCSAYDei6qN7Y=;
 b=AqWPBN0GOrFG1Uia3vd9mipc0SGvvAYoLNXUrc0LfvGaPpB1XXHOMK5A15/pV4qasI
 mmKoBJbgyDJrgLxJ7pN3JxekSBP7/0RsQbzjqEuWBrfRcG+fwSz3apxaHQ1qhofsvoeW
 4NeoBFY7B1VTSB6IQ535OeiESPNDT26aQg9PojWkkhtCDMX7bKA0x1bEKKvmN2rl0wvF
 91q6r382iAxY8vYMcZlz45PK6tkBUYCXF/rR3prrnHOL3jHrcpp/Yd199CiKQCkfAbQ3
 zE3ZUrtYkcXacEQX6tA31ikNfvnoNMV7N2VK5we+1CFwv5HIxd84m5THmu0K+YmpEo9d
 Mklw==
X-Gm-Message-State: AA+aEWZVpDIucPqzb40gmm0qRUzIPdxyRyQkwcZGJJhu/noyPNAX7NAr
 seCkMu4vktPzf5duCW8RgXZ6Rg==
X-Google-Smtp-Source: AFSGD/XXCqbgRoB2koMOkag3IfFE3of9TGe/NT9c3krl8eC+OMC0v1dOIPq0DoGOtq2elEaDn+NCZQ==
X-Received: by 2002:a1c:d74a:: with SMTP id o71mr1655755wmg.73.1545378064972; 
 Thu, 20 Dec 2018 23:41:04 -0800 (PST)
Received: from dell ([95.149.164.119])
 by smtp.gmail.com with ESMTPSA id f15sm8785543wrt.10.2018.12.20.23.41.04
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 20 Dec 2018 23:41:04 -0800 (PST)
Date: Fri, 21 Dec 2018 07:41:02 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Frank Lee <tiny.windzz@gmail.com>
Subject: Re: [PATCH] mfd: convert to DEFINE_SHOW_ATTRIBUTE
Message-ID: <20181221074102.GP4497@dell>
References: <20181202021710.9307-1-tiny.windzz@gmail.com>
 <CACRpkdahwmjED=BY715E+cpRhveqk32vCRpevyHF8SdcqC0kvg@mail.gmail.com>
 <CAEExFWssZtWV3XnJpjwm8BXAE4duhrrvjaPWQhfRP3W4y-O1Rg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEExFWssZtWV3XnJpjwm8BXAE4duhrrvjaPWQhfRP3W4y-O1Rg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_234117_930707_8E3AD10E 
X-CRM114-Status: GOOD (  11.24  )
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
Cc: Linus Walleij <linus.walleij@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCAyMSBEZWMgMjAxOCwgRnJhbmsgTGVlIHdyb3RlOgoKPiBwaW5nLi4uLi4uCgpJJ3Zl
IHRvbGQgeW91IGFib3V0IHRoaXMgYmVmb3JlOgoKIgpQbGVhc2UgZG9uJ3QgZG8gdGhhdC4KCklm
IHlvdSB0aGluayB5b3VyIHBhdGNoIGhhcyBiZWVuIG1pc3NlZCwgdGhlbiBwbGVhc2Ugc2VuZCBp
dCBhZ2FpbiBhcwphIFtSRVNFTkRdLiAgSW4gdGhpcyBjYXNlIHlvdSB3aWxsIG5lZWQgdG8gZml4
IHRoZSAkU1VCSkVDVCBsaW5lIHRvby4KVG8gc2VlIHdoYXQgaXQgc2hvdWxkIGxvb2sgbGlrZSBk
byB0aGUgZm9sbG93aW5nOgogCiAgYGdpdCBsb2cgLS1vbmVsaW5lIC0tIGRyaXZlcnMvbWZkYAog
Ck9uY2UgZml4ZWQsIHMvW1BBVENIXS9bUkVTRU5ELyBhbmQgcmVzdWJtaXQgaXQuCiIKCkluIHRo
aXMgY2FzZSB0aGUgJFNVQkpFQ1QgbGluZSBpcyBmaW5lLCBidXQgdGhlIHJlc3QgaXMgcmVsZXZh
bnQuCgotLSAKTGVlIEpvbmVzIFvmnY7nkLzmlq9dCkxpbmFybyBTZXJ2aWNlcyBUZWNobmljYWwg
TGVhZApMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MKRm9s
bG93IExpbmFybzogRmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxvZwoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxp
c3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
