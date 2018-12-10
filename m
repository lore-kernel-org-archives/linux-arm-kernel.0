Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB815C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 06:27:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AC2A205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 06:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cFrv8ArF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S1+lRXL1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AC2A205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2lpE65kvQu/AEWzOyQKYIMaPgNn3Olm8JH/fzZt5Sl8=; b=cFrv8ArFutwmcD
	kMeaLTE2+BiVMPs1NMrik59N8ys5ggOtRCwvdRYk3XCKTrBMnlQdViznRl+s0LN71RukOOVGyh9yj
	S4AlRIVsh40CnG2T50L488WxZfK9w3pRq46X+8tp6Wnx3//6d4CKvQB0SSRi1otgbiZV0KaOkYFiz
	VCWeaYGEzfU/X+SkrhfvrKh86H7PaOl3aCF5aVMmUWof38jmHuzGqei4I47DrZD+AF1vTpetBuMSQ
	MU7gjqIW1bZ05ZbhmTVqQmcKyONC1ZPXwMaz4eY67i6OEpgmRVg1UWuwVt2c8N35U6cfFp+RYfO8b
	J3n7yF3XSMCLumNL/roA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWF2p-00052V-6y; Mon, 10 Dec 2018 06:27:55 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWF2k-0004pl-Mq
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 06:27:52 +0000
Received: by mail-wr1-x444.google.com with SMTP id t27so9170285wra.6
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 09 Dec 2018 22:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=GgtI/LiKafLWJ7kHLvEEuNGmxZPMICEtdKv4VHE8MM8=;
 b=S1+lRXL1DM/hVE5GXqSJmqrCRiGnRMaX2mSqbYLj0g4fuh7IKKGCUYA15s8E6VTaJk
 J9sBkoTbBOlsQcVxXoL/o1N8DA+5elfVXYAz+ogrec7aph47qHGWF9rzq0tk0qCzOQPp
 FODFTztHoNpAl6DXP7VXiQd8N6BJhgSLE86qk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=GgtI/LiKafLWJ7kHLvEEuNGmxZPMICEtdKv4VHE8MM8=;
 b=XwQwu+GynLOahB7hdUSqaYNJo99RI+JsSKUOuwI9095xEpk3m7jsoLT/qNX769nOwF
 bQZW+antbs+HuNISDAQwfWDLjIQeLUApC+u8d6IxHKHHgAGI28MbTh5abTpPN+hkFMVt
 pJVXVAqvJGtIqrW9aawPuLy/d++2/48KAoXwAANmq8HO2BGPU8r43YQPJsxo5df8gwzC
 GXLoGLAiIT9NYNHA2Kr/apLo0f1+DYn2TVlu8IXRhnb2zQiAVwvqZ46s1Pd/xk7DH3d5
 NweptBx0Cq+TXgSLNnTFdO7jPtEKlGpV7x+YG0SCjiTJv80lyq8Q76poYLIBhdAcovcl
 5tAQ==
X-Gm-Message-State: AA+aEWb34EiArgDHGk3XJ8uqgGzUy4NUMd9+AGOnpkGlF8SCapQSHNhy
 iP1iTKpMugxBlrxjtlhCaS7/+Q==
X-Google-Smtp-Source: AFSGD/XQnhoOhg+tjB/LEQ/fOMwuNhYYeNsEnp2m+yryhmI7A6p5R9YahmhHUyJgeRgAj5v5qAsl5g==
X-Received: by 2002:adf:f401:: with SMTP id g1mr9001079wro.103.1544423258412; 
 Sun, 09 Dec 2018 22:27:38 -0800 (PST)
Received: from dell (host109-155-202-221.range109-155.btcentralplus.com.
 [109.155.202.221])
 by smtp.gmail.com with ESMTPSA id h13sm7905806wrp.61.2018.12.09.22.27.37
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 09 Dec 2018 22:27:37 -0800 (PST)
Date: Mon, 10 Dec 2018 06:27:39 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Oskari Lemmela <oskari@lemmela.net>
Subject: Re: [PATCH v6 8/8] mfd: axp20x: Add supported cells for AXP803
Message-ID: <20181210062739.GP26661@dell>
References: <20181120175211.3913-1-oskari@lemmela.net>
 <20181120175211.3913-9-oskari@lemmela.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181120175211.3913-9-oskari@lemmela.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181209_222750_779944_31C6BDF7 
X-CRM114-Status: GOOD (  10.50  )
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
 Quentin Schulz <quentin.schulz@bootlin.com>, linux-pm@vger.kernel.org,
 Maxime Ripard <maxime.ripard@bootlin.com>, Sebastian Reichel <sre@kernel.org>,
 linux-kernel@vger.kernel.org, Vasily Khoruzhick <anarsoul@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

T24gVHVlLCAyMCBOb3YgMjAxOCwgT3NrYXJpIExlbW1lbGEgd3JvdGU6Cgo+IFBhcnRzIG9mIHRo
ZSBBWFA4MDMgYXJlIGNvbXBhdGlibGUgd2l0aCB0aGVpciBjb3VudGVycGFydHMgb24gdGhlIEFY
UDgxMy4KPiBUaGVzZSBpbmNsdWRlIHRoZSBHUElPLCBBREMsIEFDIGFuZCBiYXR0ZXJ5IHBvd2Vy
IHN1cHBsaWVzLgo+IAo+IFNpZ25lZC1vZmYtYnk6IE9za2FyaSBMZW1tZWxhIDxvc2thcmlAbGVt
bWVsYS5uZXQ+Cj4gUmV2aWV3ZWQtYnk6IENoZW4tWXUgVHNhaSA8d2Vuc0Bjc2llLm9yZz4KPiBU
ZXN0ZWQtYnk6IFZhc2lseSBLaG9ydXpoaWNrIDxhbmFyc291bEBnbWFpbC5jb20+Cj4gLS0tCj4g
IGRyaXZlcnMvbWZkL2F4cDIweC5jIHwgMTUgKysrKysrKysrKysrKysrCj4gIDEgZmlsZSBjaGFu
Z2VkLCAxNSBpbnNlcnRpb25zKCspCgpBcHBsaWVkLCB0aGFua3MuCgotLSAKTGVlIEpvbmVzIFvm
nY7nkLzmlq9dCkxpbmFybyBTZXJ2aWNlcyBUZWNobmljYWwgTGVhZApMaW5hcm8ub3JnIOKUgiBP
cGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MKRm9sbG93IExpbmFybzogRmFjZWJvb2sg
fCBUd2l0dGVyIHwgQmxvZwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtYXJtLWtlcm5lbAo=
