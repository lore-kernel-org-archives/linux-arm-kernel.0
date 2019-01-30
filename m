Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BEAC282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:36:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 951FC20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HpkAv0PW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="L22TyK+P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951FC20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BGMqDuxQVnt4ncsyseuGBoLDfHfs/fBuMpqwDbn43Ac=; b=HpkAv0PWSGjKis
	lrw69+dHjtlKqF1OQzMPHC+uEOkmlHahYzLHjgNZexRJtbRecnWRrpE9uFEOYgQ9/ISOyNz4821r+
	GiJXCYvkoLBS6udNHuzrn0Aa+bD7pAHxbqctEhreFOP4xj6I8Ob/DK64Qx9uBUzrJbfGqzqDy+VCI
	dZfu3H+IMR4P47rgLFf5pgxBAP+Ru8me5/p8gF5PHnpm0cjb5sXg7VeeQz1qVoPhfm4Co0eeSU02z
	YkDm/YsYJiAzN+qsmhY/UIxkoZFQr1AOk//FXvl5IIwDOTubmQofMB2yT7cwEitEvJ83i8Yfy4Tqo
	nkQRiNlknIRrelTYmtUQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goq2G-0003rB-0k; Wed, 30 Jan 2019 13:36:12 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goq2D-0003qc-C5
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 13:36:10 +0000
Received: by mail-wm1-x342.google.com with SMTP id r24so15495921wmh.0
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 30 Jan 2019 05:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=kFbF0FeQdzTBYlHXUUF6ycmN8fz5072JGBoOUv/RLLA=;
 b=L22TyK+Pp5MyMEIWLQ/6o4B19fMzOjUfQb45WtpQis4S5GiBj3sjAZMO9sR4hznDQr
 XVn7lMJkYd68xeX/M9qUQiOTa+2bxMRTUo9UrTA3J2DxvUa/ou5NTUrwTJqItDHlDLd7
 vE1z8ISo55pjn8PAHQNoIj74zMaNu8tcL5lig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=kFbF0FeQdzTBYlHXUUF6ycmN8fz5072JGBoOUv/RLLA=;
 b=OXxEPgRzgTIvFvE7QOiOUM8QQWB6MXha19oRcoQNX6TcG+CJ5JXf+9iqm5an9HhplV
 TI+nYtaMn74QUqc5HxdKq8C78k8mP1Dpi8wuj+ZDQXZc1Hx+AKU1Nc1mfdsVf0TFNt1F
 KI3PPexEotD5/Ry6LH8AgQrPJEpFj/lcyk7vq6cIReHJy6ZHdsyu4vnMC/o5xgxDhTqD
 17uiohEA80eN8covPJ1b0u71o8Zf4Na1e1+kLaGHxUtIX6xa5BdVEmK2vBb6ipK+pb1H
 OCXVKWPYtbjEDWYrY7Z6TomLRQVhsW7JEi3qBBPfpXZjq0TjC0Y8XqX2TH61fsnACGw5
 EVAA==
X-Gm-Message-State: AJcUukej8tV/qArYsX75SzhM5IN8FR+j1+pHWK8i3EdJ5QJr/KRApVB1
 eJTh1KypCT4ytixSrW1+xnSesw==
X-Google-Smtp-Source: ALg8bN4VtjNtbVtDaN9mwpjT06cXPYYAjsqAaMjvkpo5bcBe/H1rp0A7G3j+i4Sloge30ojDL6i21w==
X-Received: by 2002:a1c:19c2:: with SMTP id 185mr26252266wmz.8.1548855367053; 
 Wed, 30 Jan 2019 05:36:07 -0800 (PST)
Received: from dell ([2.27.35.198])
 by smtp.gmail.com with ESMTPSA id f191sm2268436wmg.12.2019.01.30.05.36.06
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 30 Jan 2019 05:36:06 -0800 (PST)
Date: Wed, 30 Jan 2019 13:36:05 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] backlight: pwm_bl: Use gpiod_get_value_cansleep() to get
 initial state
