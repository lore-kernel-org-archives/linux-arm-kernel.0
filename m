Return-Path: <SRS0=D6bT=PI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF4AC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 23:13:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B10920B1F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 23:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A+uVDZFg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SsctJRJ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B10920B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mu8nQj8tXs8k+EL2LKuP8UMCY/KQVfqoqe+jQj1iTLQ=; b=A+uVDZFgk/sPDoqvULimtxHga
	TWRi6rhtCCY6AS4thR8RCFNNuQnQvPxKrekIk49UhrSWM1xkTbAzna498tYn7XqRa1OknVGe/+IN8
	TxP41e+LSyJbF2hf9LbFJ1vOIiAwsb/+hxD+CiyTOiQFHSQp/KfKd9LdEskWxFPn0u3R6Yo8q5/x1
	zbnGJan4ifxg/2ZKlgeOPJWh/urRLQx45gf0OBMSJFtBFvClVmmAeG+DdB5AIM6X65Pxi142wU9vv
	89Q1IxwHYT90L+Jp/pVZNjygAU5MWqDlTEZs7a0o2a4sHRJtejCT63kk0BNhRpt2sxWQRlU4rVofh
	Fcy8tPc5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ge6kY-0003KT-24; Mon, 31 Dec 2018 23:13:34 +0000
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ge6kV-0003KA-AB
 for linux-arm-kernel@lists.infradead.org; Mon, 31 Dec 2018 23:13:32 +0000
Received: by mail-pl1-x644.google.com with SMTP id z23so13053288plo.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 31 Dec 2018 15:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=yMBeSKQ889w+fJYw7VGEjmN4fDuLhQvIqVZgA3s965A=;
 b=SsctJRJ3shxSsUYEurTjSdE69NoPIVJcFQNXAjlevuy/K6AGcTUmgr1NZEv9nTUAji
 Y4ZWUhKrhonWHawLhGr5AwkTivLEuXoBG2xYDdrF5WkCD/9PDK5JNnng0hbtAG9y7bqb
 1Ok8Cy2qgEj7alM9ATtKranzdvpsIMCXKYXeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=yMBeSKQ889w+fJYw7VGEjmN4fDuLhQvIqVZgA3s965A=;
 b=MmQTtKwDaopMjkCPQC3Yt8DE0Fd1BnkW5UDj2h4yUE3KTON5RuVCW5tt20Wdn4J6/4
 MR2LJxtwooIrEFkjSW2LjHF4nqJeNbHqUEVvztGcfWhs+Au05g5jIdGmeuZvsv8iZshg
 2/+FTj4p1riHv0h8BqF1+SV/95eQwKRHsXYSzfmlet7HvdI0LCXNv+FYt+68+pxrgxu6
 5FlBon49ZWAOPPJHKSdeOpPutimaY8e6HzWBZgoRbQ7cFx/ZWTjDHVhNRsD3RyRqPrdH
 A54UvntJ757gu+ELIfk1AtfV3p5c3i4gx6oBP1Po3vaV0PN9L6rgRAInifj4hlWFfIXl
 rODw==
X-Gm-Message-State: AJcUuke7qyz5f/3HMjfhBTl+Rt8q35I/ZHGj3X2Y0By4OfHDyNn/aPFz
 Uc1Gujb3H7i8uFEbXcMK0+ptgeAicQgtPg==
X-Google-Smtp-Source: ALg8bN5ksP6pCP45Kxc6eQtsVQ6aBgaPZsVJd69BeELZWaSJXQBrHFRVarC7svJwdWQARBmTBmZFsg==
X-Received: by 2002:a17:902:925:: with SMTP id
 34mr37317562plm.14.1546298010145; 
 Mon, 31 Dec 2018 15:13:30 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id l19sm109821977pfi.71.2018.12.31.15.13.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 31 Dec 2018 15:13:29 -0800 (PST)
Subject: Re: [PATCH 1/2] dt-bindings: reset: Add document for Broadcom STB
 reset controller
To: Florian Fainelli <f.fainelli@gmail.com>, p.zabel@pengutronix.de,
 linux-kernel@vger.kernel.org
References: <20181221013409.14324-1-f.fainelli@gmail.com>
 <20181221013409.14324-2-f.fainelli@gmail.com>
