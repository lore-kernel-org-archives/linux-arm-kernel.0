Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCB7C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:13:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3700521920
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MzIKTmop"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3700521920
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=d/eNeV4TUDC4/WeXN6YnH8k0+g56VizHajwztEUqSl0=; b=MzIKTmopRl9Gyf+JpBoAQ5AEt
	NoChsTIMRzilXU4d5gqU+tUEMhl/KW41l5lQBFqFx4N++4KQeSt44IO9ZmPtMFZ0ProMdUPutH3H+
	r69pfarTYDVbh8zuj7sgMh+1fE0ivCqikMlmZWlXWsa2fRlF3pch/+6jvxOzL38Pl7YYF8BbJeauQ
	7iG4po+YP9nd8tbMs0VqnvwjWnOumIk3jInWSOleOfcPduw4yaB+zhjiIM2xX5fKvkqxQMRxoEoQ3
	ioRwmqeegoKc/P+tnWD4uCJhai96ZTWD90vNq7WmbrZ2cCbKVUlcZrUH+Z/IZI+tbC7JMF0Wnkz3o
	1VnN2Txkw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaT2b-000348-7q; Fri, 21 Dec 2018 22:13:09 +0000
Received: from smtp4-g21.free.fr ([2a01:e0c:1:1599::13])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaT2W-00032p-SS; Fri, 21 Dec 2018 22:13:06 +0000
Received: from [192.168.2.7] (unknown [78.218.214.33])
 by smtp4-g21.free.fr (Postfix) with ESMTP id 5EBD119F591;
 Fri, 21 Dec 2018 23:12:44 +0100 (CET)
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: amlogic: add amediatech x96-max
 bindings
To: Kevin Hilman <khilman@baylibre.com>, linux-amlogic@lists.infradead.org
References: <20181219233519.35287-1-khilman@baylibre.com>
From: Chris Moore <moore@free.fr>
Message-ID: <dc14926f-4433-fa7b-311f-cb275a7e7aee@free.fr>
Date: Fri, 21 Dec 2018 23:12:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181219233519.35287-1-khilman@baylibre.com>
Content-Language: fr
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_141305_061368_4DBE3B37 
X-CRM114-Status: GOOD (  11.10  )
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
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

SGksCgpTb3JyeSBmb3IgdGhlIHJlcGVhdCA6IEkgcmVwbGllZCBwcmV2aW91c2x5IHRvIHYxIGFz
IEkgaGFkbid0IG5vdGljZWQgCnRoYXQgdGhlcmUgd2FzIGFscmVhZHkgYSB2Mi4KCkxlIDIwLzEy
LzIwMTggw6AgMDA6MzUsIEtldmluIEhpbG1hbiBhIMOpY3JpdMKgOgo+IEFkZCBuZXcgdmVuZG9y
IGZvciBhbWVkaWF0ZWNoLCBhbmQgaW5pdGlhbCBib2FyZDogeDk2LW1heAo+Cj4gU2lnbmVkLW9m
Zi1ieTogS2V2aW4gSGlsbWFuIDxraGlsbWFuQGJheWxpYnJlLmNvbT4KPiAtLS0KPiAgIERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vYW1sb2dpYy50eHQgICAgIHwgMSArCj4g
ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdmVuZG9yLXByZWZpeGVzLnR4dCB8
IDEgKwo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQg
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2FtbG9naWMudHh0IGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9hbWxvZ2ljLnR4dAo+IGluZGV4IDhk
YmMyNTkwODFlNC4uYzUwYjA4NGI2YzU5IDEwMDY0NAo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9hcm0vYW1sb2dpYy50eHQKPiArKysgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvYXJtL2FtbG9naWMudHh0Cj4gQEAgLTk5LDYgKzk5LDcgQEAgQm9h
cmQgY29tcGF0aWJsZSB2YWx1ZXMgKGFscGhhYmV0aWNhbGx5LCBncm91cGVkIGJ5IFNvQyk6Cj4g
ICAgIC0gImFtbG9naWMscDI4MSIgKE1lc29uIGd4bCBzOTA1dykKPiAgICAgLSAib3JhbnRoLHR4
My1taW5pIiAoTWVzb24gZ3hsIHM5MDV3KQo+ICAgCj4gKyAgLSAiYW1lZGlhdGVjaCx4OTYtbWF4
IiAoTWVzb24gZ3htIHM5MTIpCgpTaG91bGRuJ3QgdGhhdCBiZSBNZXNvbiBnMTJhIHM5MDV4MiA/
CgpDaGVlcnMsCkNocmlzCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