Message-ID: <20190130133605.GI4701@dell>
References: <20190127145054.3770-1-wens@csie.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190127145054.3770-1-wens@csie.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_053609_408344_E5E18B62 
X-CRM114-Status: GOOD (  14.48  )
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
Cc: linux-pwm@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Jingoo Han <jingoohan1@gmail.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Thierry Reding <thierry.reding@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gU3VuLCAyNyBKYW4gMjAxOSwgQ2hlbi1ZdSBUc2FpIHdyb3RlOgoKPiBncGlvZF9nZXRfdmFs
dWUoKSBnaXZlcyBvdXQgYSB3YXJuaW5nIGlmIGFjY2VzcyB0byB0aGUgdW5kZXJseWluZyBncGlv
Y2hpcAo+IHJlcXVpcmVzIHNsZWVwaW5nLCB3aGljaCBpcyBjb21tb24gZm9yIEkyQyBiYXNlZCBj
aGlwczoKPiAKPiAgICAgV0FSTklORzogQ1BVOiAwIFBJRDogNzcgYXQgZHJpdmVycy9ncGlvL2dw
aW9saWIuYzoyNTAwIGdwaW9kX2dldF92YWx1ZSsweGQwLzB4MTAwCj4gICAgIE1vZHVsZXMgbGlu
a2VkIGluOgo+ICAgICBDUFU6IDAgUElEOiA3NyBDb21tOiBrd29ya2VyLzA6MiBOb3QgdGFpbnRl
ZCA0LjE0LjAtcmMzLTAwNTg5LWdmMzI4OTc5MTVkNDgtZGlydHkgIzkwCj4gICAgIEhhcmR3YXJl
IG5hbWU6IEFsbHdpbm5lciBzdW40aS9zdW41aSBGYW1pbGllcwo+ICAgICBXb3JrcXVldWU6IGV2
ZW50cyBkZWZlcnJlZF9wcm9iZV93b3JrX2Z1bmMKPiAgICAgWzxjMDEwZWM1MD5dICh1bndpbmRf
YmFja3RyYWNlKSBmcm9tIFs8YzAxMGI3ODQ+XSAoc2hvd19zdGFjaysweDEwLzB4MTQpCj4gICAg
IFs8YzAxMGI3ODQ+XSAoc2hvd19zdGFjaykgZnJvbSBbPGMwNzk3MjI0Pl0gKGR1bXBfc3RhY2sr
MHg4OC8weDljKQo+ICAgICBbPGMwNzk3MjI0Pl0gKGR1bXBfc3RhY2spIGZyb20gWzxjMDEyNWIw
OD5dIChfX3dhcm4rMHhlOC8weDEwMCkKPiAgICAgWzxjMDEyNWIwOD5dIChfX3dhcm4pIGZyb20g
WzxjMDEyNWJkMD5dICh3YXJuX3Nsb3dwYXRoX251bGwrMHgyMC8weDI4KQo+ICAgICBbPGMwMTI1
YmQwPl0gKHdhcm5fc2xvd3BhdGhfbnVsbCkgZnJvbSBbPGMwMzcwNjljPl0gKGdwaW9kX2dldF92
YWx1ZSsweGQwLzB4MTAwKQo+ICAgICBbPGMwMzcwNjljPl0gKGdwaW9kX2dldF92YWx1ZSkgZnJv
bSBbPGMwMzc3OGQwPl0gKHB3bV9iYWNrbGlnaHRfcHJvYmUrMHgyMzgvMHg1MDgpCj4gICAgIFs8
YzAzNzc4ZDA+XSAocHdtX2JhY2tsaWdodF9wcm9iZSkgZnJvbSBbPGMwNDExYTJjPl0gKHBsYXRm
b3JtX2Rydl9wcm9iZSsweDUwLzB4YWMpCj4gICAgIFs8YzA0MTFhMmM+XSAocGxhdGZvcm1fZHJ2
X3Byb2JlKSBmcm9tIFs8YzA0MTAyMjQ+XSAoZHJpdmVyX3Byb2JlX2RldmljZSsweDIzOC8weDJl
OCkKPiAgICAgWzxjMDQxMDIyND5dIChkcml2ZXJfcHJvYmVfZGV2aWNlKSBmcm9tIFs8YzA0MGU4
MjA+XSAoYnVzX2Zvcl9lYWNoX2RydisweDQ0LzB4OTQpCj4gICAgIFs8YzA0MGU4MjA+XSAoYnVz
X2Zvcl9lYWNoX2RydikgZnJvbSBbPGMwNDBmZjBjPl0gKF9fZGV2aWNlX2F0dGFjaCsweGIwLzB4
MTE0KQo+ICAgICBbPGMwNDBmZjBjPl0gKF9fZGV2aWNlX2F0dGFjaCkgZnJvbSBbPGMwNDBmNGY4
Pl0gKGJ1c19wcm9iZV9kZXZpY2UrMHg4NC8weDhjKQo+ICAgICBbPGMwNDBmNGY4Pl0gKGJ1c19w
cm9iZV9kZXZpY2UpIGZyb20gWzxjMDQwZjk0ND5dIChkZWZlcnJlZF9wcm9iZV93b3JrX2Z1bmMr
MHg1MC8weDE0YykKPiAgICAgWzxjMDQwZjk0ND5dIChkZWZlcnJlZF9wcm9iZV93b3JrX2Z1bmMp
IGZyb20gWzxjMDEzYmU4ND5dIChwcm9jZXNzX29uZV93b3JrKzB4MWVjLzB4NDE0KQo+ICAgICBb
PGMwMTNiZTg0Pl0gKHByb2Nlc3Nfb25lX3dvcmspIGZyb20gWzxjMDEzY2U1Yz5dICh3b3JrZXJf
dGhyZWFkKzB4MmIwLzB4NWEwKQo+ICAgICBbPGMwMTNjZTVjPl0gKHdvcmtlcl90aHJlYWQpIGZy
b20gWzxjMDE0MTkwOD5dIChrdGhyZWFkKzB4MTRjLzB4MTU0KQo+ICAgICBbPGMwMTQxOTA4Pl0g
KGt0aHJlYWQpIGZyb20gWzxjMDEwN2FiMD5dIChyZXRfZnJvbV9mb3JrKzB4MTQvMHgyNCkKPiAK
PiBUaGlzIHdhcyBtaXNzZWQgaW4gY29tbWl0IDBjOTUwMWY4MjNhNCAoImJhY2tsaWdodDogcHdt
X2JsOiBIYW5kbGUgZ3Bpbwo+IHRoYXQgY2FuIHNsZWVwIikuIFRoZSBjb2RlIHdhcyB0aGVuIG1v
dmVkIHRvIGEgc2VwYXJhdGUgZnVuY3Rpb24gaW4KPiBjb21taXQgNzYxM2M5MjIzMTVlICgiYmFj
a2xpZ2h0OiBwd21fYmw6IE1vdmUgdGhlIGNoZWNrcyBmb3IgaW5pdGlhbCBwb3dlcgo+IHN0YXRl
IHRvIGEgc2VwYXJhdGUgZnVuY3Rpb24iKS4KPiAKPiBUaGUgb25seSB1c2FnZSBvZiBncGlvZF9n
ZXRfdmFsdWUoKSBpcyBkdXJpbmcgdGhlIHByb2JlIHN0YWdlLCB3aGljaCBpcwo+IHNhZmUgdG8g
c2xlZXAgaW4uIFN3aXRjaCB0byBncGlvZF9nZXRfdmFsdWVfY2Fuc2xlZXAoKS4KPiAKPiBGaXhl
czogMGM5NTAxZjgyM2E0ICgiYmFja2xpZ2h0OiBwd21fYmw6IEhhbmRsZSBncGlvIHRoYXQgY2Fu
IHNsZWVwIikKPiBTaWduZWQtb2ZmLWJ5OiBDaGVuLVl1IFRzYWkgPHdlbnNAY3NpZS5vcmc+Cj4g
LS0tCj4gIGRyaXZlcnMvdmlkZW8vYmFja2xpZ2h0L3B3bV9ibC5jIHwgMiArLQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCkFwcGxpZWQsIHRoYW5rcy4K
Ci0tIApMZWUgSm9uZXMgW+adjueQvOaWr10KTGluYXJvIFNlcnZpY2VzIFRlY2huaWNhbCBMZWFk
CkxpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29DcwpGb2xsb3cg
TGluYXJvOiBGYWNlYm9vayB8IFR3aXR0ZXIgfCBCbG9nCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdAps
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
