Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0B4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:26:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 473DA20874
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GBRVbKjC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="F2fM7P5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 473DA20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y9X170btnA2IXs/rOaeQIcxBOc2OZkAsFoIQ6N+R3ho=; b=GBRVbKjC6sq+kh
	KT4oTSyZGW2hPONCnWBpg/V6K1VigZk2hf/sOZVdmL2rfAYXLMCkgyg1pM4swPy7T+VJ5KKho+Oya
	hZU/sGshUf3+aNZ7M4XF+7wNaL3xAhxQifCJ/q6E/48Ue+AM2qbbfuGyLbpz99nPPKrWQAGzdnxb2
	qD3ZQy0CsUazZoB0JqW1q4MnRgOgTIp3gB1CUQvqrUSYD7R53AU0HYDymNxnfPTpmbowV5pW6IY3D
	ZVlyraCx8tTQrAzuJPqbZ0CFT95dWNZoXdrvugTinMgMq7JuSdiqwgnDweiH4Xf5XJ9XGlOKQpVHL
	pbBxzH0IH+qu4TV/PgnA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYtqi-00088F-MD; Mon, 17 Dec 2018 14:26:24 +0000
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYtqf-00087a-0s
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 14:26:22 +0000
Received: by mail-lj1-x244.google.com with SMTP id n18-v6so11124005lji.7
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 17 Dec 2018 06:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=uxqLlitBg37c1ZcgUFB5o5pxe7TYEbelEQgP4dAjuLU=;
 b=F2fM7P5dVxMDQkt0t3MIokh8lYVfCopaSwGaJqwFQuSuOjaq90Wfok7rpPg+tITX3s
 BFIecjMyX33yxvMMy4+3oEYZ0RYS6COcDQ5T+a55G4R+6KPzMsEidTlLbJvS6q9oNDSM
 kndygUWhDf7QPF2UtFfzv/6wJNy352fiZ/ifA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=uxqLlitBg37c1ZcgUFB5o5pxe7TYEbelEQgP4dAjuLU=;
 b=WUIpj4Mcrd8VwYh88JWEk41HC4yy6346p+Pv86CLVL5y/4FHgSCiunb7NH/QOKVXVC
 n08DALo47GoBch+LhVWhFbybyIEVUOWiPR2pSMSDmbtmIDhS2HZXuTi52yfVP/vW+DbU
 lg1QG/Y/yGZYZDJb6pZ0FlVizDYTAXXntC4hVgr7InabS1QUSGuEa7B9kG0cI4Pdt6W4
 Z+jkAJebt6KztlNNBi2RaeJib+RVkWAUFyyjwMiNNyY9Qi7qImnKgAK0+ICwIoRkQTpk
 UF18uRvlPzbOlhi8MW1L4hYlUOoZZJvVXR0npM3y55mHUgpc/V+58dIhtWufY3YDjhmY
 bt8A==
X-Gm-Message-State: AA+aEWZ/MwOUeSnNTfsRY+fJnyYXgBjMz83I2+v6QyHmDAQa3NzOLwah
 OPrjX9PQhDUyNgo4Zw/nnoGWvesPKU1c7qGvWVY0JA==
X-Google-Smtp-Source: AFSGD/UtRgD/L41w8j9y2i3GN4pYQ4Pl0RTm1fEzxdBsvbHH3wAzTiHkYtPWbJfODt5l92UAoIM6B8ah9gGNqLCBR4Q=
X-Received: by 2002:a2e:29d7:: with SMTP id
 p84-v6mr7574733ljp.12.1545056768487; 
 Mon, 17 Dec 2018 06:26:08 -0800 (PST)
MIME-Version: 1.0
References: <20181217084313.15379-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20181217084313.15379-1-u.kleine-koenig@pengutronix.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 17 Dec 2018 15:25:56 +0100
Message-ID: <CACRpkdY_fxCWgJ0b435DxzGjeK9q0NrLc+FVPR0LSNEwcUXfrQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: mvebu: only fail on missing clk if pwm is actually
 to be used
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_062621_088018_6B3ED62A 
X-CRM114-Status: GOOD (  10.12  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, stable <stable@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Sascha Hauer <kernel@pengutronix.de>,
 Ralph Sennhauser <ralph.sennhauser@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gTW9uLCBEZWMgMTcsIDIwMTggYXQgOTo0MyBBTSBVd2UgS2xlaW5lLUvDtm5pZwo8dS5rbGVp
bmUta29lbmlnQHBlbmd1dHJvbml4LmRlPiB3cm90ZToKCj4gVGhlIGdwaW8gSVAgb24gQXJtYWRh
IDM3MCBhdCBvZmZzZXQgMHgxODE4MCBoYXMgbmVpdGhlciBhIGNsayBub3IgcHdtCj4gcmVnaXN0
ZXJzLiBTbyB0aGVyZSBpcyBubyBuZWVkIGZvciBhIGNsayBhcyB0aGUgcHdtIGlzbid0IHVzZWQg
YW55aG93Lgo+IFNvIG9ubHkgY2hlY2sgZm9yIHRoZSBjbGsgaW4gdGhlIHByZXNlbmNlIG9mIHRo
ZSBwd20gcmVnaXN0ZXJzLiBUaGlzIGZpeGVzCj4gYSBmYWlsdXJlIHRvIHByb2JlIHRoZSBncGlv
IGRyaXZlciBmb3IgdGhlIGFib3ZlIG1lbnRpb25lZCBncGlvIGRldmljZS4KPgo+IEZpeGVzOiA3
NTc2NDJmOWE1ODQgKCJncGlvOiBtdmVidTogQWRkIGxpbWl0ZWQgUFdNIHN1cHBvcnQiKQo+IFNp
Z25lZC1vZmYtYnk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9u
aXguZGU+CgpQYXRjaCBhcHBsaWVkIGZvciBmaXhlcyB3aXRoIEdyZWdvcnkncyByZXZpZXcgdGFn
IQoKV2lsbCB0cnkgdG8gZ2V0IHRoaXMgdXBzdHJlYW0gd2l0aCBzb21lIG90aGVyIEdQSU8KZml4
ZXMgQVNBUC4KCllvdXJzLApMaW51cyBXYWxsZWlqCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
