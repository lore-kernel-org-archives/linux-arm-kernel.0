Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125B6C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:42:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D48CE21906
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dd55eIzS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="STEMGwRY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D48CE21906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v7q+ulqacgZ0SecTc6KdwkI2oaJppo/GPv2WF6E2hbU=; b=dd55eIzS9s8Tsb
	/P/rIZxcZLiJzoKH0QHbyVg+9a3LjnI3piKU/OjaLN46Xx+zCY5PWzUmf6PPMATbOwuUJtWxIaw+j
	UikB+H9g3m5mH04RAR7R1+ckE+NRokj7UtxKDnWF72FvacqMkU+2Luyb+/ch+BAftFkGX9mPcCUA1
	5vs4dNSQ7NbwMTztpIlNA2yIESW2OVyUxx0e1W/8ESShdlrfftkn/RMrAlTOVpa7B7kT4g9SoyE8u
	4j2uotL6DrHjNSETJALKDO6Q34YpEft1Z6+8sVe1CIXAZSV/pdS0sDVbjC3A3HKyIqRU0NRJOfFr1
	gG9a1wfBpl2ZT4OVZtVQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaIGQ-0000B2-Mn; Fri, 21 Dec 2018 10:42:42 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaIGN-0000AK-NS
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 10:42:41 +0000
Received: by mail-wr1-x441.google.com with SMTP id r10so4715512wrs.10
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 21 Dec 2018 02:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=jaPzZAmw20h/qWuvV1XiTu1ISfjTnDosb69vOB2Vvf4=;
 b=STEMGwRYbuvD//O2x2Aywy9At/Nqrc7NeBa21vM2F8QOyk/iascOjlyYJpEd57rpR+
 Hz1RSP0F0h/IK72oipfG2EhO8emJyjAQ8wmyAJHeF4v1PGusHVOBdagyke6Gr6T9ZKHP
 wg8AACmXXnKOUNw4EYmVbZcpHeuuU8vEvKUtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=jaPzZAmw20h/qWuvV1XiTu1ISfjTnDosb69vOB2Vvf4=;
 b=goQxOvfptV88iOEp8XNYs+igPlXkWGyLtikOH0eolhVPKqwsCIsR48+0U9kJX3dLAu
 sJyM6eQ4HSbQK31VCRhrrbgCsL23NzmXdg1ac51dUPL8V2FvqFdbqLpwOuzp7auLM1Tv
 +azKw2b6vZ2Y6TE6z61DuGipISHez7chZUP5/NIYXfksfR+2R3pUusd+Ffhh6HiIqFor
 sVKx/7dU+0UjWmAtNfHDNdDTRq9yqbTy1IRxIzWfFPWDVhMxUs0EHPZVMcmNiKHSqu8x
 OxIpVLmMRlKD/SjruNkwHEwjIVXtcG5GuSeGMV7mVfP18jDiMxqNf1TNBi/mgoXT8Rvq
 Q5Mw==
X-Gm-Message-State: AJcUukf49RRwTLaDRzff1BII0DX/K5srG+yBMR2r1IEYAnJ6UsYHYnN+
 MTume6bvzi6biu3o9d/MgV70UQ==
X-Google-Smtp-Source: ALg8bN6bfYSHICkT7dES6evQ/J/1jBK3MCV65/jrZP/FOrV50It5XIWXWV3zzCTO9s5JwJXh5rIK/w==
X-Received: by 2002:a5d:6105:: with SMTP id v5mr1960382wrt.63.1545388947209;
 Fri, 21 Dec 2018 02:42:27 -0800 (PST)
Received: from dell ([95.149.164.119])
 by smtp.gmail.com with ESMTPSA id v4sm11947083wme.6.2018.12.21.02.42.26
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 21 Dec 2018 02:42:26 -0800 (PST)
Date: Fri, 21 Dec 2018 10:42:24 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Philippe Schenker <dev@pschenker.ch>
Subject: Re: [PATCH v4 1/8] dt-bindings: stmpe: reformatting parameter list
 and use tabs only
Message-ID: <20181221104224.GL13248@dell>
References: <20181212130649.15146-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181212130649.15146-1-dev@pschenker.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_024239_771523_ED3B7B97 
X-CRM114-Status: GOOD (  13.17  )
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
NDEgaW5zZXJ0aW9ucygrKSwgMjUgZGVsZXRpb25zKC0pCgpGb3IgbXkgb3duIHJlZmVyZW5jZToK
ICBBY2tlZC1mb3ItTUZELWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgoKLS0g
CkxlZSBKb25lcyBb5p2O55C85pavXQpMaW5hcm8gU2VydmljZXMgVGVjaG5pY2FsIExlYWQKTGlu
YXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCkZvbGxvdyBMaW5h
cm86IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
