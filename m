Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EA2C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:28:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB9BB2084C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CWcg0/jY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TJfjIkH8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9BB2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Pj8A29mQ6Ocz08hSqJ1wyNTJS+anPTpGbI7agA708uo=; b=CWcg0/jYTsNDsmcH3XFJsZrN1
	u8npTTI8R4rqH9O4gnk/HOpGOEhbLPrg4u2bcRKM89q7dUpWFHuBNureSrnM76+zOxn1MDRv5UKFj
	C9m5bDz7GjzK7wO7qxd5MhPqQUOnQsvrocmxB+0CDum/2l1Ywzd/oL2uqTtwBzLTh9TL1qSXLBpYv
	bOReCkSOxCnD0z7tG9hb1fdXU1N7b1/K0YUnA3MQsOjrFE3WGvU2iXWHWRG+mpI01oGU95aAOk6z4
	CTQ/PtACVbCU8+J1AAn+mTZqwNU9bf6F1aLmA2gsdpEV2vqxj+zuykqwQi/yhSrZWEPrl4bI7gJ5V
	wPekC5aUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi4ML-0003ym-5w; Fri, 11 Jan 2019 21:28:57 +0000
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi4MH-0003xs-Hd
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 21:28:55 +0000
Received: by mail-yb1-xb43.google.com with SMTP id s17so163194ybp.6
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 13:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=PW+iFYKiZXJTOX93yIrYnuspfcNtG9ovkhcDVYkM07w=;
 b=TJfjIkH8TO3Qk/oz9gnIatmU8kPP/dYNSE8g6nonTzrgxX8fkbQ+jPI+niDmjYDrXe
 dmGr9VE0FzgOkHkEKbM5G3srY/JC1PuUQ1GNLlW6NvWZNCGiJ+BD3vtSfO1JwYC1cS+4
 V/x7zmxDGJH7im4xAM8VSxIzabErqi9+yvUMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=PW+iFYKiZXJTOX93yIrYnuspfcNtG9ovkhcDVYkM07w=;
 b=brjzwdlP8sx28pmJlfKMdmeinVQeIzpbrYIZjYj4Fq0F6AuC3HnME9AIkpLL4vfNQY
 uyWO/J62vzFuYcmXjNnfdTR2D37y9Yb2BJYSiPJtCqi8u4jq0PaLPooB3kEfhfB/3IQx
 GZ1CDVOPAkzIT4jWCL8ZdZQeAxAdtYozTd+3hg7Sh3evNxLM7PcrUtKP/mpNEneg1otS
 Z80+wbz8096P76s3Tb5DXsV3XYh9TtATxQQXL2Wn8gIeOv7zqB/fFckpDsYP3WKQMANx
 7o7lxdX1jeOErqk2E4QqJXyyJ73byXprXCzeX81It2rwjV0YzX/WvGEPVP8PjFb7ppWk
 ZrKg==
X-Gm-Message-State: AJcUukcgQYaDqjSxNYoQSfBaBgtYUe55+ExmVuO8A2K76BYhcqtX6eBC
 0MVs8rCofDLBKV2jp8WpnVlunw==
X-Google-Smtp-Source: ALg8bN6iQIhBjir5hLQlVAfbqJ7QYklFND9ZiZB4pJlTYGzS5alwjTXx+lmKirBAk8vFXD4vvT5wFA==
X-Received: by 2002:a25:ad28:: with SMTP id y40mr8794374ybi.338.1547242130687; 
 Fri, 11 Jan 2019 13:28:50 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id m126sm28904083ywd.39.2019.01.11.13.28.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 11 Jan 2019 13:28:49 -0800 (PST)
Subject: Re: [PATCH 1/3] dt-bindings: pwm: kona: Add new compatible for new
 version pwm-kona
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
References: <1547184076-20521-1-git-send-email-sheetal.tigadoli@broadcom.com>
 <1547184076-20521-2-git-send-email-sheetal.tigadoli@broadcom.com>
 <20190111204801.2ytdeblcai7lg3on@pengutronix.de>
