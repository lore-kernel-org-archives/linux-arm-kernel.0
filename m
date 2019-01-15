Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C12C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:10:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3DAF20645
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="djLCCcb8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="KLD7bOz2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3DAF20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5vCiHIvn1FeQ3gexlyoCwth4PmpYaolZcSrk+kcC47c=; b=djLCCcb8JrB+q+
	BMrhJ3Pp3TtDC7y+/0dqrGVWKqpyUdukA9un5czfxTvpSMc1lpnASdXbecwaHjBRuUGdO/DQtkQ6c
	7fO4XXgDH6vfX0Njee+KmytaxMrs1xFXXH/7Kofqq+eqv10Q8S4IcXCRjFZJBFUiZ95wmZSDHYOjb
	bZM1JJ6F5MpVx/6c4X7maZRBe4/kOV2wOLLndc7JvFAzAKScd5EQ86fxuaRxVmfNAxPCBYuwE9osv
	VGDnONepeWlUdvT3cYutn/xaFgMiTW73N3yA2gAdBk7TruKOhXCcrx+bOAOsUdAScTAnfFawY6mCx
	e5gN3n9P7MgrJ+M70sCQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjQLk-0007D5-Kq; Tue, 15 Jan 2019 15:09:56 +0000
Received: from hqemgate14.nvidia.com ([216.228.121.143])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjQLg-0007CY-87; Tue, 15 Jan 2019 15:09:55 +0000
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c3df7af0001>; Tue, 15 Jan 2019 07:09:35 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 15 Jan 2019 07:09:50 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 15 Jan 2019 07:09:50 -0800
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 15 Jan
 2019 15:09:48 +0000
Subject: Re: [PATCH] ARM: tegra: add "jedec,spi-nor" flash compatible binding
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 <linux-arm-kernel@lists.infradead.org>, Stephen Warren
 <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>,
 <linux-tegra@vger.kernel.org>
References: <1439705605-9127-1-git-send-email-zajec5@gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <cd7aed36-7a89-e129-9db5-16237f9e40e6@nvidia.com>
Date: Tue, 15 Jan 2019 15:09:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1439705605-9127-1-git-send-email-zajec5@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1547564975; bh=U+snIU0hND7TWmvJKzj2Dyq3QtxuoTqz4s45oTuY96g=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=KLD7bOz2NKpyDjRTcXJA8/+/bMbWrqWVuwpuUy5ZDF8Hvr+RZC3o3MlYq+bn8dfhJ
 qf2VW0tSPIWcqBDin1fkoJK4/6cJXW5hPms+8zT/CRPyEKvVvQ9fXiaLpjCGodHvqh
 wa8306UPwqWSquJ1FCyoQHiBzdGf0yuDcf+bRxfRj1QmNkeqC6UQLCYvukBAGzOgNW
 wj2DaiIKPsrIw8MKtzVtbHA/PjExfMgXogPaPcmGrjS/nh+4jw9ZvuEacwx60lyC1a
 m+YCJsnFU5U580O5MJrS0Q5+pcB3y0RmFDDi8lmefSTqk9kfk+eCbMwpsbXPW/X76I
 Kt8fOdkYlC9zg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_070952_300012_D38893B7 
