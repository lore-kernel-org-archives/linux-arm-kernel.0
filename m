Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF2AC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:12:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6C87214C1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kVO66eI3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dvhyiJnN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6C87214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uBk/p8tAuJCOnSmSBp5U/IvVJRRfW75Al51PEN8Z48Q=; b=kVO66eI3s2kMHy
	ikvclResJtThWwDKyngGk60cnor6SCZwTzZeZ4arYqNgf7xYSdPUefSU7OpadiZd2EihFdtWwjj58
	y4R7L53eX5hxRP1U+evMijFMmZHGYEU7hMCULc1rUsH3l7yx8mUvHofd8DK8KTUNwC6Sqb09qf2Zk
	iDfjMrRMsFBnQiTSkXjuVdOrvCOp2v1vkXK6iZZq4RkUPQR6zZXn4Gg+KTyf4ZQtBavUjadWWCrlt
	f7IEVTfKy9hiaEN/5dztDFq90zonglTrUqtZIzdMAALRlWorrHxS8HS5wwleQWCsaJe2o0PlEj1vh
	MpHX7rCw99NFaVy/oQ1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTm9D-0002k7-NT; Mon, 03 Dec 2018 11:12:19 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTm95-0002hM-Hx
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 11:12:17 +0000
Received: by mail-wr1-x442.google.com with SMTP id v13so11688217wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 03:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=ktUki5kKJlm/XmPAGAnl3nsGbYvkH58XDa+bCIEGDSA=;
 b=dvhyiJnN79G36fOq8Jbr9jStyIkajdH+3jAxBehMDVZU2+6pAqozBohllEpwzpKkQE
 Xcgv+aVroch6dZkRG1pP0WUw07IZf49+bW2sHeLdDLRxyXcAOeeu80PkVZrkexY7Iyg8
 W8DlKRxVnmJEyGw6xr2I/RULiEViEQ6lqTxb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=ktUki5kKJlm/XmPAGAnl3nsGbYvkH58XDa+bCIEGDSA=;
 b=iBtRpQr+ebHQA8EwFWwkEHTJnk/dxohp+2CsG1/eNTKlt0jWGomDc/+ilqySoa0r2Y
 7g+kc6hSYmqvuR/j1c6gnxKn5SzCCdJ/uZQoYjHHsMt+jrOvZYdCsb1SFQYzbCkR3Czw
 KcKaGsKI7fC5CBCbUdKQLQLNHomXGGEpkuZDbzDgLBJkXpY2EySnBALEWjjcJpYf0aYg
 MCaiRhzIy5D6+OCNMgrsJJp6aECIjDZ8qph5H/0RIwz2AB/2AGfqLoUw8S+hfPcZAIVt
 Ny7Pw7cQ+QEgUer/h9XhqZ6F+Oj/Y0Smldz58d5xTz+pacoFmbuzRpA20PuwZBIyRP4r
 4hkg==
X-Gm-Message-State: AA+aEWZ0Ua0r+MNPM0ITtEts9bxZdQqy+6hmbhbfmD5K0PhOc2mQQnpw
 3NU5CdaT2JLCiCYBTlq9zgHnlw==
X-Google-Smtp-Source: AFSGD/UQgtjzPoIMAI5ke2+cdHd+peu67uwYD12+PDWb12nZdTkxGE29XUpFNaNaK2hNLZUAONzDiQ==
X-Received: by 2002:adf:b190:: with SMTP id q16mr13751325wra.95.1543835518902; 
 Mon, 03 Dec 2018 03:11:58 -0800 (PST)
Received: from dell ([2.31.167.218])
 by smtp.gmail.com with ESMTPSA id 14sm14448771wmv.36.2018.12.03.03.11.58
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 03:11:58 -0800 (PST)
Date: Mon, 3 Dec 2018 11:11:56 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Yangtao Li <tiny.windzz@gmail.com>
Subject: Re: [PATCH] mfd: convert to DEFINE_SHOW_ATTRIBUTE
Message-ID: <20181203111156.GJ26661@dell>
References: <20181202021710.9307-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181202021710.9307-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_031211_592142_D34690E8 
X-CRM114-Status: GOOD (  11.13  )
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
Cc: linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gU2F0LCAwMSBEZWMgMjAxOCwgWWFuZ3RhbyBMaSB3cm90ZToKCj4gVXNlIERFRklORV9TSE9X
X0FUVFJJQlVURSBtYWNybyB0byBzaW1wbGlmeSB0aGUgY29kZS4KPiAKPiBTaWduZWQtb2ZmLWJ5
OiBZYW5ndGFvIExpIDx0aW55LndpbmR6ekBnbWFpbC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvbWZk
L2FiMzEwMC1jb3JlLmMgfCAxNSArKy0tLS0tLS0tLS0tLS0KPiAgZHJpdmVycy9tZmQvYWIzMTAw
LW90cC5jICB8IDE2ICsrKy0tLS0tLS0tLS0tLS0KPiAgZHJpdmVycy9tZmQvdHBzNjUwMTAuYyAg
ICB8IDE0ICsrLS0tLS0tLS0tLS0tCj4gIDMgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCsp
LCAzOCBkZWxldGlvbnMoLSkKCkxvb2tzIG9rYXkgdG8gbWU6CgogIEZvciBteSBvd24gcmVmZXJl
bmNlOgogICAgQWNrZWQtZm9yLU1GRC1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9y
Zz4KCkxpbnVzLAoKICBBbnl0aGluZyB0byBhZGQ/CgotLSAKTGVlIEpvbmVzIFvmnY7nkLzmlq9d
CkxpbmFybyBTZXJ2aWNlcyBUZWNobmljYWwgTGVhZApMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJj
ZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MKRm9sbG93IExpbmFybzogRmFjZWJvb2sgfCBUd2l0dGVy
IHwgQmxvZwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtYXJtLWtlcm5lbAo=
