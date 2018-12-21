Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AE2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:39:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E38B0218FD
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oUuWAZC9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wh5PjhHR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E38B0218FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YvnuyaLT2dIhjp8HQB9lLqfXKVDCGd2xYdt2ET4S9U0=; b=oUuWAZC98K7qBa
	SCJo6aJJloqP3FkEmkonpczlzUpt7iF+lip7jvAjUyQlsksv4xr6lO487V3Wi9zY5zTWGHPDCrJ7m
	HyY+ucRkQPNgOVAfqVdwr6AraAIcyTyr4ycdXOkOJmhJNssBZAhdTGY2xih+HQtbjpO/lD2I9gWQU
	0KNYk/z+iY6NjwlkTRdPofErkfOs5VJ2qeTO3pCtNHg0Eb8UoxTSrnpwPiC2UyEwXEVCrGP1V2k9g
	4iXJcMmd324FCZl/NXSaKPDvqY7LeNe0mcUzAszabOhr6Z27lsIM1FcEMRvMHAYwVDQdYmQbsCZSA
	CkeLnx8X5qRn0Cd/ba5Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaGLR-0005VM-96; Fri, 21 Dec 2018 08:39:45 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaGLN-0005UK-JR
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 08:39:43 +0000
Received: by mail-wr1-x443.google.com with SMTP id t27so4319817wra.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 00:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=D/iWBheHUBC5EEZU6E5yzFudwU+7y61AN7x2cxOztmY=;
 b=Wh5PjhHR9IEvx2PF0Vpc9sx0Y/p1Vk0xWz8xSar65KumEa+xAoEhSmlBuvtcxYPLnc
 5uTWbIDyLacj9oyBz8979tJ55KIxqAy0inf8pJUIku47li9vgWfExa5n2XSUcLuZG9wz
 71Q4ggc8HjgIsaaBl/uTTTuMjazaBgvxHFlR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=D/iWBheHUBC5EEZU6E5yzFudwU+7y61AN7x2cxOztmY=;
 b=OK3n3SnpUl8xwAM56YgwWexlDOxlnlBMgILzHm1lzIW1wAD8RRZgwXHcOQGwDBi47W
 mkqBLuW6XWgtfoggMtCzveCsQrzQslcR6A0PC1rT2SWSn9tU7tRYO81CLIqdql/i/FDD
 /1CLIW10eH7YwFUmJhdnB2zF9W9ioBre0s99v3qOPcflixiRjqYmfvFWQQoY17IALy4A
 0UUwJ7K5/T8L/srK0PFuloMpA6/n3Nf9I8l57Fy1i+8jswvoxbVhzrCaE/rfawjMxN8b
 U9Zzdv+gsSBklbWggd5MdhpCJTXenQ3FCk6luBCrmrxwsAfBB2VUE5fEaXYjui9QjTj6
 YzCQ==
X-Gm-Message-State: AJcUukcjSPP8r8+ddy9BvvCNOAk0IWI+qmj7nB81rPXDo00ybZIpwG53
 +Aj5p1cuzQVUTh94gCjADtYfzg==
X-Google-Smtp-Source: ALg8bN6AGXmEO9/tU3hw9d1aKGRiTA8PvoOGgj3qEHkg7G1zzKziozVOUdzF+6WBFgpdZf1Q2K8omQ==
X-Received: by 2002:adf:e34b:: with SMTP id n11mr1457464wrj.91.1545381569436; 
 Fri, 21 Dec 2018 00:39:29 -0800 (PST)
Received: from dell ([95.149.164.119])
 by smtp.gmail.com with ESMTPSA id k128sm13109833wmd.37.2018.12.21.00.39.28
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 21 Dec 2018 00:39:28 -0800 (PST)
Date: Fri, 21 Dec 2018 08:39:27 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Priit Laes <plaes@plaes.org>
Subject: Re: [PATCH v2 1/8] mfd: axp20x: name voltage ramping define properly
Message-ID: <20181221083927.GQ4497@dell>
References: <cover.923997dd7d7396bb4d71f8967698b58ca956b929.1544512919.git-series.plaes@plaes.org>
 <01367c4f4f1e174fefbef9aac645f6792bda07e5.1544512919.git-series.plaes@plaes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <01367c4f4f1e174fefbef9aac645f6792bda07e5.1544512919.git-series.plaes@plaes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_003941_635961_F95979C2 
X-CRM114-Status: GOOD (  15.31  )
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
 Maxime Ripard <maxime.ripard@bootlin.com>, Mark Brown <broonie@kernel.org>,
 linux-sunxi <linux-sunxi@googlegroups.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Olliver Schinagl <oliver@schinagl.nl>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVHVlLCAxMSBEZWMgMjAxOCwgUHJpaXQgTGFlcyB3cm90ZToKCj4gRnJvbTogT2xsaXZlciBT