X-CRM114-Status: GOOD (  12.44  )
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
Cc: linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Ck9uIDE2LzA4LzIwMTUgMDc6MTMsIFJhZmHFgiBNacWCZWNraSB3cm90ZToKPiBTdGFydGluZyB3
aXRoIGNvbW1pdCA4OTQ3ZTM5NmE4MjkgKCJEb2N1bWVudGF0aW9uOiBkdDogbXRkOiByZXBsYWNl
Cj4gIm5vci1qZWRlYyIgYmluZGluZyB3aXRoICJqZWRlYywgc3BpLW5vciIiKSB3ZSBoYXZlICJq
ZWRlYyxzcGktbm9yIgo+IGJpbmRpbmcgaW5kaWNhdGluZyBzdXBwb3J0IGZvciBKRURFQyBpZGVu
dGlmaWNhdGlvbi4KPiAKPiBVc2UgaXQgZm9yIGFsbCBmbGFzaGVzIHRoYXQgYXJlIHN1cHBvc2Vk
IHRvIHN1cHBvcnQgUkVBRCBJRCBvcCBhY2NvcmRpbmcKPiB0byB0aGUgZGF0YXNoZWV0cy4KPiAK
PiBTaWduZWQtb2ZmLWJ5OiBSYWZhxYIgTWnFgmVja2kgPHphamVjNUBnbWFpbC5jb20+Cj4gLS0t
Cj4gIGFyY2gvYXJtL2Jvb3QvZHRzL3RlZ3JhMTE0LWRhbG1vcmUuZHRzICAgIHwgMiArLQo+ICBh
cmNoL2FybS9ib290L2R0cy90ZWdyYTEyNC1qZXRzb24tdGsxLmR0cyB8IDIgKy0KPiAgYXJjaC9h
cm0vYm9vdC9kdHMvdGVncmExMjQtbnlhbi5kdHNpICAgICAgfCAyICstCj4gIGFyY2gvYXJtL2Jv
b3QvZHRzL3RlZ3JhMTI0LXZlbmljZTIuZHRzICAgIHwgMiArLQo+ICBhcmNoL2FybS9ib290L2R0
cy90ZWdyYTIwLXRyaW1zbGljZS5kdHMgICB8IDIgKy0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvdGVn
cmEzMC1iZWF2ZXIuZHRzICAgICAgfCAyICstCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL3RlZ3JhMzAt
Y2FyZGh1LmR0c2kgICAgIHwgMiArLQo+ICA3IGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygr
KSwgNyBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvdGVn
cmExMTQtZGFsbW9yZS5kdHMgYi9hcmNoL2FybS9ib290L2R0cy90ZWdyYTExNC1kYWxtb3JlLmR0
cwo+IGluZGV4IDhiN2FhMGQuLjVkZTIzZGUgMTAwNjQ0Cj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9k
dHMvdGVncmExMTQtZGFsbW9yZS5kdHMKPiArKysgYi9hcmNoL2FybS9ib290L2R0cy90ZWdyYTEx
NC1kYWxtb3JlLmR0cwo+IEBAIC0xMDgyLDcgKzEwODIsNyBAQAo+ICAJCXN0YXR1cyA9ICJva2F5
IjsKPiAgCQlzcGktbWF4LWZyZXF1ZW5jeSA9IDwyNTAwMDAwMD47Cj4gIAkJc3BpLWZsYXNoQDAg
ewo+IC0JCQljb21wYXRpYmxlID0gIndpbmJvbmQsdzI1cTMyZHciOwo+ICsJCQljb21wYXRpYmxl
ID0gIndpbmJvbmQsdzI1cTMyZHciLCAiamVkZWMsc3BpLW5vciI7Cj4gIAkJCXJlZyA9IDwwPjsK
PiAgCQkJc3BpLW1heC1mcmVxdWVuY3kgPSA8MjAwMDAwMDA+Owo+ICAJCX07Cj4gZGlmZiAtLWdp
dCBhL2FyY2gvYXJtL2Jvb3QvZHRzL3RlZ3JhMTI0LWpldHNvbi10azEuZHRzIGIvYXJjaC9hcm0v
Ym9vdC9kdHMvdGVncmExMjQtamV0c29uLXRrMS5kdHMKPiBpbmRleCBiZDQzZWQ2Li40NDA5N2M2
IDEwMDY0NAo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL3RlZ3JhMTI0LWpldHNvbi10azEuZHRz
Cj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvdGVncmExMjQtamV0c29uLXRrMS5kdHMKPiBAQCAt
MTYxMSw3ICsxNjExLDcgQEAKPiAgCQlzdGF0dXMgPSAib2theSI7Cj4gIAkJc3BpLW1heC1mcmVx
dWVuY3kgPSA8MjUwMDAwMDA+Owo+ICAJCXNwaS1mbGFzaEAwIHsKPiAtCQkJY29tcGF0aWJsZSA9
ICJ3aW5ib25kLHcyNXEzMmR3IjsKPiArCQkJY29tcGF0aWJsZSA9ICJ3aW5ib25kLHcyNXEzMmR3
IiwgImplZGVjLHNwaS1ub3IiOwo+ICAJCQlyZWcgPSA8MD47Cj4gIAkJCXNwaS1tYXgtZnJlcXVl
bmN5ID0gPDIwMDAwMDAwPjsKPiAgCQl9Owo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0
cy90ZWdyYTEyNC1ueWFuLmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy90ZWdyYTEyNC1ueWFuLmR0
c2kKPiBpbmRleCBhOWFlYzIzLi43ZDI2ZjQ5IDEwMDY0NAo+IC0tLSBhL2FyY2gvYXJtL2Jvb3Qv
ZHRzL3RlZ3JhMTI0LW55YW4uZHRzaQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3RlZ3JhMTI0
LW55YW4uZHRzaQo+IEBAIC0zNDMsNyArMzQzLDcgQEAKPiAgCQlzcGktbWF4LWZyZXF1ZW5jeSA9
IDwyNTAwMDAwMD47Cj4gIAo+ICAJCWZsYXNoQDAgewo+IC0JCQljb21wYXRpYmxlID0gIndpbmJv
bmQsdzI1cTMyZHciOwo+ICsJCQljb21wYXRpYmxlID0gIndpbmJvbmQsdzI1cTMyZHciLCAiamVk
ZWMsc3BpLW5vciI7Cj4gIAkJCXNwaS1tYXgtZnJlcXVlbmN5ID0gPDI1MDAwMDAwPjsKPiAgCQkJ
cmVnID0gPDA+Owo+ICAJCX07Cj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL3RlZ3Jh
MTI0LXZlbmljZTIuZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvdGVncmExMjQtdmVuaWNlMi5kdHMK
PiBpbmRleCA3OWU3MjRiLi40ZGVjYjNjIDEwMDY0NAo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRz
L3RlZ3JhMTI0LXZlbmljZTIuZHRzCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvdGVncmExMjQt
dmVuaWNlMi5kdHMKPiBAQCAtODY2LDcgKzg2Niw3IEBACj4gIAkJc3RhdHVzID0gIm9rYXkiOwo+
ICAJCXNwaS1tYXgtZnJlcXVlbmN5ID0gPDI1MDAwMDAwPjsKPiAgCQlzcGktZmxhc2hAMCB7Cj4g
LQkJCWNvbXBhdGlibGUgPSAid2luYm9uZCx3MjVxMzJkdyI7Cj4gKwkJCWNvbXBhdGlibGUgPSAi
d2luYm9uZCx3MjVxMzJkdyIsICJqZWRlYyxzcGktbm9yIjsKPiAgCQkJcmVnID0gPDA+Owo+ICAJ
CQlzcGktbWF4LWZyZXF1ZW5jeSA9IDwyMDAwMDAwMD47Cj4gIAkJfTsKPiBkaWZmIC0tZ2l0IGEv
YXJjaC9hcm0vYm9vdC9kdHMvdGVncmEyMC10cmltc2xpY2UuZHRzIGIvYXJjaC9hcm0vYm9vdC9k
dHMvdGVncmEyMC10cmltc2xpY2UuZHRzCj4gaW5kZXggZDk5YWY0ZS4uYzRjZmY4YiAxMDA2NDQK
PiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy90ZWdyYTIwLXRyaW1zbGljZS5kdHMKPiArKysgYi9h
cmNoL2FybS9ib290L2R0cy90ZWdyYTIwLXRyaW1zbGljZS5kdHMKPiBAQCAtMjgyLDcgKzI4Miw3
IEBACj4gIAkJc3RhdHVzID0gIm9rYXkiOwo+ICAJCXNwaS1tYXgtZnJlcXVlbmN5ID0gPDQ4MDAw
MDAwPjsKPiAgCQlzcGktZmxhc2hAMCB7Cj4gLQkJCWNvbXBhdGlibGUgPSAid2luYm9uZCx3MjVx
ODBibCI7Cj4gKwkJCWNvbXBhdGlibGUgPSAid2luYm9uZCx3MjVxODBibCIsICJqZWRlYyxzcGkt
bm9yIjsKPiAgCQkJcmVnID0gPDA+Owo+ICAJCQlzcGktbWF4LWZyZXF1ZW5jeSA9IDw0ODAwMDAw
MD47Cj4gIAkJfTsKPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvdGVncmEzMC1iZWF2
ZXIuZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvdGVncmEzMC1iZWF2ZXIuZHRzCj4gaW5kZXggM2Rl
ZGUzOS4uYzlkMjMwYyAxMDA2NDQKPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy90ZWdyYTMwLWJl
YXZlci5kdHMKPiArKysgYi9hcmNoL2FybS9ib290L2R0cy90ZWdyYTMwLWJlYXZlci5kdHMKPiBA
QCAtMTg4NCw3ICsxODg0LDcgQEAKPiAgCQlzdGF0dXMgPSAib2theSI7Cj4gIAkJc3BpLW1heC1m
cmVxdWVuY3kgPSA8MjUwMDAwMDA+Owo+ICAJCXNwaS1mbGFzaEAxIHsKPiAtCQkJY29tcGF0aWJs
ZSA9ICJ3aW5ib25kLHcyNXEzMiI7Cj4gKwkJCWNvbXBhdGlibGUgPSAid2luYm9uZCx3MjVxMzIi
LCAiamVkZWMsc3BpLW5vciI7Cj4gIAkJCXJlZyA9IDwxPjsKPiAgCQkJc3BpLW1heC1mcmVxdWVu
Y3kgPSA8MjAwMDAwMDA+Owo+ICAJCX07Cj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRz
L3RlZ3JhMzAtY2FyZGh1LmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy90ZWdyYTMwLWNhcmRodS5k
dHNpCj4gaW5kZXggYmIxY2ExNS4uZGY3Zjg0NSAxMDA2NDQKPiAtLS0gYS9hcmNoL2FybS9ib290
L2R0cy90ZWdyYTMwLWNhcmRodS5kdHNpCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvdGVncmEz
MC1jYXJkaHUuZHRzaQo+IEBAIC0zNTQsNyArMzU0LDcgQEAKPiAgCQlzdGF0dXMgPSAib2theSI7
Cj4gIAkJc3BpLW1heC1mcmVxdWVuY3kgPSA8MjUwMDAwMDA+Owo+ICAJCXNwaS1mbGFzaEAxIHsK
PiAtCQkJY29tcGF0aWJsZSA9ICJ3aW5ib25kLHcyNXEzMiI7Cj4gKwkJCWNvbXBhdGlibGUgPSAi
d2luYm9uZCx3MjVxMzIiLCAiamVkZWMsc3BpLW5vciI7Cj4gIAkJCXJlZyA9IDwxPjsKPiAgCQkJ
c3BpLW1heC1mcmVxdWVuY3kgPSA8MjAwMDAwMDA+Owo+ICAJCX07Cj4gCgpMb29rcyBsaWtlIHRo
aXMgb25lIGdvdCBsb3N0LCBidXQgc3RpbGwgYXBwbGllcyBjbGVhbmx5IHNvIC4uLgoKQWNrZWQt
Ynk6IEpvbiBIdW50ZXIgPGpvbmF0aGFuaEBudmlkaWEuY29tPgoKQ2hlZXJzCkpvbgoKLS0gCm52
cHVibGljCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
aW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1hcm0ta2VybmVsCg==
