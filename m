Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EDDC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 07:48:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A21F9218B0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 07:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sYyIpFtB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zHYt7e++"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A21F9218B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BHEPPFriD2S0L/cSUiUAGGUvkMLBl1ImgWuFLvAHm2s=; b=sYyIpFtBO18ms3
	0nQJn3kGvptwnXsWdB2fYPTX1YevaMu+KF75MMHdmjqQTR+uUJwwUXPdD61J56VIhinYEJh/6oSLh
	Ey+cxqk5w3bgEAF3SixPHYeBzj84Q4qY0NJtaJaYq68zf4vey8cAR+V2ZpMUBWt7M81BnhcIfZ+az
	NCHNtmEU7OdvU1wdHt+J5dH20yahMjqJLMZPMbyS7k07TDOWvwzROpkzLQFBh4bckVJZldnrWiiqL
	DXGGQjpSB4Xomm/Rog7b/Can8zGQeIFIAx8CTz8K6PGLQr3WNVs7RT9JFgv7TXHFC1JlE/Fg6OxJK
	A/eZ0GnsuJF4ozNAJ3Nw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grePm-000299-M4; Thu, 07 Feb 2019 07:48:06 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grePj-00028S-H9
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 07:48:05 +0000
Received: by mail-wm1-x341.google.com with SMTP id q21so5539996wmc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 06 Feb 2019 23:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=NTdGonK744BlVpHfJkByCKbXq8IBZylaPXj5tnPuUxY=;
 b=zHYt7e++rFoBLVbdSTZYUfceoYPP6XWpRAgkGAUAcxf4eGQhHwM6/jg8m0A/jK+pIA
 9TiXqQKfBnCXeNdAP9QEQiwU31k0jetNrd/JCEeuTJ1JB3sBUpfnFv7KyGkn122N3JRt
 tzBr5ZVSTPKVDEXbx4Im4bT0lW0f1Jrt8EnXMJHNJu5St6U3OffipiVmevtY1fjewD/z
 780sB1NIhfILmZt1kpgC6n4iL/jrd5xvsYUhtyAwszKEEb1OZszAR5imAw5kmrXAuw/H
 C+2LyU3hpQUEzA2L9gi3fDXrUi+aSKyIrl85QBZ4AnJoGNlNpod/W/RSdcHQs08oiVxk
 Ob9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=NTdGonK744BlVpHfJkByCKbXq8IBZylaPXj5tnPuUxY=;
 b=sQSGMUc0MFN2R4pCgP1TSDt6lFS2TxY4f+5lQeqGI10TufEkMeGGxCgf5oE/ZzjeJG
 XsMn0/mTvSP8esRXzx+An6prz+BtXT4HQasUOvfzHNUH/irafe92UPpCFF69JX5S6heA
 L99/YpiYchHGY3fFQlNEzKu0rTLksw+ZFvojPFxMRYDXFN9tf/Zw0ksPwJS0FuiwudGN
 oni9McWy/gxmI6H8yzpTZgAGXPelysQzkaTgffCOs0+e40Sl8Xllkpi6u3zYiC577J0G
 6E51YaQbhWTVe0XR0wJNNv8aLOKWTzYzDdsOE6KfyZg55h+ZfQ5wN7qTYwc1Wn0vcKDs
 pxyQ==
X-Gm-Message-State: AHQUAuYnIIkFkzhe1WXmzwrcDcDBhjVE8uRDaI48ooGeKmNoGgS+1nnh
 aUsMkhX5XtHJyCnmJDQdFRgeyA==
X-Google-Smtp-Source: AHgI3Ib61/0rKoFEbhN4qPnZvjLR+p9OgAfjOHNnoPy8Yxc/nofF36J3kFM2jFsvlzEWtjucRAeu8w==
X-Received: by 2002:a1c:790c:: with SMTP id l12mr5837602wme.11.1549525680239; 
 Wed, 06 Feb 2019 23:48:00 -0800 (PST)
Received: from dell ([2.27.35.171])
 by smtp.gmail.com with ESMTPSA id r14sm5727736wrr.65.2019.02.06.23.47.59
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 06 Feb 2019 23:47:59 -0800 (PST)
Date: Thu, 7 Feb 2019 07:47:57 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Vijay Khemka <vijaykhemka@fb.com>
Subject: Re: [PATCH v3] dt-bindings: aspeed-lpc: Make parameter optional
Message-ID: <20190207074757.GA4672@dell>
References: <20190129230538.1044378-1-vijaykhemka@fb.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190129230538.1044378-1-vijaykhemka@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190206_234803_574389_F174C61E 
X-CRM114-Status: GOOD (  10.79  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>,
 "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Joel Stanley <joel@jms.id.au>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVHVlLCAyOSBKYW4gMjAxOSwgVmlqYXkgS2hlbWthIHdyb3RlOgoKPiBNZW1vcnktcmVnaW9u
IGFuZCBmbGFzaCBwaGFuZGxlIGlzIG5vdCBhIHJlcXVpcmVkIHBhcmFtZXRlciwgaXQgaXMKPiBv
cHRpb25hbCB0byBkZXNjcmliZSBpbiBkZXZpY2UgdHJlZSBhbmQgbmVlZGVkIG9ubHkgdXNlIGJh
c2lzLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFZpamF5IEtoZW1rYSA8dmlqYXlraGVta2FAZmIuY29t
Pgo+IC0tLQo+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2FzcGVlZC1s
cGMudHh0IHwgMiArKwo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpBcHBsaWVk
LCB0aGFua3MuCgotLSAKTGVlIEpvbmVzIFvmnY7nkLzmlq9dCkxpbmFybyBTZXJ2aWNlcyBUZWNo
bmljYWwgTGVhZApMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNv
Q3MKRm9sbG93IExpbmFybzogRmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxvZwoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWls
aW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