From: Scott Branden <scott.branden@broadcom.com>
Message-ID: <67d797f6-fc3a-535c-d336-edcdc70c332e@broadcom.com>
Date: Mon, 31 Dec 2018 15:13:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181221013409.14324-2-f.fainelli@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181231_151331_365158_FADAF627 
X-CRM114-Status: GOOD (  19.08  )
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
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>, Gregory Fong <gregory.0xf0@gmail.com>,
 Brian Norris <computersforpeace@gmail.com>,
 "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Ck9uIDIwMTgtMTItMjAgNTozNCBwLm0uLCBGbG9yaWFuIEZhaW5lbGxpIHdyb3RlOgo+IEFkZCBh
IGJpbmRpbmcgZG9jdW1lbnQgZm9yIHRoZSBCcm9hZGNvbSBTVEIgcmVzZXQgY29udHJvbGxlciwg
YWxzbyBrbm93bgo+IGFzIFNXX0lOSVQtc3R5bGUgcmVzZXQgY29udHJvbGxlci4KPgo+IFNpZ25l
ZC1vZmYtYnk6IEZsb3JpYW4gRmFpbmVsbGkgPGYuZmFpbmVsbGlAZ21haWwuY29tPgo+IC0tLQo+
ICAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvcmVzZXQvYnJjbSxyZXNldC50eHQgIHwgMjcgKysr
KysrKysrKysrKysrKysrKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKykKPiAg
IGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVz
ZXQvYnJjbSxyZXNldC50eHQKPgo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvcmVzZXQvYnJjbSxyZXNldC50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvcmVzZXQvYnJjbSxyZXNldC50eHQKPiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+
IGluZGV4IDAwMDAwMDAwMDAwMC4uNmU1MzQxYjRmODkxCj4gLS0tIC9kZXYvbnVsbAo+ICsrKyBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZXNldC9icmNtLHJlc2V0LnR4dApU
aGlzIGlzIGJyY21zdGItcmVzZXQgc3BlY2lmaWMuwqAgRmlsZSBzaG91bGQgYmUgYnJjbSwgYnJj
bXN0Yi1yZXNldC50eHQKPiBAQCAtMCwwICsxLDI3IEBACj4gK0Jyb2FkY29tIFNUQiBTV19JTklU
LXN0eWxlIHJlc2V0IGNvbnRyb2xsZXIKPiArPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PQo+ICsKPiArQnJvYWRjb20gU1RCIFNvQ3MgaGF2ZSBhIFNXX0lOSVQtc3R5
bGUgcmVzZXQgY29udHJvbGxlciB3aXRoIHNlcGFyYXRlCj4gK1NFVC9DTEVBUi9TVEFUVVMgcmVn
aXN0ZXJzIGFuZCBwb3NzaWJseSBtdWx0aXBsZSBiYW5rcywgZWFjaCBvZiAzMiBiaXQKPiArcmVz
ZXQgbGluZXMuCj4gKwo+ICtQbGVhc2UgYWxzbyByZWZlciB0byByZXNldC50eHQgaW4gdGhpcyBk
aXJlY3RvcnkgZm9yIGNvbW1vbiByZXNldAo+ICtjb250cm9sbGVyIGJpbmRpbmcgdXNhZ2UuCj4g
Kwo+ICtSZXF1aXJlZCBwcm9wZXJ0aWVzOgo+ICstIGNvbXBhdGlibGU6IHNob3VsZCBiZSBicmNt
LGJyY21zdGItcmVzZXQKPiArLSByZWc6IHJlZ2lzdGVyIGJhc2UgYW5kIGxlbmd0aAo+ICstICNy
ZXNldC1jZWxsczogbXVzdCBiZSBzZXQgdG8gMQo+ICsKPiArRXhhbXBsZToKPiArCj4gKwlyZXNl
dDogcmVzZXQtY29udHJvbGxlckA4NDA0MzE4IHsKPiArCQljb21wYXRpYmxlID0gImJyY20sYnJj
bXN0Yi1yZXNldCI7Cj4gKwkJcmVnID0gPDB4ODQwNDMxOCAweDMwPjsKPiArCQkjcmVzZXQtY2Vs
bHMgPSA8MT47Cj4gKwl9Owo+ICsKPiArCSZldGhlcm5ldF9zd2l0Y2ggewo+ICsJCXJlc2V0cyA9
IDwmcmVzZXQ+Owo+ICsJCXJlc2V0LW5hbWVzID0gInN3aXRjaCI7Cj4gKwl9OwoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBt
YWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
