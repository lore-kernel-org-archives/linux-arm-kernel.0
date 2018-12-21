Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76C1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:44:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADE3721906
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ReClmv/J";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NzpH4Yx+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADE3721906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=s3A66Q3jmEJ4BmZwrc4QYuQGesWgvSAolPQkLGQbMCo=; b=ReClmv/JlUgnVK
	MxuHHe+iRPAeSHHn/QkOxN04uzQyHyfrwRYv+40l4STXNPxNngfVuRE6gPOkOkWLXBLIFCNop/UrQ
	tVl63OluCl8CUbb1ePxnCmpeR3Gv5oTEWLZ/pAgSxzvg/D0YBCENkFyo1JizdpzvK4X+t3XKgKYKE
	Umc3Xd4ZXYchFLVcn2Dh2ZAbv+nb90/eWOp9ARhr1koOJAk09AV75ZdxTaOIGWbdTndN2NvhXJd5d
	Mp9BrMYawbC5/eJFY6SEA8CN3tYSC6jVjxXiOA+OO2H+BgytuuZyKI4MoN0QTswT1x13dlivkXB5s
	BewX/zP6avrqW2O/diRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaIIV-0001YW-PX; Fri, 21 Dec 2018 10:44:51 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaIIS-0001N5-Ms
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 10:44:50 +0000
Received: by mail-wr1-x442.google.com with SMTP id z5so4716330wrt.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 02:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=zRoUutFyDfmmemUAmzDJJAZ6OSaaWsvU2Qbe6YNb/MI=;
 b=NzpH4Yx+q1SR83CISQliyRkRkuyrq2tWVoPIV6YKXViCfcpv8w62zHPOWnkR2b4C+Q
 LWNVc6wJqYbNw0Bjdf48mEgvnI+ZexT5+Ugy6/LIGCR/ACzBWad3ju+/CZIqj6PQ86w6
 JePcJ6aiJHI/klZWApHf57Y5BZFxfOxcvEESw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=zRoUutFyDfmmemUAmzDJJAZ6OSaaWsvU2Qbe6YNb/MI=;
 b=q6Xr3PU1Xcmwd64J7TCZTSbRP4E8LP/xagJhoi69wg8LCZw+f6tMIBqsKU281dQkYr
 YHZfV/A/SbMzF4Z59oRZSTdAdlJSNgoantCmGlNtDUmAB2mprJb67ySe800wuk+2CuuG
 psEhY9qyuq+ZkALQiTbmwYpJ1nUSTGmLwthOavqyfSz1i08FJPW1c9iX/o6j61f4pjk2
 anVYuFnETNuKwXJPKxPPhMnxKnFFlW32LKQmWyAcTwlQQjNzenHAafIq+IYdh+jc3Og7
 o50OtQ4YAiv9HSXEv47IMu+IHo8FDRmLtQ0nzDOPXOYpbJWfprh4EZ1ZSD3LMnqwpQni
 Ztow==
X-Gm-Message-State: AJcUukc8U2HVQRbMJ3db3XQzUyV4Pd0i8AV15CebL4mXLyVCr7kWbibf
 ZAMnNYTY4w2HpYUrnkpCo8ODcw==
X-Google-Smtp-Source: ALg8bN7AaQbZwqto2+O+rcOjgeZw9aeAjk9+OOHkbLCvgNoWs7b0Ua544OtlK3Bjx6RFu9/SD2Mz/Q==
X-Received: by 2002:adf:f3c6:: with SMTP id g6mr2012309wrp.111.1545389077318; 
 Fri, 21 Dec 2018 02:44:37 -0800 (PST)
Received: from dell ([95.149.164.119])
 by smtp.gmail.com with ESMTPSA id n5sm14696152wrr.94.2018.12.21.02.44.35
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 21 Dec 2018 02:44:36 -0800 (PST)
Date: Fri, 21 Dec 2018 10:44:34 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Philippe Schenker <dev@pschenker.ch>
Subject: Re: [PATCH v4 1/8] dt-bindings: stmpe: reformatting parameter list
 and use tabs only
Message-ID: <20181221104434.GN13248@dell>
References: <20181212130649.15146-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181212130649.15146-1-dev@pschenker.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_024448_750016_98912D04 
X-CRM114-Status: GOOD (  12.99  )
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
 Alexandre Torgue <alexandre.torgue@st.com>, marcel.ziswiler@toradex.com,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org,
 stefan@agner.ch, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Philippe Schenker <philippe.schenker@toradex.com>, thierry.reding@gmail.com,
 linux-arm-kernel@lists.infradead.org,
 Max Krummenacher <max.krummenacher@toradex.com>, linux-input@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-stm32@st-md-mailman.stormreply.com,
 jic23@kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gV2VkLCAxMiBEZWMgMjAxOCwgUGhpbGlwcGUgU2NoZW5rZXIgd3JvdGU6Cgo+IFRoaXMgcGF0
Y2ggcmVmb3JtYXRzIHRoZSBwYXJhbWV0ZXIgbGlzdCBmb3Igc3RtcGUgZGV2aWNlIGluIGEKPiB0
YWJsZS1zdHlsZSBzbyBpdCBpcyBtb3JlIGNsZWFyIHRvIHJlYWQuCj4gCj4gU2lnbmVkLW9mZi1i
eTogUGhpbGlwcGUgU2NoZW5rZXIgPHBoaWxpcHBlLnNjaGVua2VyQHRvcmFkZXguY29tPgo+IC0t
LQo+IAo+IENoYW5nZXMgaW4gdjQ6Cj4gIC0gTmV3IHNlcGFyYXRlIHByZWN1cnNvciBwYXRjaCBm
b3IgaG9sZGluZyByZWZvcm1hdHRpbmcKPiAKPiBDaGFuZ2VzIGluIHYzOiBOb25lCj4gQ2hhbmdl
cyBpbiB2MjogTm9uZQo+IAo+ICAuLi4vYmluZGluZ3MvaW5wdXQvdG91Y2hzY3JlZW4vc3RtcGUu
dHh0ICAgICAgfCA1MiArKysrKysrKysrKystLS0tLS0tCj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRp
bmdzL21mZC9zdG1wZS50eHQgICAgICAgICB8IDE0ICsrLS0tCj4gIDIgZmlsZXMgY2hhbmdlZCwg
NDEgaW5zZXJ0aW9ucygrKSwgMjUgZGVsZXRpb25zKC0pCgpTZXQgbG9va3Mgb2theS4KClBsZWFz
ZSBzdWJtaXQgYSBbUkVTRU5EXSB3aXRoIGFsbCB0aGUgQWNrcyB5b3UndmUgY29sbGVjdGVkLgoK
QW5kIG5leHQgdGltZSwgcGxlYXNlIG1ha2Ugc3VyZSB5b3UgYXV0aG9yIGEgMHRoIChjb3Zlci1s
ZXR0ZXIpIHBhdGNoLgoKLS0gCkxlZSBKb25lcyBb5p2O55C85pavXQpMaW5hcm8gU2VydmljZXMg
VGVjaG5pY2FsIExlYWQKTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFS
TSBTb0NzCkZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