From: Scott Branden <scott.branden@broadcom.com>
Message-ID: <f1ec3121-a8e7-a1c0-008a-ea4ae6028157@broadcom.com>
Date: Fri, 11 Jan 2019 13:28:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190111204801.2ytdeblcai7lg3on@pengutronix.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_132853_595835_01A129F3 
X-CRM114-Status: GOOD (  17.61  )
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
Cc: linux-pwm@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
 Scott Branden <sbranden@broadcom.com>, devicetree@vger.kernel.org,
 Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 bcm-kernel-feedback-list@broadcom.com,
 Praveen Kumar B <praveen.b@broadcom.com>, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGkgVXdlCgpPbiAyMDE5LTAxLTExIDEyOjQ4IHAubS4sIFV3ZSBLbGVpbmUtS8O2bmlnIHdyb3Rl
Ogo+IE9uIEZyaSwgSmFuIDExLCAyMDE5IGF0IDEwOjUxOjE0QU0gKzA1MzAsIFNoZWV0YWwgVGln
YWRvbGkgd3JvdGU6Cj4+IEZyb206IFByYXZlZW4gS3VtYXIgQiA8cHJhdmVlbi5iQGJyb2FkY29t
LmNvbT4KPj4KPj4gQWRkIG5ldyBjb21wYXRpYmxlIHN0cmluZyBmb3IgbmV3IHZlcnNpb24gb2Yg
cHdtLWtvbmEKPj4KPj4gU2lnbmVkLW9mZi1ieTogUHJhdmVlbiBLdW1hciBCIDxwcmF2ZWVuLmJA
YnJvYWRjb20uY29tPgo+PiBSZXZpZXdlZC1ieTogUmF5IEp1aSA8cmF5Lmp1aUBicm9hZGNvbS5j
b20+Cj4+IFJldmlld2VkLWJ5OiBTY290dCBCcmFuZGVuIDxzY290dC5icmFuZGVuQGJyb2FkY29t
LmNvbT4KPj4gU2lnbmVkLW9mZi1ieTogU2hlZXRhbCBUaWdhZG9saSA8c2hlZXRhbC50aWdhZG9s
aUBicm9hZGNvbS5jb20+Cj4+IC0tLQo+PiAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9wd20vYnJjbSxrb25hLXB3bS50eHQgfCAyICstCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL2JyY20sa29uYS1wd20udHh0IGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9icmNtLGtvbmEtcHdtLnR4dAo+PiBpbmRleCA4
ZWFlOWZlLi5kMzdmNjk3IDEwMDY0NAo+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvcHdtL2JyY20sa29uYS1wd20udHh0Cj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9wd20vYnJjbSxrb25hLXB3bS50eHQKPj4gQEAgLTMsNyArMyw3IEBA
IEJyb2FkY29tIEtvbmEgUFdNIGNvbnRyb2xsZXIgZGV2aWNlIHRyZWUgYmluZGluZ3MKPj4gICBU
aGlzIGNvbnRyb2xsZXIgaGFzIDYgY2hhbm5lbHMuCj4+ICAgCj4+ICAgUmVxdWlyZWQgUHJvcGVy
dGllcyA6Cj4+IC0tIGNvbXBhdGlibGU6IHNob3VsZCBjb250YWluICJicmNtLGtvbmEtcHdtIgo+
PiArLSBjb21wYXRpYmxlOiBzaG91bGQgY29udGFpbiAiYnJjbSxrb25hLXB3bSIgb3IgImJyY20s
a29uYS1wd20tdjIiCj4gSXMgdjIgdXNlZCBvbiBhIG5ld2VyIGdlbmVyYXRpb24gb2Yga29uYSBT
b0NzPyBPbiBpLk1YIHRoZXNlIHZhcmlhbnRzCj4gYXJlIHVzdWFsbHkgbmFtZWQgYWZ0ZXIgdGhl
IGZpcnN0IFNvQyB0aGF0IGNhbWUgd2l0aCB0aGUgbmV3IHZhcmlhbnQuIElzCj4gdGhpcyBzZW5z
aWJsZSBoZXJlLCB0b28/CgpJdCBkb2Vzbid0IG1ha2UgYXMgbXVjaCBzZW5zZSBoZXJlIGFzIGRp
ZmZlcmVudCByZXZzIG9mIHRoZSBJUCBibG9jayBhcmUgCnBpY2tlZCB1cCBiYXNlZCBvbiB2YXJp
b3VzIGRlY2lzaW9ucy4KCkEgbmV3IFNvQyBjb3VsZCBkZWNpZGUgdG8gdXNlIGFuIG9sZCB2ZXJz
aW9uLgoKPgo+IEJlc3QgcmVnYXJkcwo+IFV3ZQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