Y2hpbmFnbCA8b2xpdmVyQHNjaGluYWdsLm5sPgo+IAo+IFRoZSBjdXJyZW50IGF4cDIweCBuYW1l
cyB0aGUgcmFtcGluZyByZWdpc3RlciAnc2NhbCcgd2hpY2ggcHJvYmFibHkKPiBtZWFucyBzY2Fs
aW5nLiBTaW5jZSB0aGUgcmVnaXN0ZXIgcmVhbGx5IGhhcyBub3RoaW5nIHRvIGRvIHdpdGgKPiBz
Y2FsaW5nLCBidXQgcmVhbGx5IGlzIHRoZSB2b2x0YWdlIHJhbXAgd2UgcmVuYW1lIGl0IGFwcHJv
cHJpYXRlbHkuCj4gCj4gU2lnbmVkLW9mZi1ieTogT2xsaXZlciBTY2hpbmFnbCA8b2xpdmVyQHNj
aGluYWdsLm5sPgo+IFNpZ25lZC1vZmYtYnk6IFByaWl0IExhZXMgPHBsYWVzQHBsYWVzLm9yZz4K
PiBBY2tlZC1mb3ItTUZELWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgo+IC0t
LQo+ICBpbmNsdWRlL2xpbnV4L21mZC9heHAyMHguaCB8IDQgKystLQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKSSd2ZSBsb3N0IHRyYWNrIG9mIHdo
YXQncyBoYXBwZW5pbmcgd2l0aCB0aGlzIHNldCBub3cuCgpNYXJrLAoKRGlkIHlvdSB0YWtlIHRo
aXMgcGF0Y2ggaW4gdGhlIGVuZD8KCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbWZkL2F4
cDIweC5oIGIvaW5jbHVkZS9saW51eC9tZmQvYXhwMjB4LmgKPiBpbmRleCAyMzAyYjYyLi5hMzUz
Y2QyIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbGludXgvbWZkL2F4cDIweC5oCj4gKysrIGIvaW5j
bHVkZS9saW51eC9tZmQvYXhwMjB4LmgKPiBAQCAtMzUsNyArMzUsNyBAQCBlbnVtIGF4cDIweF92
YXJpYW50cyB7Cj4gICNkZWZpbmUgQVhQMTUyX0FMRE9fT1BfTU9ERQkJMHgxMwo+ICAjZGVmaW5l
IEFYUDE1Ml9MRE8wX0NUUkwJCTB4MTUKPiAgI2RlZmluZSBBWFAxNTJfRENEQzJfVl9PVVQJCTB4
MjMKPiAtI2RlZmluZSBBWFAxNTJfRENEQzJfVl9TQ0FMCQkweDI1Cj4gKyNkZWZpbmUgQVhQMTUy
X0RDREMyX1ZfUkFNUAkJMHgyNQo+ICAjZGVmaW5lIEFYUDE1Ml9EQ0RDMV9WX09VVAkJMHgyNgo+
ICAjZGVmaW5lIEFYUDE1Ml9EQ0RDM19WX09VVAkJMHgyNwo+ICAjZGVmaW5lIEFYUDE1Ml9BTERP
MTJfVl9PVVQJCTB4MjgKPiBAQCAtNTMsNyArNTMsNyBAQCBlbnVtIGF4cDIweF92YXJpYW50cyB7
Cj4gICNkZWZpbmUgQVhQMjBYX1VTQl9PVEdfU1RBVFVTCQkweDAyCj4gICNkZWZpbmUgQVhQMjBY
X1BXUl9PVVRfQ1RSTAkJMHgxMgo+ICAjZGVmaW5lIEFYUDIwWF9EQ0RDMl9WX09VVAkJMHgyMwo+
IC0jZGVmaW5lIEFYUDIwWF9EQ0RDMl9MRE8zX1ZfU0NBTAkweDI1Cj4gKyNkZWZpbmUgQVhQMjBY
X0RDREMyX0xETzNfVl9SQU1QCTB4MjUKPiAgI2RlZmluZSBBWFAyMFhfRENEQzNfVl9PVVQJCTB4
MjcKPiAgI2RlZmluZSBBWFAyMFhfTERPMjRfVl9PVVQJCTB4MjgKPiAgI2RlZmluZSBBWFAyMFhf
TERPM19WX09VVAkJMHgyOQoKLS0gCkxlZSBKb25lcyBb5p2O55C85pavXQpMaW5hcm8gU2Vydmlj
ZXMgVGVjaG5pY2FsIExlYWQKTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9y
IEFSTSBTb0NzCkZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJu
ZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
