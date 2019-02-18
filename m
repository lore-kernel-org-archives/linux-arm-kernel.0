Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FDAC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:20:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03AB121901
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BtmHoOY4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kXmgAKPS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03AB121901
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=3aS6oh4DmfbIpfxyp35aDrgIVdkiDyqJprqqw+ebfZ0=; b=BtmHoOY43s/Bjz7O+v0Uydw9Uy
	VvuJ7SeXaKvZBjmdkg0eagfYksN9uECHjnj7EVrpc4swwpNRUMLRdWXmYalBuesRMQi7Oraz1rcvN
	UiCxRvvV/mqMpNIuehNveLRBNQUL+c5P2kT+12Zsid1aQKv8mrYWlWhZHY6YrE5toeurJyIGPCYh8
	UAW5FJ+yg2rW0b5kNlyTsx5+ySw8bbgTUFphg5TZHqUKL+e8qqiUHZsY0Yc7MDheewmHbkta08cpt
	HUuT6DRAwSuzUZZTDHs+S9UL4G9mTvipTDboq/P+E2fi6xyDUyCqLD/Z9H3V7xVmrxWWKshjY6Lx/
	Rqk093+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvjmK-0008Qr-3R; Mon, 18 Feb 2019 14:20:16 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvjmF-00080g-Gf
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 14:20:13 +0000
Received: by mail-wm1-x344.google.com with SMTP id a62so17581878wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 18 Feb 2019 06:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=ClZXXrP3BYB32DX7heYICw4CsezNlo5nX4c0OSIYVrs=;
 b=kXmgAKPSzKBlErTbTVMwRbNVX5C/bVcgD4Ddc/3EUJDlxf70Bljrs/ZTu/t49hqqje
 hyU5qP81E5t9C9u+juruGkNJI7IV6MVL5GigmXKuwqgC3qZfXjRqElUZ5yF4WlCYBjhT
 JaBcDpFthRsAKQVdU9jxYKesXz93pUFjJraXpFxnOizq3ettppOWVf0gXs0uCQkUJ5TM
 vBCrG6XNkXO08k47y67EXgSUG40Ph75TeVxq4eD06H4frl76UtHBb9tj2ytiGkvE4YQc
 ruMCtxcwjWVuPSH9mj1IY951KdG9XyTbtnHWk/LQZ6JJ2YO2zHYZcMvHZwVk3HaX/sOI
 o82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ClZXXrP3BYB32DX7heYICw4CsezNlo5nX4c0OSIYVrs=;
 b=T8NJCD/48Uicy/cnnYfZgNjjfddqO87Qr9CFtFl3Rz79Gc94lZeKmifshpC3PemAxU
 3zmFBY2MI++zFU20X4NaqRGeP4IbwgN1r/k7oK3s5mH5YyYOfs4EXX2uuxTAe7vuYMRf
 RN/iLbvGfk04+xR2tCyrNtxtRzDNFlYcSK/Qf1XnjRr8R+97hcgHMcpCxqcVd7a9BKPY
 8/MQpTrajmdJglwfiFgU0ed/76O2vGh4bZ1NaOj3ul9rNGgHRERaEdQ7R4uMIk/37YgD
 JkpnzkVUqrnD63ULDcIkwsj7qZGtIArYz9l31qqL8+z4ZpOl+OMZqUF1Dl5yNGl0m9sH
 g+fQ==
X-Gm-Message-State: AHQUAubuS6E9QVm56Kpf5QrzyySzjwzgN12PVpzJZZud+9uUdORcvNyV
 LsVWRGbc0KqOsQ7vP6c06Osdkw==
X-Google-Smtp-Source: AHgI3Ib455TygYVlPC1SJ0oM7R+duaUfW4js4OfK+qogmUfNV65oGh4+/Typu4wLNSWvEwxM/qa/Kg==
X-Received: by 2002:a1c:41c5:: with SMTP id
 o188mr16028078wma.147.1550499609210; 
 Mon, 18 Feb 2019 06:20:09 -0800 (PST)
Received: from [192.168.0.41] (148.125.92.92.rev.sfr.net. [92.92.125.148])
 by smtp.googlemail.com with ESMTPSA id e6sm15839091wrt.14.2019.02.18.06.20.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Feb 2019 06:20:08 -0800 (PST)
Subject: Re: [PATCH 3/8] drivers/clocksource: timer-fsl-ftm: use common header
 for FlexTimer #defines
