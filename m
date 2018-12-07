Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FDEC07E85
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:59:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC2A22083D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HSr3/+vR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFcw4XOY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC2A22083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hHHQ4P9caMQcCnH+GWzLrK7rOJNmL6iuRb57n8/9rxE=; b=HSr3/+vRiMtS5C
	eTplA8Q+SDrkZeYjR7h/YknIFZWDxZg794+YdI4nskCSEJ6XVTrKDcEVOpPSIq4XnMvlk+ODRrujj
	XSfbMMQPT9L5tMv0k4KZ8bKoj+xuqrGsB1lL62DbaQSkw5gf2rC5uageNTvdQLPzf3sR38pxS54vk
	YnESyuOL/wafrCok+XoudonnDYj0EPCxXOGssgkEw9hG6wbFhS1x5yZw5tJQ57EDJNr5S2NOsvEho
	pF+zIisW45fnCviYjLZEx19TQ7ubINzz3/QsFc43sVGEIABxACUErecmysy7f8IhXdeOz3OQYWABT
	DYLokYZIKunWGR+ghBOw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVLL2-0001fY-81; Fri, 07 Dec 2018 18:59:00 +0000
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVLKz-0001be-7I
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 18:58:58 +0000
Received: by mail-oi1-x241.google.com with SMTP id j21so4188128oii.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 07 Dec 2018 10:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=uqBZCPjpNkexhrwjTJS+KeBj4us7H+/UVMQZ3/Fjv38=;
 b=QFcw4XOYfPDdzrpw2tsVkTkNGIJDf32n9DHxhEFr9AQA3lw/bp/FDfWsIRoALLK83p
 Peal6XfNYxpIzMWF1X4W9IO95sVhr5bnsGe3Mf7oUw3V3KtX849Nt05Jcl0unwgzwQZ0
 AWXwGZhoyc9bgrJAXH5jPKK1VBxc/MY3Re/TZDcyDGBwruspjKXZqzBt3NALU2PY4Uqa
 Pqf3JyT5Cvku2iKoozdQgk+934HV15l4wwwqbCg/n8ESp4UdueEtBQDIkLEugraH0B1N
 e3VyQSCxygQSq15s1u67GBFA8YjWaeU2kW0CjXu5GAwBUCcz6auWqoT2F8qRVBg9cEQY
 QyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=uqBZCPjpNkexhrwjTJS+KeBj4us7H+/UVMQZ3/Fjv38=;
 b=OKVKp8W0S2g6Bz8TNCIRqV3JJqNYjys/T3GjM5GOsycSIzg28+x3ijuHI9UB9iMOCk
 ZM4MJOpx13lTo/4ZYxl/ulY7HWJ2/ErLm3dOv+vO9ETVpf+Z3B8TYBbrUtGkCRTHSJkv
 gS0nUV+To0ast7+TcDPCeYgBfEiYpDo+4oo/joiWE/pRFi0S7eER1ShIEtSwWST0oX4t
 Vh4S1t8ZIteQhPK7PaK3dcHxo3L12jCghCzLMhgAXuSXitdQkf0ExMd9l015tuIoSzWv
 QM1voAVtSjlu3CIhKnsDtQKC5HmCnfAk/R/+3T+wQHXLoqTPwW6dxLGtFPU4UOep4IHn
 oCZQ==
X-Gm-Message-State: AA+aEWaBAzHT34yT73JicqKFXkqUXxVDIbj1vpawO44VetPOgYRPQOu1
 aZjX4+VLi+RI+18zbK8eGtsFFRJVMz8q6C2NEeo=
X-Google-Smtp-Source: AFSGD/WiWGXnBIRXCBpLzZcg1Dnyo3MhDmfO3spE34fENs/5D6oFkxLCYSdDMvUyRwLCyDZML2tixIVbxJDA/znoJhw=
X-Received: by 2002:aca:6545:: with SMTP id j5mr1967927oiw.70.1544209125845;
 Fri, 07 Dec 2018 10:58:45 -0800 (PST)
MIME-Version: 1.0
References: <20181120175211.3913-1-oskari@lemmela.net>
 <20181120175211.3913-9-oskari@lemmela.net>
 <20181207164011.GI26661@dell>
In-Reply-To: <20181207164011.GI26661@dell>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Fri, 7 Dec 2018 10:58:22 -0800
Message-ID: <CA+E=qVe5gau_9A6WsdqDaEJwdJ7EyQ=UcNu0JJV3v=hKAFU7GQ@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] mfd: axp20x: Add supported cells for AXP803
To: Lee Jones <lee.jones@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_105857_265741_C69C33DE 
X-CRM114-Status: GOOD (  11.97  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 devicetree <devicetree@vger.kernel.org>, quentin.schulz@bootlin.com,
 linux-pm@vger.kernel.org, Maxime Ripard <maxime.ripard@bootlin.com>,
 Sebastian Reichel <sre@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Oskari Lemmela <oskari@lemmela.net>,
 arm-linux <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gRnJpLCBEZWMgNywgMjAxOCBhdCA4OjQwIEFNIExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFy
by5vcmc+IHdyb3RlOgoKPiBNeSBPQ0QtZGFyIGlzIGdvaW5nIGNyYXp5Lgo+Cj4gV2h5IGhhdmVu
J3QgeW91IHVzZWQgdGhlIHNhbWUgYWxpZ25tZW50IGFzIGlzIGFscmVhZHkgdGhlcmU/Cj4KPiBJ
ZiBpdCBzdGFydHMgdG8gcnVuIG92ZXIgODAtY2hhcnMgdGhlbiBicmluZyB0aGUgb3RoZXJzIGJh
Y2suCj4KPiBBbHNvIHdoeSBpcyB0aGVyZSBhIHNpbmdsZSBsaW5lciBzaG92ZWQgaW4gdGhlIG1p
ZGRsZSBvZiB0aGUKPiBtdWx0aS1saW5lIGVudHJpZXM/ICBQbGVhc2UgbW92ZSB0aGUgc2luZ2xl
cyB0byB0aGUgdG9wIG9yIHRoZQo+IGJvdHRvbS4KCkhpIExlZSwKCkNvdWxkIHlvdSBwbGVhc2Ug
cmVmb3JtYXQgaXQgaW4gdGhlIHdheSB0aGF0IG1ha2VzIHlvdXIgT0NELWRhciBoYXBweT8KSXQg
d291bGQgYmUgcmVhbGx5IG5pY2UgdG8gZ2V0CkFDIGFuZCBiYXR0ZXJ5IHN1cHBvcnQgZm9yIEFQ
WDh4MyBtZXJnZWQgLS0gaXQnbGwgbWFrZSBQaW5lYm9vayBhbmQKVGVyZXMtSSBwcmV0dHkgd2Vs
bCBzdXBwb3J0ZWQgYnkgbWFpbmxpbmUga2VybmVsLgoKVGhhbmtzLApWYXNpbHkKCj4KPiAtLQo+
IExlZSBKb25lcyBb5p2O55C85pavXQo+IExpbmFybyBTZXJ2aWNlcyBUZWNobmljYWwgTGVhZAo+
IExpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29Dcwo+IEZvbGxv
dyBMaW5hcm86IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0
CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