To: Patrick Havelange <patrick.havelange@essensium.com>,
 Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Thierry Reding <thierry.reding@gmail.com>,
 Esben Haabendal <esben@haabendal.dk>,
 William Breathitt Gray <vilhelm.gray@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <20190218140321.19166-1-patrick.havelange@essensium.com>
 <20190218140321.19166-3-patrick.havelange@essensium.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <5ed4658a-7ef6-91c7-7afa-2f73f038ff95@linaro.org>
Date: Mon, 18 Feb 2019 15:20:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190218140321.19166-3-patrick.havelange@essensium.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_062011_593584_2A323A9C 
X-CRM114-Status: GOOD (  15.19  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gMTgvMDIvMjAxOSAxNTowMywgUGF0cmljayBIYXZlbGFuZ2Ugd3JvdGU6CgpDaGFuZ2Vsb2cg
cGxlYXNlCgo+IFNpZ25lZC1vZmYtYnk6IFBhdHJpY2sgSGF2ZWxhbmdlIDxwYXRyaWNrLmhhdmVs
YW5nZUBlc3NlbnNpdW0uY29tPgo+IFJldmlld2VkLWJ5OiBFc2JlbiBIYWFiZW5kYWwgPGVzYmVu
QGhhYWJlbmRhbC5kaz4KPiAtLS0KPiAgZHJpdmVycy9jbG9ja3NvdXJjZS90aW1lci1mc2wtZnRt
LmMgfCAxNSArKy0tLS0tLS0tLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgMTMgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xvY2tzb3VyY2Uv
dGltZXItZnNsLWZ0bS5jIGIvZHJpdmVycy9jbG9ja3NvdXJjZS90aW1lci1mc2wtZnRtLmMKPiBp
bmRleCA4NDZkMThkYWY4OTMuLmUxYzM0YjJmNTNhNSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2Ns
b2Nrc291cmNlL3RpbWVyLWZzbC1mdG0uYwo+ICsrKyBiL2RyaXZlcnMvY2xvY2tzb3VyY2UvdGlt
ZXItZnNsLWZ0bS5jCj4gQEAgLTE5LDIwICsxOSw5IEBACj4gICNpbmNsdWRlIDxsaW51eC9vZl9p
cnEuaD4KPiAgI2luY2x1ZGUgPGxpbnV4L3NjaGVkX2Nsb2NrLmg+Cj4gICNpbmNsdWRlIDxsaW51
eC9zbGFiLmg+Cj4gKyNpbmNsdWRlIDxsaW51eC9mc2wvZnRtLmg+Cj4gIAo+IC0jZGVmaW5lIEZU
TV9TQwkJMHgwMAo+IC0jZGVmaW5lIEZUTV9TQ19DTEtfU0hJRlQJMwo+IC0jZGVmaW5lIEZUTV9T
Q19DTEtfTUFTSwkoMHgzIDw8IEZUTV9TQ19DTEtfU0hJRlQpCj4gLSNkZWZpbmUgRlRNX1NDX0NM
SyhjKQkoKGMpIDw8IEZUTV9TQ19DTEtfU0hJRlQpCj4gLSNkZWZpbmUgRlRNX1NDX1BTX01BU0sJ
MHg3Cj4gLSNkZWZpbmUgRlRNX1NDX1RPSUUJQklUKDYpCj4gLSNkZWZpbmUgRlRNX1NDX1RPRglC
SVQoNykKPiAtCj4gLSNkZWZpbmUgRlRNX0NOVAkJMHgwNAo+IC0jZGVmaW5lIEZUTV9NT0QJCTB4
MDgKPiAtI2RlZmluZSBGVE1fQ05USU4JMHg0Qwo+IC0KPiAtI2RlZmluZSBGVE1fUFNfTUFYCTcK
PiArI2RlZmluZSBGVE1fU0NfQ0xLKGMpCSgoYykgPDwgRlRNX1NDX0NMS19NQVNLX1NISUZUKQo+
ICAKPiAgc3RydWN0IGZ0bV9jbG9ja19kZXZpY2Ugewo+ICAJdm9pZCBfX2lvbWVtICpjbGtzcmNf
YmFzZTsKPiAKCgotLSAKIDxodHRwOi8vd3d3LmxpbmFyby5vcmcvPiBMaW5hcm8ub3JnIOKUgiBP
cGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MKCkZvbGxvdyBMaW5hcm86ICA8aHR0cDov
L3d3dy5mYWNlYm9vay5jb20vcGFnZXMvTGluYXJvPiBGYWNlYm9vayB8CjxodHRwOi8vdHdpdHRl
ci5jb20vIyEvbGluYXJvb3JnPiBUd2l0dGVyIHwKPGh0dHA6Ly93d3cubGluYXJvLm9yZy9saW5h
cm8tYmxvZy8+IEJsb2cKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1hcm0ta2VybmVsCg==
